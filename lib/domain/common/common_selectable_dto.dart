import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_selectable_dto.freezed.dart';
part 'common_selectable_dto.g.dart';

CommonSelectableDto commonSelectableDtoFromJson(String str) =>
    CommonSelectableDto.fromJson(json.decode(str));

String commonSelectableDtoToJson(CommonSelectableDto data) =>
    json.encode(data.toJson());

@freezed
sealed class CommonSelectableDto with _$CommonSelectableDto {
  const factory CommonSelectableDto({
    String? message,
    CommonSelectableData? data,
  }) = _CommonSelectableDto;

  factory CommonSelectableDto.empty() =>
      CommonSelectableDto(message: '', data: CommonSelectableData.empty());

  factory CommonSelectableDto.fromJson(Map<String, dynamic> json) =>
      _$CommonSelectableDtoFromJson(json);
}

@freezed
sealed class CommonSelectableData with _$CommonSelectableData {
  const factory CommonSelectableData({List<CommonSelectableItem>? list}) =
  _CommonSelectableData;

  factory CommonSelectableData.empty() =>
      const CommonSelectableData(list: <CommonSelectableItem>[]);

  factory CommonSelectableData.fromJson(Map<String, dynamic> json) =>
      _$CommonSelectableDataFromJson(json);
}

@freezed
sealed class CommonSelectableItem with _$CommonSelectableItem {
  const factory CommonSelectableItem({
    String? leading,
    String? titleName,
    String? titleCode,
    String? subTitle,
    String? subTitleCode,
    String? trailingName,
    String? trailingCode,
    int? decimalPlaces,
    // Free slot for an extra backend code that has no UI role (e.g. the
    // bank/agent item carries its agent code here).
    String? extraName,
    String? extraCode,
  }) = _CommonSelectableItem;

  factory CommonSelectableItem.empty() => const CommonSelectableItem(
    leading: '',
    titleName: '',
    titleCode: '',
    subTitle: '',
    subTitleCode: '',
    trailingName: '',
    trailingCode: '',
    decimalPlaces: 3,
    extraName: '',
    extraCode: '',
  );

  factory CommonSelectableItem.fromJson(Map<String, dynamic> json) =>
      _$CommonSelectableItemFromJson(json);
}
