import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../application/home/home_bloc.dart';
import '../../../application/transaction_history/transaction_history_bloc.dart';
import '../../core/shimmer/app_shimmer.dart';
import '../../core/theme/app_theme_ext.dart';
import '../../core/transaction_tile/app_transaction_tile.dart';
import '../../routes/app_routes.gr.dart';
import 'home_inline_notice.dart';

/// The five most recent transactions, at the foot of the home page, with a
/// "View All" shortcut into the full transaction history.
///
/// Home fetches a whole first page of the transaction list and renders only the
/// newest [_maxItems] of it: the section is a glance at what the user last did,
/// not a second history screen. Tapping a row opens the same details bottom
/// sheet the history page uses — the fetch and the sheet come from
/// [TransactionHistoryBloc] via `AppTransactionDetailsListener`, mounted by the
/// home page, so nothing about transaction details is duplicated here.
class HomeRecentTransactionsView extends StatelessWidget {
  final HomeState state;

  const HomeRecentTransactionsView({super.key, required this.state});

  static const int _maxItems = 5;

  @override
  Widget build(BuildContext context) {
    if (state.isRecentTransactionsLoading) {
      return const HomeRecentTransactionsShimmer();
    }

    // A failed fetch used to render exactly like a brand-new customer with no
    // transfers yet — the section simply vanished. It is best-effort (it never
    // blocks a transaction), so it owns its error state with a retry that
    // re-runs only this one endpoint.
    if (state.isRecentTransactionsLoadFailed) {
      return const _RecentTransactionsError();
    }

    final transactions = state.homeRecentTransactionsDto?.data.transactions
        .take(_maxItems)
        .toList();

    if (transactions == null || transactions.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 8.w, 0),
          child: Row(
            children: [
              // Same accent bar + title as the "Send Again" and "Send Money"
              // headings, so all three section headers align down the page.
              Container(
                width: 3.w,
                height: 12.h,
                decoration: BoxDecoration(
                  color: context.appColors.brandFill,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                'home.recentTransactions.title'.tr(),
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
              const Spacer(),
              _ViewAllButton(
                onTap: () {
                  // Exactly what the drawer's Transaction History item does:
                  // reset the sort so the pushed screen starts from a clean
                  // first page rather than the last filter the user left on it.
                  context.read<TransactionHistoryBloc>().add(
                    const TransactionHistoryEvent.getTransactionHistory(
                      resetSort: true,
                    ),
                  );
                  context.router.push(const TransactionHistoryRoute());
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 4.h),
        ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return AppTransactionTile(
              commonTransaction: transaction,
              onTap: () {
                HapticFeedback.selectionClick();
                context.read<TransactionHistoryBloc>().add(
                  TransactionHistoryEvent.getTransactionHistoryDetails(
                    beneficiaryId: transaction.eId ?? '',
                    transactionReference: transaction.transactionReference ?? 0,
                  ),
                );
              },
            );
          },
          separatorBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Divider(
              color: context.appColors.glassBorder.withValues(alpha: 0.08),
              height: 1,
              thickness: 0.5,
            ),
          ),
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}

/// Inline failure card standing in for the list when its fetch failed, with a
/// retry that re-runs only that endpoint. Reuses the shared [HomeInlineNotice]
/// so it reads as the same kind of section notice used elsewhere on home.
class _RecentTransactionsError extends StatelessWidget {
  const _RecentTransactionsError();

  @override
  Widget build(BuildContext context) {
    return HomeInlineNotice(
      type: HomeNoticeType.error,
      icon: Icons.receipt_long_rounded,
      label: 'home.recentTransactions.title'.tr(),
      message: 'home.recentTransactions.loadFailed'.tr(),
      actionLabel: 'buttons.retry'.tr(),
      onAction: () => context.read<HomeBloc>().add(
        const HomeEvent.getHomeRecentTransactions(),
      ),
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
    );
  }
}

class _ViewAllButton extends StatelessWidget {
  final VoidCallback onTap;

  const _ViewAllButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderRadius = BorderRadius.circular(8.r);

    return Material(
      color: Colors.transparent,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        borderRadius: borderRadius,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'home.recentTransactions.viewAll'.tr(),
                style: theme.textTheme.labelMedium?.copyWith(
                  // Accent TEXT, not a fill: `tertiary` is the token tuned to
                  // stay readable on the light theme's white canvas.
                  color: theme.colorScheme.tertiary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 2.w),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 11.sp,
                color: theme.colorScheme.tertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Placeholder rows shown while the first page is in flight, shaped like the
/// tiles that replace them so the section doesn't jump as it settles.
///
/// Public because the home page's first-load branch renders it directly: that
/// branch replaces the whole Send Money block (this section included) with
/// shimmer, so without it the page would end abruptly at the CTA and then grow
/// a transactions list when the load settled.
class HomeRecentTransactionsShimmer extends StatelessWidget {
  const HomeRecentTransactionsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppShimmer(
          width: 150.w,
          height: 14.h,
          margin: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
        ),
        SizedBox(height: 12.h),
        for (int i = 0; i < 3; i++)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                AppShimmer(
                  width: 40.w,
                  height: 40.h,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppShimmer(width: 120.w, height: 12.h),
                      SizedBox(height: 6.h),
                      AppShimmer(width: 80.w, height: 10.h),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                AppShimmer(width: 60.w, height: 12.h),
              ],
            ),
          ),
        SizedBox(height: 8.h),
      ],
    );
  }
}
