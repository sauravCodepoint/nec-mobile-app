// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'beneficiary_bank_or_agent_list_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BeneficiaryBankOrAgentListDto {

@JsonKey(name: "success") String? get success;@JsonKey(name: "message") String? get message;@JsonKey(name: "data") Data? get data;
/// Create a copy of BeneficiaryBankOrAgentListDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BeneficiaryBankOrAgentListDtoCopyWith<BeneficiaryBankOrAgentListDto> get copyWith => _$BeneficiaryBankOrAgentListDtoCopyWithImpl<BeneficiaryBankOrAgentListDto>(this as BeneficiaryBankOrAgentListDto, _$identity);

  /// Serializes this BeneficiaryBankOrAgentListDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BeneficiaryBankOrAgentListDto&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'BeneficiaryBankOrAgentListDto(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $BeneficiaryBankOrAgentListDtoCopyWith<$Res>  {
  factory $BeneficiaryBankOrAgentListDtoCopyWith(BeneficiaryBankOrAgentListDto value, $Res Function(BeneficiaryBankOrAgentListDto) _then) = _$BeneficiaryBankOrAgentListDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "success") String? success,@JsonKey(name: "message") String? message,@JsonKey(name: "data") Data? data
});


$DataCopyWith<$Res>? get data;

}
/// @nodoc
class _$BeneficiaryBankOrAgentListDtoCopyWithImpl<$Res>
    implements $BeneficiaryBankOrAgentListDtoCopyWith<$Res> {
  _$BeneficiaryBankOrAgentListDtoCopyWithImpl(this._self, this._then);

  final BeneficiaryBankOrAgentListDto _self;
  final $Res Function(BeneficiaryBankOrAgentListDto) _then;

/// Create a copy of BeneficiaryBankOrAgentListDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Data?,
  ));
}
/// Create a copy of BeneficiaryBankOrAgentListDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $DataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [BeneficiaryBankOrAgentListDto].
extension BeneficiaryBankOrAgentListDtoPatterns on BeneficiaryBankOrAgentListDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BeneficiaryBankOrAgentListDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BeneficiaryBankOrAgentListDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BeneficiaryBankOrAgentListDto value)  $default,){
final _that = this;
switch (_that) {
case _BeneficiaryBankOrAgentListDto():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BeneficiaryBankOrAgentListDto value)?  $default,){
final _that = this;
switch (_that) {
case _BeneficiaryBankOrAgentListDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "message")  String? message, @JsonKey(name: "data")  Data? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BeneficiaryBankOrAgentListDto() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "message")  String? message, @JsonKey(name: "data")  Data? data)  $default,) {final _that = this;
switch (_that) {
case _BeneficiaryBankOrAgentListDto():
return $default(_that.success,_that.message,_that.data);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "message")  String? message, @JsonKey(name: "data")  Data? data)?  $default,) {final _that = this;
switch (_that) {
case _BeneficiaryBankOrAgentListDto() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BeneficiaryBankOrAgentListDto implements BeneficiaryBankOrAgentListDto {
  const _BeneficiaryBankOrAgentListDto({@JsonKey(name: "success") this.success, @JsonKey(name: "message") this.message, @JsonKey(name: "data") this.data});
  factory _BeneficiaryBankOrAgentListDto.fromJson(Map<String, dynamic> json) => _$BeneficiaryBankOrAgentListDtoFromJson(json);

@override@JsonKey(name: "success") final  String? success;
@override@JsonKey(name: "message") final  String? message;
@override@JsonKey(name: "data") final  Data? data;

/// Create a copy of BeneficiaryBankOrAgentListDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BeneficiaryBankOrAgentListDtoCopyWith<_BeneficiaryBankOrAgentListDto> get copyWith => __$BeneficiaryBankOrAgentListDtoCopyWithImpl<_BeneficiaryBankOrAgentListDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BeneficiaryBankOrAgentListDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BeneficiaryBankOrAgentListDto&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'BeneficiaryBankOrAgentListDto(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$BeneficiaryBankOrAgentListDtoCopyWith<$Res> implements $BeneficiaryBankOrAgentListDtoCopyWith<$Res> {
  factory _$BeneficiaryBankOrAgentListDtoCopyWith(_BeneficiaryBankOrAgentListDto value, $Res Function(_BeneficiaryBankOrAgentListDto) _then) = __$BeneficiaryBankOrAgentListDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "success") String? success,@JsonKey(name: "message") String? message,@JsonKey(name: "data") Data? data
});


