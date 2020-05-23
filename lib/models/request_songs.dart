import 'package:flutter_audio_query/flutter_audio_query.dart';

class RequestSongs {
  final PlaylistInfo playlistInfo;
  final AlbumInfo albumInfo;
  final ArtistInfo artistInfo;

  RequestSongs({this.playlistInfo, this.albumInfo, this.artistInfo});
}