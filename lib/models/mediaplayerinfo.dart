
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mediaplayerinfo.freezed.dart';
part 'mediaplayerinfo.g.dart';

@freezed
abstract class MediaPlayerInfo with _$MediaPlayerInfo {
  factory MediaPlayerInfo({
    required String title,
    required String album,
    required String artist,
    required String imageUrl,
    required Duration length,
    required Duration position,
    String? id,
  }) = _MediaPlayerInfo;
	
  factory MediaPlayerInfo.fromJson(Map<String, dynamic> json) =>
			_$MediaPlayerInfoFromJson(json);
}
