import 'package:audio_service/audio_service.dart';

class ActionsHandler {
  factory ActionsHandler._() => null;

  void handleAction(Future<List<MediaItem>> future, String action) async{
    var songs = await future;
    AudioService.replaceQueue(songs);
    if('Play' == action) {
      AudioService.playMediaItem(songs.first);
    } else if('Shuffle' == action) {
      AudioService.customAction('shuffle', true);
    }
  }
}