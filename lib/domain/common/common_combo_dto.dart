import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_combo_dto.freezed.dart';
part 'common_combo_dto.g.dart';

/// A single code/name dropdown option for the dynamic beneficiary form.
/// Option lists live in `BeneficiaryState.comboLists`, keyed by the
/// normalized field name (see `BeneficiaryFieldKeys`).
@freezed
sealed class ComboItem with _$ComboItem {
  const factory ComboItem({
    @JsonKey(name: "code") required String code,
    @JsonKey(name: "name") required String name,
  }) = _ComboItem;

  factory ComboItem.fromJson(Map<String, dynamic> json) =>
      _$ComboItemFromJson(json);
}