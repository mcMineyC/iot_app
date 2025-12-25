// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IntegrationUiDefinition {

 String get label; String get integrationId; IntegrationUiType get type; String get dataPath; String? get evaluatorScript; String? get outputTransformer;
/// Create a copy of IntegrationUiDefinition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntegrationUiDefinitionCopyWith<IntegrationUiDefinition> get copyWith => _$IntegrationUiDefinitionCopyWithImpl<IntegrationUiDefinition>(this as IntegrationUiDefinition, _$identity);

  /// Serializes this IntegrationUiDefinition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntegrationUiDefinition&&(identical(other.label, label) || other.label == label)&&(identical(other.integrationId, integrationId) || other.integrationId == integrationId)&&(identical(other.type, type) || other.type == type)&&(identical(other.dataPath, dataPath) || other.dataPath == dataPath)&&(identical(other.evaluatorScript, evaluatorScript) || other.evaluatorScript == evaluatorScript)&&(identical(other.outputTransformer, outputTransformer) || other.outputTransformer == outputTransformer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,integrationId,type,dataPath,evaluatorScript,outputTransformer);

@override
String toString() {
  return 'IntegrationUiDefinition(label: $label, integrationId: $integrationId, type: $type, dataPath: $dataPath, evaluatorScript: $evaluatorScript, outputTransformer: $outputTransformer)';
}


}

/// @nodoc
abstract mixin class $IntegrationUiDefinitionCopyWith<$Res>  {
  factory $IntegrationUiDefinitionCopyWith(IntegrationUiDefinition value, $Res Function(IntegrationUiDefinition) _then) = _$IntegrationUiDefinitionCopyWithImpl;
@useResult
$Res call({
 String label, String integrationId, IntegrationUiType type, String dataPath, String? evaluatorScript, String? outputTransformer
});




}
/// @nodoc
class _$IntegrationUiDefinitionCopyWithImpl<$Res>
    implements $IntegrationUiDefinitionCopyWith<$Res> {
  _$IntegrationUiDefinitionCopyWithImpl(this._self, this._then);

  final IntegrationUiDefinition _self;
  final $Res Function(IntegrationUiDefinition) _then;

/// Create a copy of IntegrationUiDefinition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? integrationId = null,Object? type = null,Object? dataPath = null,Object? evaluatorScript = freezed,Object? outputTransformer = freezed,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,integrationId: null == integrationId ? _self.integrationId : integrationId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as IntegrationUiType,dataPath: null == dataPath ? _self.dataPath : dataPath // ignore: cast_nullable_to_non_nullable
as String,evaluatorScript: freezed == evaluatorScript ? _self.evaluatorScript : evaluatorScript // ignore: cast_nullable_to_non_nullable
as String?,outputTransformer: freezed == outputTransformer ? _self.outputTransformer : outputTransformer // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [IntegrationUiDefinition].
extension IntegrationUiDefinitionPatterns on IntegrationUiDefinition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntegrationUiDefinition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntegrationUiDefinition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntegrationUiDefinition value)  $default,){
final _that = this;
switch (_that) {
case _IntegrationUiDefinition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntegrationUiDefinition value)?  $default,){
final _that = this;
switch (_that) {
case _IntegrationUiDefinition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  String integrationId,  IntegrationUiType type,  String dataPath,  String? evaluatorScript,  String? outputTransformer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntegrationUiDefinition() when $default != null:
return $default(_that.label,_that.integrationId,_that.type,_that.dataPath,_that.evaluatorScript,_that.outputTransformer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  String integrationId,  IntegrationUiType type,  String dataPath,  String? evaluatorScript,  String? outputTransformer)  $default,) {final _that = this;
switch (_that) {
case _IntegrationUiDefinition():
return $default(_that.label,_that.integrationId,_that.type,_that.dataPath,_that.evaluatorScript,_that.outputTransformer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  String integrationId,  IntegrationUiType type,  String dataPath,  String? evaluatorScript,  String? outputTransformer)?  $default,) {final _that = this;
switch (_that) {
case _IntegrationUiDefinition() when $default != null:
return $default(_that.label,_that.integrationId,_that.type,_that.dataPath,_that.evaluatorScript,_that.outputTransformer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IntegrationUiDefinition implements IntegrationUiDefinition {
  const _IntegrationUiDefinition({required this.label, required this.integrationId, required this.type, required this.dataPath, this.evaluatorScript, this.outputTransformer});
  factory _IntegrationUiDefinition.fromJson(Map<String, dynamic> json) => _$IntegrationUiDefinitionFromJson(json);

@override final  String label;
@override final  String integrationId;
@override final  IntegrationUiType type;
@override final  String dataPath;
@override final  String? evaluatorScript;
@override final  String? outputTransformer;

/// Create a copy of IntegrationUiDefinition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntegrationUiDefinitionCopyWith<_IntegrationUiDefinition> get copyWith => __$IntegrationUiDefinitionCopyWithImpl<_IntegrationUiDefinition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IntegrationUiDefinitionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntegrationUiDefinition&&(identical(other.label, label) || other.label == label)&&(identical(other.integrationId, integrationId) || other.integrationId == integrationId)&&(identical(other.type, type) || other.type == type)&&(identical(other.dataPath, dataPath) || other.dataPath == dataPath)&&(identical(other.evaluatorScript, evaluatorScript) || other.evaluatorScript == evaluatorScript)&&(identical(other.outputTransformer, outputTransformer) || other.outputTransformer == outputTransformer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,integrationId,type,dataPath,evaluatorScript,outputTransformer);

@override
String toString() {
  return 'IntegrationUiDefinition(label: $label, integrationId: $integrationId, type: $type, dataPath: $dataPath, evaluatorScript: $evaluatorScript, outputTransformer: $outputTransformer)';
}


}

/// @nodoc
abstract mixin class _$IntegrationUiDefinitionCopyWith<$Res> implements $IntegrationUiDefinitionCopyWith<$Res> {
  factory _$IntegrationUiDefinitionCopyWith(_IntegrationUiDefinition value, $Res Function(_IntegrationUiDefinition) _then) = __$IntegrationUiDefinitionCopyWithImpl;
@override @useResult
$Res call({
 String label, String integrationId, IntegrationUiType type, String dataPath, String? evaluatorScript, String? outputTransformer
});




}
/// @nodoc
class __$IntegrationUiDefinitionCopyWithImpl<$Res>
    implements _$IntegrationUiDefinitionCopyWith<$Res> {
  __$IntegrationUiDefinitionCopyWithImpl(this._self, this._then);

  final _IntegrationUiDefinition _self;
  final $Res Function(_IntegrationUiDefinition) _then;

/// Create a copy of IntegrationUiDefinition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? integrationId = null,Object? type = null,Object? dataPath = null,Object? evaluatorScript = freezed,Object? outputTransformer = freezed,}) {
  return _then(_IntegrationUiDefinition(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,integrationId: null == integrationId ? _self.integrationId : integrationId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as IntegrationUiType,dataPath: null == dataPath ? _self.dataPath : dataPath // ignore: cast_nullable_to_non_nullable
as String,evaluatorScript: freezed == evaluatorScript ? _self.evaluatorScript : evaluatorScript // ignore: cast_nullable_to_non_nullable
as String?,outputTransformer: freezed == outputTransformer ? _self.outputTransformer : outputTransformer // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
