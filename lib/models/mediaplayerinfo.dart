
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
    String? id,
  }) = _MediaPlayerInfo;
	
  factory MediaPlayerInfo.fromJson(Map<String, dynamic> json) =>
			_$MediaPlayerInfoFromJson(json);

  factory MediaPlayerInfo.empty() => MediaPlayerInfo(
        title: "Not playing",
        album: "",
        artist: "",
        imageUrl: "",
        length: Duration.zero,
        id: null,
      );
}
