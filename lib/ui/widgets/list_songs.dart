import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/tiles/song_tile.dart';

class LoadSongsList extends StatelessWidget {
  final Future<List<MediaItem>> songs;

  const LoadSongsList({Key key, this.songs}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: songs,
      builder: (ctx, AsyncSnapshot<List<MediaItem>> snapshot) {
        if(snapshot.hasData) {
          return ListSongs(songs: snapshot.data,);
        }
        return Center(child: CircularProgressIndicator() ,);
      },
    );
  }
}

class ListSongs extends StatelessWidget {
  final List<MediaItem> songs;

  const ListSongs({Key key, this.songs}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView.builder(
            itemCount: songs.length,
            padding: EdgeInsets.symmetric(horizontal: 8,),
            itemBuilder: (b, index) {
              if(index == 0) {
                return _prepareFirstRow(context);
              }
              return SongTile(songs[index], (song) => {
                _handleTapped(song, false)
              });
            },
          ),
    );
  }

  void _handleTapped(MediaItem selectedSong, bool toShuffle) async {
    AudioService.replaceQueue(songs);
    AudioService.customAction('shuffle', toShuffle);
    if(!toShuffle) {
      await AudioService.playMediaItem(selectedSong);
    }
  }

  Widget _prepareFirstRow(BuildContext context) {
    return Column(
      children: <Widget>[
        _prepareShuffleWidget(),
        SongTile(songs[0], (song) => {
          _handleTapped(song, false)
        } )
      ],
    );
  }

  Widget _prepareShuffleWidget()  {
    return Card(
      child: InkWell(
        onTap: (){
        },
        child: ListTile(
          contentPadding: EdgeInsets.all(8),
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Icon(Icons.shuffle),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text('Shuffle All'),
          ),
          onTap: () {
            _handleTapped(null, true);
          },
        ),
      ),
    );
  }
}