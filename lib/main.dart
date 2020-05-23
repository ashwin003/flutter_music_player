import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'services/audio_service.dart' as AS;
import 'ui/screens/albums_page.dart';
import 'ui/screens/songs_page.dart';
import 'home.dart';
import 'services/background_player.dart';

void main() {
  runApp(MyApp());
}

void backgroundTaskEntryPoint() {
  AudioServiceBackground.run(() => BackgroundPlayer());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if(!AudioService.running) {
      AudioService.start(
        backgroundTaskEntrypoint: backgroundTaskEntryPoint,
        androidNotificationChannelName: 'Music Player',
        enableQueue: true,
        androidStopOnRemoveTask: true,
      );
    }
    
    return MaterialApp(
      title: 'Music Player',
      theme: _buildThemeData(),
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
      debugShowCheckedModeBanner: false,
      home: AudioServiceWidget(child: Home()),
      routes: {
        AlbumsPage.routeName: (ctx) => AlbumsPage(audioService: AS.AudioService(),),
        SongsPage.routeName: (ctx) => SongsPage(audioService: AS.AudioService(),)
      }
    );
  }
  
  ThemeData _buildThemeData() {
    return ThemeData(
      primarySwatch: Colors.blue,
      accentColor: Colors.limeAccent,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Color.fromARGB(255, 245, 245, 246),
      brightness: Brightness.light
    );
  }
}