@override $DataCopyWith<$Res>? get data;

}
/// @nodoc
class __$BeneficiaryBankOrAgentListDtoCopyWithImpl<$Res>
    implements _$BeneficiaryBankOrAgentListDtoCopyWith<$Res> {
  __$BeneficiaryBankOrAgentListDtoCopyWithImpl(this._self, this._then);

  final _BeneficiaryBankOrAgentListDto _self;
  final $Res Function(_BeneficiaryBankOrAgentListDto) _then;

/// Create a copy of BeneficiaryBankOrAgentListDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_BeneficiaryBankOrAgentListDto(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Data?,
  ));
}

/// Create a copy of BeneficiaryBankOrAgentListDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $DataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$Data {

@JsonKey(name: "product_list") List<BeneficiaryBankList>? get beneficiaryBankList;
/// Create a copy of Data
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DataCopyWith<Data> get copyWith => _$DataCopyWithImpl<Data>(this as Data, _$identity);

  /// Serializes this Data to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Data&&const DeepCollectionEquality().equals(other.beneficiaryBankList, beneficiaryBankList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(beneficiaryBankList));

@override
String toString() {
  return 'Data(beneficiaryBankList: $beneficiaryBankList)';
}


}

/// @nodoc
abstract mixin class $DataCopyWith<$Res>  {
  factory $DataCopyWith(Data value, $Res Function(Data) _then) = _$DataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "product_list") List<BeneficiaryBankList>? beneficiaryBankList
});




}
/// @nodoc
class _$DataCopyWithImpl<$Res>
    implements $DataCopyWith<$Res> {
  _$DataCopyWithImpl(this._self, this._then);

  final Data _self;
  final $Res Function(Data) _then;

/// Create a copy of Data
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? beneficiaryBankList = freezed,}) {
  return _then(_self.copyWith(
beneficiaryBankList: freezed == beneficiaryBankList ? _self.beneficiaryBankList : beneficiaryBankList // ignore: cast_nullable_to_non_nullable
as List<BeneficiaryBankList>?,
  ));
}

}


/// Adds pattern-matching-related methods to [Data].
extension DataPatterns on Data {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Data value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Data() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Data value)  $default,){
final _that = this;
switch (_that) {
case _Data():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Data value)?  $default,){
final _that = this;
switch (_that) {
case _Data() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "product_list")  List<BeneficiaryBankList>? beneficiaryBankList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Data() when $default != null:
return $default(_that.beneficiaryBankList);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "product_list")  List<BeneficiaryBankList>? beneficiaryBankList)  $default,) {final _that = this;
switch (_that) {
case _Data():
return $default(_that.beneficiaryBankList);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "product_list")  List<BeneficiaryBankList>? beneficiaryBankList)?  $default,) {final _that = this;
switch (_that) {
case _Data() when $default != null:
return $default(_that.beneficiaryBankList);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Data implements Data {
  const _Data({@JsonKey(name: "product_list") final  List<BeneficiaryBankList>? beneficiaryBankList}): _beneficiaryBankList = beneficiaryBankList;
  factory _Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

 final  List<BeneficiaryBankList>? _beneficiaryBankList;
@override@JsonKey(name: "product_list") List<BeneficiaryBankList>? get beneficiaryBankList {
  final value = _beneficiaryBankList;
  if (value == null) return null;
  if (_beneficiaryBankList is EqualUnmodifiableListView) return _beneficiaryBankList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of Data
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DataCopyWith<_Data> get copyWith => __$DataCopyWithImpl<_Data>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Data&&const DeepCollectionEquality().equals(other._beneficiaryBankList, _beneficiaryBankList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_beneficiaryBankList));

@override
String toString() {
  return 'Data(beneficiaryBankList: $beneficiaryBankList)';
}


}

/// @nodoc
abstract mixin class _$DataCopyWith<$Res> implements $DataCopyWith<$Res> {
  factory _$DataCopyWith(_Data value, $Res Function(_Data) _then) = __$DataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "product_list") List<BeneficiaryBankList>? beneficiaryBankList
});




}
/// @nodoc
class __$DataCopyWithImpl<$Res>
    implements _$DataCopyWith<$Res> {
  __$DataCopyWithImpl(this._self, this._then);

  final _Data _self;
  final $Res Function(_Data) _then;

/// Create a copy of Data
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? beneficiaryBankList = freezed,}) {
  return _then(_Data(
beneficiaryBankList: freezed == beneficiaryBankList ? _self._beneficiaryBankList : beneficiaryBankList // ignore: cast_nullable_to_non_nullable
as List<BeneficiaryBankList>?,
  ));
}


}


