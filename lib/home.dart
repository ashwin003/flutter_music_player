import 'package:flutter/material.dart';

import 'ui/widgets/controls/artwork.dart';
import 'ui/screens/albums_tab.dart';
import 'ui/screens/artists_tab.dart';
import 'ui/screens/playlists_tab.dart';
import 'ui/screens/songs_tab.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildTabBarView(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Artwork(path: null, id: 'home'),
      ),
      title: Text('Music Player'),
      bottom: _buildTabBar(),
);
  }

  TabBar _buildTabBar() {
    return TabBar(
      tabs: <Widget>[
        Tab(text: 'Playlists'),
        Tab(text: 'Artists'),
        Tab(text: 'Albums',),
        Tab(text: 'Songs',),
      ],
    );
  }

  TabBarView _buildTabBarView() {
    return TabBarView(
          children: <Widget>[
            PlaylistsTab(),
            ArtistsTab(),
            AlbumsTab(),
            SongsTab(),
          ],
        );
  }
}