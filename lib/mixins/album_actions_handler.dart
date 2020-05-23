import 'package:flutter_music_player/services/audio_service.dart';
import 'package:audio_service/audio_service.dart' as AS;

class AlbumActionsHandler {
  factory AlbumActionsHandler._() => null;

  void handleAction(AudioService service, String action, dynamic identifier) async{
    var songs = await service.getSongsFromAlbum(identifier.toString());
    AS.AudioService.replaceQueue(songs);
    if('Play' == action) {
      AS.AudioService.playMediaItem(songs.first);
    } else if('Shuffle' == action) {
      AS.AudioService.customAction('shuffle', true);
    }
  }
}