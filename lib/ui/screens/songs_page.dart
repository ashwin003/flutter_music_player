import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../models/request_songs.dart';
import '../../services/audio_service.dart';
import '../widgets/list_songs.dart';

class SongsPage extends StatelessWidget {
  static const String routeName = "/songs";
  final AudioService audioService;

  const SongsPage({Key key, this.audioService}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    var request = ModalRoute.of(context).settings.arguments as RequestSongs;
    return Scaffold(
      appBar: AppBar(
        title: _prepareHeader(request),
      ),
      body: _buildSongsList(request),
    );
  }

  Widget _prepareHeader(RequestSongs request) {
    if(request.playlistInfo != null) {
      return Text(request.playlistInfo.name ?? '');
    }
    if(request.albumId != null || request.artistName != null) {
      return Text(request.title ?? '');
    }
    return Text('');
  }

  LoadSongsList _buildSongsList(RequestSongs request) {
    if(request.playlistInfo != null) {
      return LoadSongsList(songs: audioService.getSongsFromPlaylist(request.playlistInfo),);
    }
    if(request.albumId != null) {
      return LoadSongsList(songs: audioService.getSongsFromAlbum(request.albumId),);  
    }
    if(request.artistName != null) {
      return LoadSongsList(songs: audioService.getSongsFromArtist(request.artistName));  
    }
    return LoadSongsList(songs: audioService.getSongs(),);
  }
}