// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_agent_list_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomeAgentListDto {

@JsonKey(name: "success") String? get success;@JsonKey(name: "data") HomeAgentData? get data;@JsonKey(includeFromJson: false, includeToJson: false) bool get agentNotRequired;
/// Create a copy of HomeAgentListDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeAgentListDtoCopyWith<HomeAgentListDto> get copyWith => _$HomeAgentListDtoCopyWithImpl<HomeAgentListDto>(this as HomeAgentListDto, _$identity);

  /// Serializes this HomeAgentListDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeAgentListDto&&(identical(other.success, success) || other.success == success)&&(identical(other.data, data) || other.data == data)&&(identical(other.agentNotRequired, agentNotRequired) || other.agentNotRequired == agentNotRequired));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,data,agentNotRequired);

@override
String toString() {
  return 'HomeAgentListDto(success: $success, data: $data, agentNotRequired: $agentNotRequired)';
}


}

/// @nodoc
abstract mixin class $HomeAgentListDtoCopyWith<$Res>  {
  factory $HomeAgentListDtoCopyWith(HomeAgentListDto value, $Res Function(HomeAgentListDto) _then) = _$HomeAgentListDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "success") String? success,@JsonKey(name: "data") HomeAgentData? data,@JsonKey(includeFromJson: false, includeToJson: false) bool agentNotRequired
});


$HomeAgentDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$HomeAgentListDtoCopyWithImpl<$Res>
    implements $HomeAgentListDtoCopyWith<$Res> {
  _$HomeAgentListDtoCopyWithImpl(this._self, this._then);

  final HomeAgentListDto _self;
  final $Res Function(HomeAgentListDto) _then;

/// Create a copy of HomeAgentListDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = freezed,Object? data = freezed,Object? agentNotRequired = null,}) {
  return _then(_self.copyWith(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as HomeAgentData?,agentNotRequired: null == agentNotRequired ? _self.agentNotRequired : agentNotRequired // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of HomeAgentListDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeAgentDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $HomeAgentDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [HomeAgentListDto].
extension HomeAgentListDtoPatterns on HomeAgentListDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeAgentListDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeAgentListDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeAgentListDto value)  $default,){
final _that = this;
switch (_that) {
case _HomeAgentListDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeAgentListDto value)?  $default,){
final _that = this;
switch (_that) {
case _HomeAgentListDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "data")  HomeAgentData? data, @JsonKey(includeFromJson: false, includeToJson: false)  bool agentNotRequired)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeAgentListDto() when $default != null:
return $default(_that.success,_that.data,_that.agentNotRequired);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "data")  HomeAgentData? data, @JsonKey(includeFromJson: false, includeToJson: false)  bool agentNotRequired)  $default,) {final _that = this;
switch (_that) {
case _HomeAgentListDto():
return $default(_that.success,_that.data,_that.agentNotRequired);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "success")  String? success, @JsonKey(name: "data")  HomeAgentData? data, @JsonKey(includeFromJson: false, includeToJson: false)  bool agentNotRequired)?  $default,) {final _that = this;
switch (_that) {
case _HomeAgentListDto() when $default != null:
return $default(_that.success,_that.data,_that.agentNotRequired);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeAgentListDto implements HomeAgentListDto {
  const _HomeAgentListDto({@JsonKey(name: "success") this.success, @JsonKey(name: "data") this.data, @JsonKey(includeFromJson: false, includeToJson: false) this.agentNotRequired = false});
  factory _HomeAgentListDto.fromJson(Map<String, dynamic> json) => _$HomeAgentListDtoFromJson(json);

@override@JsonKey(name: "success") final  String? success;
@override@JsonKey(name: "data") final  HomeAgentData? data;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  bool agentNotRequired;

/// Create a copy of HomeAgentListDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeAgentListDtoCopyWith<_HomeAgentListDto> get copyWith => __$HomeAgentListDtoCopyWithImpl<_HomeAgentListDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeAgentListDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeAgentListDto&&(identical(other.success, success) || other.success == success)&&(identical(other.data, data) || other.data == data)&&(identical(other.agentNotRequired, agentNotRequired) || other.agentNotRequired == agentNotRequired));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,data,agentNotRequired);

@override
String toString() {
  return 'HomeAgentListDto(success: $success, data: $data, agentNotRequired: $agentNotRequired)';
}


}

/// @nodoc
abstract mixin class _$HomeAgentListDtoCopyWith<$Res> implements $HomeAgentListDtoCopyWith<$Res> {
  factory _$HomeAgentListDtoCopyWith(_HomeAgentListDto value, $Res Function(_HomeAgentListDto) _then) = __$HomeAgentListDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "success") String? success,@JsonKey(name: "data") HomeAgentData? data,@JsonKey(includeFromJson: false, includeToJson: false) bool agentNotRequired
});


