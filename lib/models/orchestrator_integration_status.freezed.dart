// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'orchestrator_integration_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntegrationStatus {

 String get id; String get name; String get status; int get error; String get errorDescription;
/// Create a copy of IntegrationStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntegrationStatusCopyWith<IntegrationStatus> get copyWith => _$IntegrationStatusCopyWithImpl<IntegrationStatus>(this as IntegrationStatus, _$identity);

  /// Serializes this IntegrationStatus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntegrationStatus&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&(identical(other.errorDescription, errorDescription) || other.errorDescription == errorDescription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,status,error,errorDescription);

@override
String toString() {
  return 'IntegrationStatus(id: $id, name: $name, status: $status, error: $error, errorDescription: $errorDescription)';
}


}

/// @nodoc
abstract mixin class $IntegrationStatusCopyWith<$Res>  {
  factory $IntegrationStatusCopyWith(IntegrationStatus value, $Res Function(IntegrationStatus) _then) = _$IntegrationStatusCopyWithImpl;
@useResult
$Res call({
 String id, String name, String status, int error, String errorDescription
});




}
/// @nodoc
class _$IntegrationStatusCopyWithImpl<$Res>
    implements $IntegrationStatusCopyWith<$Res> {
  _$IntegrationStatusCopyWithImpl(this._self, this._then);

  final IntegrationStatus _self;
  final $Res Function(IntegrationStatus) _then;

/// Create a copy of IntegrationStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? status = null,Object? error = null,Object? errorDescription = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as int,errorDescription: null == errorDescription ? _self.errorDescription : errorDescription // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [IntegrationStatus].
extension IntegrationStatusPatterns on IntegrationStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntegrationStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntegrationStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntegrationStatus value)  $default,){
final _that = this;
switch (_that) {
case _IntegrationStatus():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntegrationStatus value)?  $default,){
final _that = this;
switch (_that) {
case _IntegrationStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String status,  int error,  String errorDescription)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntegrationStatus() when $default != null:
return $default(_that.id,_that.name,_that.status,_that.error,_that.errorDescription);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String status,  int error,  String errorDescription)  $default,) {final _that = this;
switch (_that) {
case _IntegrationStatus():
return $default(_that.id,_that.name,_that.status,_that.error,_that.errorDescription);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String status,  int error,  String errorDescription)?  $default,) {final _that = this;
switch (_that) {
case _IntegrationStatus() when $default != null:
return $default(_that.id,_that.name,_that.status,_that.error,_that.errorDescription);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntegrationStatus extends IntegrationStatus {
  const _IntegrationStatus({required this.id, required this.name, required this.status, required this.error, required this.errorDescription}): super._();
  factory _IntegrationStatus.fromJson(Map<String, dynamic> json) => _$IntegrationStatusFromJson(json);

@override final  String id;
@override final  String name;
@override final  String status;
@override final  int error;
@override final  String errorDescription;

/// Create a copy of IntegrationStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntegrationStatusCopyWith<_IntegrationStatus> get copyWith => __$IntegrationStatusCopyWithImpl<_IntegrationStatus>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntegrationStatusToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntegrationStatus&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.error, error) || other.error == error)&&(identical(other.errorDescription, errorDescription) || other.errorDescription == errorDescription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,status,error,errorDescription);

@override
String toString() {
  return 'IntegrationStatus(id: $id, name: $name, status: $status, error: $error, errorDescription: $errorDescription)';
}


}

/// @nodoc
abstract mixin class _$IntegrationStatusCopyWith<$Res> implements $IntegrationStatusCopyWith<$Res> {
  factory _$IntegrationStatusCopyWith(_IntegrationStatus value, $Res Function(_IntegrationStatus) _then) = __$IntegrationStatusCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String status, int error, String errorDescription
});




}
/// @nodoc
class __$IntegrationStatusCopyWithImpl<$Res>
    implements _$IntegrationStatusCopyWith<$Res> {
  __$IntegrationStatusCopyWithImpl(this._self, this._then);

  final _IntegrationStatus _self;
  final $Res Function(_IntegrationStatus) _then;

/// Create a copy of IntegrationStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? status = null,Object? error = null,Object? errorDescription = null,}) {
  return _then(_IntegrationStatus(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as int,errorDescription: null == errorDescription ? _self.errorDescription : errorDescription // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
