import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../mixins/bottom_sheet_handler.dart';
import '../widgets/controls/hero_artwork.dart';
import '../../models/request_songs.dart';
import '../../services/audio_service.dart';
import '../widgets/list_songs.dart';

class SongsPage extends StatelessWidget with BottomSheetHandler {
  static const String routeName = "/songs";
  final AudioService audioService;

  const SongsPage({Key key, this.audioService}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    var request = ModalRoute.of(context).settings.arguments as RequestSongs;
    return Scaffold(
      appBar: AppBar(
        title: _prepareHeader(request),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: _prepareArtwork(request)
          )
        ],
      ),
      body: addBottomSheet(
        child: _buildSongsList(request),
      ),
    );
  }

  Widget _prepareHeader(RequestSongs request) {
    if(request.playlistInfo != null) {
      return Text(request.playlistInfo.name ?? '');
    }
    else if(request.albumInfo != null) {
      return Text(request.albumInfo.title ?? '');
    }
    else if(request.artistInfo != null) {
      return Text(request.artistInfo.name ?? '');
    }
    return Text('');
  }

  LoadSongsList _buildSongsList(RequestSongs request) {
    if(request.playlistInfo != null) {
      return LoadSongsList(songs: audioService.getSongsFromPlaylist(request.playlistInfo),);
    }
    if(request.albumInfo != null) {
      return LoadSongsList(songs: audioService.getSongsFromAlbum(request.albumInfo.id),);  
    }
    if(request.artistInfo != null) {
      return LoadSongsList(songs: audioService.getSongsFromArtist(request.artistInfo.name));  
    }
    return LoadSongsList(songs: audioService.getSongs(),);
  }

  HeroArtwork _prepareArtwork(RequestSongs request) {
    if(request.playlistInfo != null) {
      return HeroArtwork(
        id: request.playlistInfo.hashCode.toString(),
        path: null,
      );
    }
    if(request.albumInfo != null) {
      return HeroArtwork(
        id: request.albumInfo.hashCode.toString(),
        path: request.albumInfo.albumArt,
      );
    }
    if(request.artistInfo != null) {
      return HeroArtwork(
        id: request.artistInfo.hashCode.toString(),
        path: request.artistInfo.artistArtPath,
      );
    }
    return null;
  }
}