@override $HomeAgentDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$HomeAgentListDtoCopyWithImpl<$Res>
    implements _$HomeAgentListDtoCopyWith<$Res> {
  __$HomeAgentListDtoCopyWithImpl(this._self, this._then);

  final _HomeAgentListDto _self;
  final $Res Function(_HomeAgentListDto) _then;

/// Create a copy of HomeAgentListDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = freezed,Object? data = freezed,Object? agentNotRequired = null,}) {
  return _then(_HomeAgentListDto(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as HomeAgentData?,agentNotRequired: null == agentNotRequired ? _self.agentNotRequired : agentNotRequired // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of HomeAgentListDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HomeAgentDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $HomeAgentDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$HomeAgentData {

@JsonKey(name: "beneficiary_agent_list") List<HomeAgentItem>? get agentList;
/// Create a copy of HomeAgentData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeAgentDataCopyWith<HomeAgentData> get copyWith => _$HomeAgentDataCopyWithImpl<HomeAgentData>(this as HomeAgentData, _$identity);

  /// Serializes this HomeAgentData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeAgentData&&const DeepCollectionEquality().equals(other.agentList, agentList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(agentList));

@override
String toString() {
  return 'HomeAgentData(agentList: $agentList)';
}


}

/// @nodoc
abstract mixin class $HomeAgentDataCopyWith<$Res>  {
  factory $HomeAgentDataCopyWith(HomeAgentData value, $Res Function(HomeAgentData) _then) = _$HomeAgentDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "beneficiary_agent_list") List<HomeAgentItem>? agentList
});




}
/// @nodoc
class _$HomeAgentDataCopyWithImpl<$Res>
    implements $HomeAgentDataCopyWith<$Res> {
  _$HomeAgentDataCopyWithImpl(this._self, this._then);

  final HomeAgentData _self;
  final $Res Function(HomeAgentData) _then;

/// Create a copy of HomeAgentData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? agentList = freezed,}) {
  return _then(_self.copyWith(
agentList: freezed == agentList ? _self.agentList : agentList // ignore: cast_nullable_to_non_nullable
as List<HomeAgentItem>?,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeAgentData].
extension HomeAgentDataPatterns on HomeAgentData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeAgentData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeAgentData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeAgentData value)  $default,){
final _that = this;
switch (_that) {
case _HomeAgentData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeAgentData value)?  $default,){
final _that = this;
switch (_that) {
case _HomeAgentData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "beneficiary_agent_list")  List<HomeAgentItem>? agentList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeAgentData() when $default != null:
return $default(_that.agentList);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "beneficiary_agent_list")  List<HomeAgentItem>? agentList)  $default,) {final _that = this;
switch (_that) {
case _HomeAgentData():
return $default(_that.agentList);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "beneficiary_agent_list")  List<HomeAgentItem>? agentList)?  $default,) {final _that = this;
switch (_that) {
case _HomeAgentData() when $default != null:
return $default(_that.agentList);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeAgentData implements HomeAgentData {
  const _HomeAgentData({@JsonKey(name: "beneficiary_agent_list") final  List<HomeAgentItem>? agentList}): _agentList = agentList;
  factory _HomeAgentData.fromJson(Map<String, dynamic> json) => _$HomeAgentDataFromJson(json);

 final  List<HomeAgentItem>? _agentList;
@override@JsonKey(name: "beneficiary_agent_list") List<HomeAgentItem>? get agentList {
  final value = _agentList;
  if (value == null) return null;
  if (_agentList is EqualUnmodifiableListView) return _agentList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of HomeAgentData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeAgentDataCopyWith<_HomeAgentData> get copyWith => __$HomeAgentDataCopyWithImpl<_HomeAgentData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeAgentDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeAgentData&&const DeepCollectionEquality().equals(other._agentList, _agentList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_agentList));

@override
String toString() {
  return 'HomeAgentData(agentList: $agentList)';
}


}

/// @nodoc
abstract mixin class _$HomeAgentDataCopyWith<$Res> implements $HomeAgentDataCopyWith<$Res> {
  factory _$HomeAgentDataCopyWith(_HomeAgentData value, $Res Function(_HomeAgentData) _then) = __$HomeAgentDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "beneficiary_agent_list") List<HomeAgentItem>? agentList
});




}
/// @nodoc
class __$HomeAgentDataCopyWithImpl<$Res>
    implements _$HomeAgentDataCopyWith<$Res> {
  __$HomeAgentDataCopyWithImpl(this._self, this._then);

  final _HomeAgentData _self;
  final $Res Function(_HomeAgentData) _then;

/// Create a copy of HomeAgentData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? agentList = freezed,}) {
  return _then(_HomeAgentData(
agentList: freezed == agentList ? _self._agentList : agentList // ignore: cast_nullable_to_non_nullable
as List<HomeAgentItem>?,
  ));
}


}


