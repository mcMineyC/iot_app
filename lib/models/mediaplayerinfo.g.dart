// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mediaplayerinfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MediaPlayerInfo _$MediaPlayerInfoFromJson(Map<String, dynamic> json) =>
    _MediaPlayerInfo(
      title: json['title'] as String,
      album: json['album'] as String,
      artist: json['artist'] as String,
      imageUrl: json['imageUrl'] as String,
      length: Duration(microseconds: (json['length'] as num).toInt()),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$MediaPlayerInfoToJson(_MediaPlayerInfo instance) =>
    <String, dynamic>{
      'title': instance.title,
      'album': instance.album,
      'artist': instance.artist,
      'imageUrl': instance.imageUrl,
      'length': instance.length.inMicroseconds,
      'id': instance.id,
    };