/// @nodoc
mixin _$BeneficiaryBankList {

@JsonKey(name: "code") int? get code;@JsonKey(name: "name") String? get name;
/// Create a copy of BeneficiaryBankList
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BeneficiaryBankListCopyWith<BeneficiaryBankList> get copyWith => _$BeneficiaryBankListCopyWithImpl<BeneficiaryBankList>(this as BeneficiaryBankList, _$identity);

  /// Serializes this BeneficiaryBankList to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BeneficiaryBankList&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name);

@override
String toString() {
  return 'BeneficiaryBankList(code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class $BeneficiaryBankListCopyWith<$Res>  {
  factory $BeneficiaryBankListCopyWith(BeneficiaryBankList value, $Res Function(BeneficiaryBankList) _then) = _$BeneficiaryBankListCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "code") int? code,@JsonKey(name: "name") String? name
});




}
/// @nodoc
class _$BeneficiaryBankListCopyWithImpl<$Res>
    implements $BeneficiaryBankListCopyWith<$Res> {
  _$BeneficiaryBankListCopyWithImpl(this._self, this._then);

  final BeneficiaryBankList _self;
  final $Res Function(BeneficiaryBankList) _then;

/// Create a copy of BeneficiaryBankList
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? name = freezed,}) {
  return _then(_self.copyWith(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BeneficiaryBankList].
extension BeneficiaryBankListPatterns on BeneficiaryBankList {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BeneficiaryBankList value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BeneficiaryBankList() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BeneficiaryBankList value)  $default,){
final _that = this;
switch (_that) {
case _BeneficiaryBankList():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BeneficiaryBankList value)?  $default,){
final _that = this;
switch (_that) {
case _BeneficiaryBankList() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "code")  int? code, @JsonKey(name: "name")  String? name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BeneficiaryBankList() when $default != null:
return $default(_that.code,_that.name);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "code")  int? code, @JsonKey(name: "name")  String? name)  $default,) {final _that = this;
switch (_that) {
case _BeneficiaryBankList():
return $default(_that.code,_that.name);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "code")  int? code, @JsonKey(name: "name")  String? name)?  $default,) {final _that = this;
switch (_that) {
case _BeneficiaryBankList() when $default != null:
return $default(_that.code,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BeneficiaryBankList implements BeneficiaryBankList {
  const _BeneficiaryBankList({@JsonKey(name: "code") this.code, @JsonKey(name: "name") this.name});
  factory _BeneficiaryBankList.fromJson(Map<String, dynamic> json) => _$BeneficiaryBankListFromJson(json);

@override@JsonKey(name: "code") final  int? code;
@override@JsonKey(name: "name") final  String? name;

/// Create a copy of BeneficiaryBankList
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BeneficiaryBankListCopyWith<_BeneficiaryBankList> get copyWith => __$BeneficiaryBankListCopyWithImpl<_BeneficiaryBankList>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BeneficiaryBankListToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BeneficiaryBankList&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name);

@override
String toString() {
  return 'BeneficiaryBankList(code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class _$BeneficiaryBankListCopyWith<$Res> implements $BeneficiaryBankListCopyWith<$Res> {
  factory _$BeneficiaryBankListCopyWith(_BeneficiaryBankList value, $Res Function(_BeneficiaryBankList) _then) = __$BeneficiaryBankListCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "code") int? code,@JsonKey(name: "name") String? name
});




}
/// @nodoc
class __$BeneficiaryBankListCopyWithImpl<$Res>
    implements _$BeneficiaryBankListCopyWith<$Res> {
  __$BeneficiaryBankListCopyWithImpl(this._self, this._then);

  final _BeneficiaryBankList _self;
  final $Res Function(_BeneficiaryBankList) _then;

/// Create a copy of BeneficiaryBankList
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? name = freezed,}) {
  return _then(_BeneficiaryBankList(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