/// @nodoc
mixin _$HomeAgentItem {

@JsonKey(name: "code") String? get code;@JsonKey(name: "name") String? get name;
/// Create a copy of HomeAgentItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeAgentItemCopyWith<HomeAgentItem> get copyWith => _$HomeAgentItemCopyWithImpl<HomeAgentItem>(this as HomeAgentItem, _$identity);

  /// Serializes this HomeAgentItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeAgentItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name);

@override
String toString() {
  return 'HomeAgentItem(code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class $HomeAgentItemCopyWith<$Res>  {
  factory $HomeAgentItemCopyWith(HomeAgentItem value, $Res Function(HomeAgentItem) _then) = _$HomeAgentItemCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "code") String? code,@JsonKey(name: "name") String? name
});




}
/// @nodoc
class _$HomeAgentItemCopyWithImpl<$Res>
    implements $HomeAgentItemCopyWith<$Res> {
  _$HomeAgentItemCopyWithImpl(this._self, this._then);

  final HomeAgentItem _self;
  final $Res Function(HomeAgentItem) _then;

/// Create a copy of HomeAgentItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? name = freezed,}) {
  return _then(_self.copyWith(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeAgentItem].
extension HomeAgentItemPatterns on HomeAgentItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeAgentItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeAgentItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeAgentItem value)  $default,){
final _that = this;
switch (_that) {
case _HomeAgentItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeAgentItem value)?  $default,){
final _that = this;
switch (_that) {
case _HomeAgentItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "code")  String? code, @JsonKey(name: "name")  String? name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeAgentItem() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "code")  String? code, @JsonKey(name: "name")  String? name)  $default,) {final _that = this;
switch (_that) {
case _HomeAgentItem():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "code")  String? code, @JsonKey(name: "name")  String? name)?  $default,) {final _that = this;
switch (_that) {
case _HomeAgentItem() when $default != null:
return $default(_that.code,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeAgentItem implements HomeAgentItem {
  const _HomeAgentItem({@JsonKey(name: "code") this.code, @JsonKey(name: "name") this.name});
  factory _HomeAgentItem.fromJson(Map<String, dynamic> json) => _$HomeAgentItemFromJson(json);

@override@JsonKey(name: "code") final  String? code;
@override@JsonKey(name: "name") final  String? name;

/// Create a copy of HomeAgentItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeAgentItemCopyWith<_HomeAgentItem> get copyWith => __$HomeAgentItemCopyWithImpl<_HomeAgentItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeAgentItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeAgentItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name);

@override
String toString() {
  return 'HomeAgentItem(code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class _$HomeAgentItemCopyWith<$Res> implements $HomeAgentItemCopyWith<$Res> {
  factory _$HomeAgentItemCopyWith(_HomeAgentItem value, $Res Function(_HomeAgentItem) _then) = __$HomeAgentItemCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "code") String? code,@JsonKey(name: "name") String? name
});




}
/// @nodoc
class __$HomeAgentItemCopyWithImpl<$Res>
    implements _$HomeAgentItemCopyWith<$Res> {
  __$HomeAgentItemCopyWithImpl(this._self, this._then);

  final _HomeAgentItem _self;
  final $Res Function(_HomeAgentItem) _then;

/// Create a copy of HomeAgentItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? name = freezed,}) {
  return _then(_HomeAgentItem(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
