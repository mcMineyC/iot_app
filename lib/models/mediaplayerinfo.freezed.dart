// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mediaplayerinfo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MediaPlayerInfo {

 String get title; String get album; String get artist; String get imageUrl; Duration get length; String? get id;
/// Create a copy of MediaPlayerInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MediaPlayerInfoCopyWith<MediaPlayerInfo> get copyWith => _$MediaPlayerInfoCopyWithImpl<MediaPlayerInfo>(this as MediaPlayerInfo, _$identity);

  /// Serializes this MediaPlayerInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MediaPlayerInfo&&(identical(other.title, title) || other.title == title)&&(identical(other.album, album) || other.album == album)&&(identical(other.artist, artist) || other.artist == artist)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.length, length) || other.length == length)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,album,artist,imageUrl,length,id);

@override
String toString() {
  return 'MediaPlayerInfo(title: $title, album: $album, artist: $artist, imageUrl: $imageUrl, length: $length, id: $id)';
}


}

/// @nodoc
abstract mixin class $MediaPlayerInfoCopyWith<$Res>  {
  factory $MediaPlayerInfoCopyWith(MediaPlayerInfo value, $Res Function(MediaPlayerInfo) _then) = _$MediaPlayerInfoCopyWithImpl;
@useResult
$Res call({
 String title, String album, String artist, String imageUrl, Duration length, String? id
});




}
/// @nodoc
class _$MediaPlayerInfoCopyWithImpl<$Res>
    implements $MediaPlayerInfoCopyWith<$Res> {
  _$MediaPlayerInfoCopyWithImpl(this._self, this._then);

  final MediaPlayerInfo _self;
  final $Res Function(MediaPlayerInfo) _then;

/// Create a copy of MediaPlayerInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? album = null,Object? artist = null,Object? imageUrl = null,Object? length = null,Object? id = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,album: null == album ? _self.album : album // ignore: cast_nullable_to_non_nullable
as String,artist: null == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as Duration,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MediaPlayerInfo].
extension MediaPlayerInfoPatterns on MediaPlayerInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MediaPlayerInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MediaPlayerInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MediaPlayerInfo value)  $default,){
final _that = this;
switch (_that) {
case _MediaPlayerInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MediaPlayerInfo value)?  $default,){
final _that = this;
switch (_that) {
case _MediaPlayerInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String album,  String artist,  String imageUrl,  Duration length,  String? id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MediaPlayerInfo() when $default != null:
return $default(_that.title,_that.album,_that.artist,_that.imageUrl,_that.length,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String album,  String artist,  String imageUrl,  Duration length,  String? id)  $default,) {final _that = this;
switch (_that) {
case _MediaPlayerInfo():
return $default(_that.title,_that.album,_that.artist,_that.imageUrl,_that.length,_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String album,  String artist,  String imageUrl,  Duration length,  String? id)?  $default,) {final _that = this;
switch (_that) {
case _MediaPlayerInfo() when $default != null:
return $default(_that.title,_that.album,_that.artist,_that.imageUrl,_that.length,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MediaPlayerInfo implements MediaPlayerInfo {
   _MediaPlayerInfo({required this.title, required this.album, required this.artist, required this.imageUrl, required this.length, this.id});
  factory _MediaPlayerInfo.fromJson(Map<String, dynamic> json) => _$MediaPlayerInfoFromJson(json);

@override final  String title;
@override final  String album;
@override final  String artist;
@override final  String imageUrl;
@override final  Duration length;
@override final  String? id;

/// Create a copy of MediaPlayerInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MediaPlayerInfoCopyWith<_MediaPlayerInfo> get copyWith => __$MediaPlayerInfoCopyWithImpl<_MediaPlayerInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MediaPlayerInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MediaPlayerInfo&&(identical(other.title, title) || other.title == title)&&(identical(other.album, album) || other.album == album)&&(identical(other.artist, artist) || other.artist == artist)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.length, length) || other.length == length)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,album,artist,imageUrl,length,id);

@override
String toString() {
  return 'MediaPlayerInfo(title: $title, album: $album, artist: $artist, imageUrl: $imageUrl, length: $length, id: $id)';
}


}

/// @nodoc
abstract mixin class _$MediaPlayerInfoCopyWith<$Res> implements $MediaPlayerInfoCopyWith<$Res> {
  factory _$MediaPlayerInfoCopyWith(_MediaPlayerInfo value, $Res Function(_MediaPlayerInfo) _then) = __$MediaPlayerInfoCopyWithImpl;
@override @useResult
$Res call({
 String title, String album, String artist, String imageUrl, Duration length, String? id
});




}
/// @nodoc
class __$MediaPlayerInfoCopyWithImpl<$Res>
    implements _$MediaPlayerInfoCopyWith<$Res> {
  __$MediaPlayerInfoCopyWithImpl(this._self, this._then);

  final _MediaPlayerInfo _self;
  final $Res Function(_MediaPlayerInfo) _then;

/// Create a copy of MediaPlayerInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? album = null,Object? artist = null,Object? imageUrl = null,Object? length = null,Object? id = freezed,}) {
  return _then(_MediaPlayerInfo(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,album: null == album ? _self.album : album // ignore: cast_nullable_to_non_nullable
as String,artist: null == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as Duration,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
