import 'package:flutter_audio_query/flutter_audio_query.dart';

class RequestSongs {
  final PlaylistInfo playlistInfo;
  final String albumId;
  final String artistName;
  final String title;

  RequestSongs({this.playlistInfo, this.albumId, this.artistName, this.title});
}