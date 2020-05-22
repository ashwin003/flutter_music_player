import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../services/audio_service.dart';
import '../widgets/list_songs.dart';

class SongsTab extends StatefulWidget {
  @override
  _SongsTabState createState() => _SongsTabState();
}

class _SongsTabState extends State<SongsTab> {
  AudioService service;

  @override
  void initState() {
    super.initState();
    service = AudioService();
  }
  @override
  Widget build(BuildContext context) {
    return LoadSongsList(songs: service.getSongs(),);
  }
}