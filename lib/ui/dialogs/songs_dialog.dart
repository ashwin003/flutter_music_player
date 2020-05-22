import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../../services/audio_service.dart';
import '../widgets/list_songs.dart';

class SongsDialog extends StatefulWidget {
  final PlaylistInfo playlistInfo;
  final String albumId;
  final String artistName;
  final String title;

  const SongsDialog({Key key, this.playlistInfo, this.albumId, this.artistName, this.title}) : super(key: key);
  @override
  _SongsDialogState createState() => _SongsDialogState();
}

class _SongsDialogState extends State<SongsDialog> {
  AudioService service;

  @override
  void initState() {
    super.initState();
    service = AudioService();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _prepareHeader(),
      ),
      body: _buildSongsList(),
    );
  }

  Widget _prepareHeader() {
    if(widget.playlistInfo != null) {
      return Text(widget.playlistInfo.name ?? '');
    }
    if(widget.albumId != null || widget.artistName != null) {
      return Text(widget.title ?? '');
    }
    return Text('');
  }

  LoadSongsList _buildSongsList() {
    if(widget.playlistInfo != null) {
      return LoadSongsList(songs: service.getSongsFromPlaylist(widget.playlistInfo),);
    }
    if(widget.albumId != null) {
      return LoadSongsList(songs: service.getSongsFromAlbum(widget.albumId),);  
    }
    if(widget.artistName != null) {
      return LoadSongsList(songs: service.getSongsFromArtist(widget.artistName));  
    }
    return LoadSongsList(songs: service.getSongs(),);
  }
}