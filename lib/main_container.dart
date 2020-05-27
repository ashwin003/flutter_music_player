import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player/ui/widgets/players/bottom_sheet_container.dart';

import 'home.dart';

class MainContainer extends StatefulWidget {
  @override
  _MainContainerState createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> with WidgetsBindingObserver {

  GlobalKey<NavigatorState> _key = GlobalKey();
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
        body: WillPopScope(
          onWillPop: _preparePopupHandler,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              _buildNavigator(),
              BottomSheetContainer()
            ],
          ),
        )
      ),
    );
  }

  Future<bool> _preparePopupHandler() async {
    if(_key.currentState.canPop()) {
      _key.currentState.pop();
      return false;
    }
    return true;
  }

  Navigator _buildNavigator() {
    return Navigator(
      key: _key,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) {
            return Home();
          }
        );
      },
    );
  }
}