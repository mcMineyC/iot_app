// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'integrationschema.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntegrationSchema {

 String get path; String get type; bool get fetchable;
/// Create a copy of IntegrationSchema
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntegrationSchemaCopyWith<IntegrationSchema> get copyWith => _$IntegrationSchemaCopyWithImpl<IntegrationSchema>(this as IntegrationSchema, _$identity);

  /// Serializes this IntegrationSchema to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntegrationSchema&&(identical(other.path, path) || other.path == path)&&(identical(other.type, type) || other.type == type)&&(identical(other.fetchable, fetchable) || other.fetchable == fetchable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,path,type,fetchable);

@override
String toString() {
  return 'IntegrationSchema(path: $path, type: $type, fetchable: $fetchable)';
}


}

/// @nodoc
abstract mixin class $IntegrationSchemaCopyWith<$Res>  {
  factory $IntegrationSchemaCopyWith(IntegrationSchema value, $Res Function(IntegrationSchema) _then) = _$IntegrationSchemaCopyWithImpl;
@useResult
$Res call({
 String path, String type, bool fetchable
});




}
/// @nodoc
class _$IntegrationSchemaCopyWithImpl<$Res>
    implements $IntegrationSchemaCopyWith<$Res> {
  _$IntegrationSchemaCopyWithImpl(this._self, this._then);

  final IntegrationSchema _self;
  final $Res Function(IntegrationSchema) _then;

/// Create a copy of IntegrationSchema
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? path = null,Object? type = null,Object? fetchable = null,}) {
  return _then(_self.copyWith(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,fetchable: null == fetchable ? _self.fetchable : fetchable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [IntegrationSchema].
extension IntegrationSchemaPatterns on IntegrationSchema {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntegrationSchema value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntegrationSchema() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntegrationSchema value)  $default,){
final _that = this;
switch (_that) {
case _IntegrationSchema():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntegrationSchema value)?  $default,){
final _that = this;
switch (_that) {
case _IntegrationSchema() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String path,  String type,  bool fetchable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntegrationSchema() when $default != null:
return $default(_that.path,_that.type,_that.fetchable);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String path,  String type,  bool fetchable)  $default,) {final _that = this;
switch (_that) {
case _IntegrationSchema():
return $default(_that.path,_that.type,_that.fetchable);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String path,  String type,  bool fetchable)?  $default,) {final _that = this;
switch (_that) {
case _IntegrationSchema() when $default != null:
return $default(_that.path,_that.type,_that.fetchable);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntegrationSchema implements IntegrationSchema {
   _IntegrationSchema({required this.path, required this.type, required this.fetchable});
  factory _IntegrationSchema.fromJson(Map<String, dynamic> json) => _$IntegrationSchemaFromJson(json);

@override final  String path;
@override final  String type;
@override final  bool fetchable;

/// Create a copy of IntegrationSchema
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntegrationSchemaCopyWith<_IntegrationSchema> get copyWith => __$IntegrationSchemaCopyWithImpl<_IntegrationSchema>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntegrationSchemaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntegrationSchema&&(identical(other.path, path) || other.path == path)&&(identical(other.type, type) || other.type == type)&&(identical(other.fetchable, fetchable) || other.fetchable == fetchable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,path,type,fetchable);

@override
String toString() {
  return 'IntegrationSchema(path: $path, type: $type, fetchable: $fetchable)';
}


}

/// @nodoc
abstract mixin class _$IntegrationSchemaCopyWith<$Res> implements $IntegrationSchemaCopyWith<$Res> {
  factory _$IntegrationSchemaCopyWith(_IntegrationSchema value, $Res Function(_IntegrationSchema) _then) = __$IntegrationSchemaCopyWithImpl;
@override @useResult
$Res call({
 String path, String type, bool fetchable
});




}
/// @nodoc
class __$IntegrationSchemaCopyWithImpl<$Res>
    implements _$IntegrationSchemaCopyWith<$Res> {
  __$IntegrationSchemaCopyWithImpl(this._self, this._then);

  final _IntegrationSchema _self;
  final $Res Function(_IntegrationSchema) _then;

/// Create a copy of IntegrationSchema
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? path = null,Object? type = null,Object? fetchable = null,}) {
  return _then(_IntegrationSchema(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,fetchable: null == fetchable ? _self.fetchable : fetchable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
