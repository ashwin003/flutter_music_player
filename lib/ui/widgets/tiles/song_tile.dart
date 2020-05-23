import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../extensions/durationExtensions.dart';
import '../controls/artwork.dart';

class SongTile extends StatelessWidget {
  final MediaItem songInfo;
  final ValueSetter<MediaItem>  onTapped;

  const SongTile(this.songInfo, this.onTapped, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: (){
          onTapped(songInfo);
        },
        child: ListTile(
          contentPadding: EdgeInsets.all(8),
          leading: Artwork(
            path: songInfo.artUri,
            id: songInfo.id,
          ),
          title: Text(songInfo.title,),
          subtitle: Text(_prepareSubTitle(), maxLines: 2,),
        ),
      ),
    );
  }

  String _prepareSubTitle() {
    final Duration duration = Duration(milliseconds: songInfo.duration);
    return "${songInfo.artist} | ${duration.toTimeString() }";
  }
}