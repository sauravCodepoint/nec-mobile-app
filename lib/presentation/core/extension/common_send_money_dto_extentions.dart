import 'package:easy_localization/easy_localization.dart';

import '../../../domain/common/common_send_money_dto.dart';

extension CommonSendMoneyDtoExtensions on CommonSendMoneyDto {
  /// Source is always OMR → fixed 3 decimals, e.g. "1,000.000".
  String get formattedSourceAmount => _formatAmount(sourceAmount, 3);

  /// Destination decimals vary per currency. Pass the currency's
  /// `decimalPlaces` (defaults to 3 when unknown), e.g. "1,000.00" for 2.
  String formattedDestinationAmount([int decimalPlaces = 3]) =>
      _formatAmount(destinationAmount, decimalPlaces);

  String _formatAmount(double? amount, int decimalPlaces) {
    final decimals = decimalPlaces < 0 ? 0 : decimalPlaces;
    final pattern = decimals > 0 ? '#,##0.${'0' * decimals}' : '#,##0';
    return NumberFormat(pattern, 'en_US').format(amount ?? 0);
  }
}
