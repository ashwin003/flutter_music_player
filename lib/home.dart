import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

import 'mixins/bottom_sheet_handler.dart';
import 'ui/screens/albums_tab.dart';
import 'ui/screens/artists_tab.dart';
import 'ui/screens/playlists_tab.dart';
import 'ui/screens/songs_tab.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver, BottomSheetHandler {
  @override
  Widget build(BuildContext context) {
    return _buildTabController();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.detached) {
      await AudioService.stop();
      await AudioService.disconnect();
    }
  }

  DefaultTabController _buildTabController() {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: addBottomSheet(
          child: _buildTabBarView()
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
              title: Text('Music Player'),
              bottom: _buildTabBar(),
              actions: _buildActions(),
        );
  }

  List<Widget> _buildActions() {
    return <Widget>[
      _prepareAction(Icons.settings, (){})
    ];
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

  Widget _prepareAction(IconData icon, Function onPressed) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
      ),
    );
  }
}