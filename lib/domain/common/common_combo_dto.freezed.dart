// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'common_combo_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ComboItem {

@JsonKey(name: "code") String get code;@JsonKey(name: "name") String get name;
/// Create a copy of ComboItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComboItemCopyWith<ComboItem> get copyWith => _$ComboItemCopyWithImpl<ComboItem>(this as ComboItem, _$identity);

  /// Serializes this ComboItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComboItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name);

@override
String toString() {
  return 'ComboItem(code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class $ComboItemCopyWith<$Res>  {
  factory $ComboItemCopyWith(ComboItem value, $Res Function(ComboItem) _then) = _$ComboItemCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: "code") String code,@JsonKey(name: "name") String name
});




}
/// @nodoc
class _$ComboItemCopyWithImpl<$Res>
    implements $ComboItemCopyWith<$Res> {
  _$ComboItemCopyWithImpl(this._self, this._then);

  final ComboItem _self;
  final $Res Function(ComboItem) _then;

/// Create a copy of ComboItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ComboItem].
extension ComboItemPatterns on ComboItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ComboItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ComboItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ComboItem value)  $default,){
final _that = this;
switch (_that) {
case _ComboItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ComboItem value)?  $default,){
final _that = this;
switch (_that) {
case _ComboItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: "code")  String code, @JsonKey(name: "name")  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ComboItem() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: "code")  String code, @JsonKey(name: "name")  String name)  $default,) {final _that = this;
switch (_that) {
case _ComboItem():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: "code")  String code, @JsonKey(name: "name")  String name)?  $default,) {final _that = this;
switch (_that) {
case _ComboItem() when $default != null:
return $default(_that.code,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ComboItem implements ComboItem {
  const _ComboItem({@JsonKey(name: "code") required this.code, @JsonKey(name: "name") required this.name});
  factory _ComboItem.fromJson(Map<String, dynamic> json) => _$ComboItemFromJson(json);

@override@JsonKey(name: "code") final  String code;
@override@JsonKey(name: "name") final  String name;

/// Create a copy of ComboItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComboItemCopyWith<_ComboItem> get copyWith => __$ComboItemCopyWithImpl<_ComboItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComboItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ComboItem&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,name);

@override
String toString() {
  return 'ComboItem(code: $code, name: $name)';
}


}

/// @nodoc
abstract mixin class _$ComboItemCopyWith<$Res> implements $ComboItemCopyWith<$Res> {
  factory _$ComboItemCopyWith(_ComboItem value, $Res Function(_ComboItem) _then) = __$ComboItemCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: "code") String code,@JsonKey(name: "name") String name
});




}
/// @nodoc
class __$ComboItemCopyWithImpl<$Res>
    implements _$ComboItemCopyWith<$Res> {
  __$ComboItemCopyWithImpl(this._self, this._then);

  final _ComboItem _self;
  final $Res Function(_ComboItem) _then;

/// Create a copy of ComboItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,}) {
  return _then(_ComboItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
