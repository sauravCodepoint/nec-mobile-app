import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:share_plus/share_plus.dart';

import '../../../application/transaction_history/transaction_history_bloc.dart';
import '../../routes/app_navigation_guard.dart';
import '../bottom_sheet/app_transaction_bottom_sheet .dart';
import '../notify/app_notify.dart';

/// Wraps [child] with the one-shot reactions a screen needs in order to open a
/// transaction from an [AppTransactionTile] outside the transaction-history
/// page: the details bottom sheet, its receipt download/share, and the error
/// dialogs for both.
///
/// The transaction-details and receipt endpoints already live in
/// [TransactionHistoryBloc] (globally provided in `app_widget.dart`), so a
/// second screen showing transactions — the home page's Recent Transactions
/// section — reuses them from here instead of duplicating the fetch, the PDF
/// handling and the sheet into its own feature.
///
/// **Route guard.** Every mounted listener on the same BLoC fires for the same
/// emit, and the home page stays in the tree while the history page sits on top
/// of it — without a guard one tap there would open two identical sheets. Each
/// listener therefore only reacts while its own route is the visible one.
class AppTransactionDetailsListener extends StatelessWidget {
  final Widget child;

  const AppTransactionDetailsListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionHistoryBloc, TransactionHistoryState>(
      listenWhen: (previous, current) =>
          (previous.transactionHistoryDetailsSuccessOrFailureOption !=
                  current.transactionHistoryDetailsSuccessOrFailureOption &&
              current.transactionHistoryDetailsSuccessOrFailureOption
                  .isSome()) ||
          (previous.downloadOrShareReceiptSuccessOrFailureOption !=
                  current.downloadOrShareReceiptSuccessOrFailureOption &&
              current.downloadOrShareReceiptSuccessOrFailureOption.isSome()),
      listener: (context, state) {
        // Only the screen the user is actually looking at responds — see the
        // route guard note above. `isScreenActive` is the app-wide rule
        // (`routes/app_navigation_guard.dart`): it also covers home sitting
        // behind another MainPage tab, where the route is still the top one.
        // The stricter `isCurrentOf` stays on top of it purely as the de-dupe:
        // while a route above animates out, both listeners would otherwise
        // count as active for a few frames and open two sheets.
        if (!context.isScreenActive) return;
        if (ModalRoute.isCurrentOf(context) != true) return;

        state.transactionHistoryDetailsSuccessOrFailureOption.fold(() {}, (
          either,
        ) {
          either.fold(
            (_) {
              HapticFeedback.heavyImpact();
              AppNotify.dialog(
                message:
                    'transactionHistory.errors.unableToGetTransactionHistoryDetails'
                        .tr(),
                type: AppDialogType.warning,
                buttonText: 'buttons.ok'.tr(),
              );
            },
            (_) {
              final detailsDto = state.transactionHistoryDetailsDto;
              AppTransactionBottomSheet.show(
                context,
                transaction: detailsDto,
                downloadOnTap: () =>
                    _requestReceipt(context, state: state, isDownload: true),
                shareOnTap: () =>
                    _requestReceipt(context, state: state, isDownload: false),
              );
            },
          );
        });

        state.downloadOrShareReceiptSuccessOrFailureOption.fold(() {}, (
          either,
        ) {
          either.fold(
            (_) {
              HapticFeedback.heavyImpact();
              AppNotify.dialog(
                message:
                    'transactionHistory.errors.unableToDownloadOrShareTransactionHistoryReceipt'
                        .tr(),
                type: AppDialogType.warning,
                buttonText: 'buttons.ok'.tr(),
              );
            },
            (filePath) async {
              if (state.isDownloadingReceipt) {
                await OpenFile.open(filePath);
              } else {
                await SharePlus.instance.share(
                  ShareParams(
                    files: [XFile(filePath)],
                    text: 'transactionHistory.shareReceiptText'.tr(),
                  ),
                );
              }
            },
          );
        });
      },
      child: child,
    );
  }

  /// Closes the details sheet and asks for the receipt PDF. A transaction
  /// without a reference has nothing to print, so it reports that instead of
  /// firing a request that can only fail.
  void _requestReceipt(
    BuildContext context, {
    required TransactionHistoryState state,
    required bool isDownload,
  }) {
    final transaction = state.transactionHistoryDetailsDto?.data?.transaction;
    final transactionReference = transaction?.transactionReference;
    if (transactionReference == null) {
      AppNotify.toast(
        isDownload
            ? 'transactionHistory.errors.transactionReferenceNotFound'.tr()
            : 'transactionHistory.errors.transactionReferenceNotFoundShare'
                  .tr(),
        type: AppToastType.error,
      );
      return;
    }
    Navigator.of(context).pop();
    context.read<TransactionHistoryBloc>().add(
      TransactionHistoryEvent.downloadOrShareTransactionReceipt(
        transactionReference: transactionReference,
        isDownload: isDownload,
        status: transaction?.appStatus,
      ),
    );
  }
}
