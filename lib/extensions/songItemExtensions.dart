import 'package:audio_service/audio_service.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

extension SongInfoExtensions on SongInfo {
  MediaItem toMediaItem() {
    return MediaItem(
      album: this.album,
      title: this.title,
      artUri: this.albumArtwork,
      artist: this.artist,
      duration: int.parse(this.duration),
      id: this.filePath,
      playable: true,
      extras: {'id': this.id},
    );
  }
}
