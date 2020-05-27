import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main_container.dart';
import 'services/background_player.dart';

void main() {
  runApp(MyApp());
}

void backgroundTaskEntryPoint() {
  AudioServiceBackground.run(() => BackgroundPlayer());
}

void startAudioService() {
  AudioService.start(
    backgroundTaskEntrypoint: backgroundTaskEntryPoint,
    androidNotificationChannelName: 'Music Player',
    enableQueue: true,
    androidStopOnRemoveTask: true,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if(!AudioService.running) {
      startAudioService();
    }
    
    return MaterialApp(
      title: 'Music Player',
      theme: _buildThemeData(),
      darkTheme: _buildDarkThemeData(),
      debugShowCheckedModeBanner: false,
      home: AudioServiceWidget(child: MainContainer()),
    );
  }

  ThemeData _buildDarkThemeData() {
    return ThemeData(
      primarySwatch: Colors.indigo,
      accentColor: Colors.pinkAccent,
      brightness: Brightness.dark
    );
  }
  
  ThemeData _buildThemeData() {
    return ThemeData(
      primarySwatch: Colors.blue,
      accentColor: Colors.yellowAccent,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Color.fromARGB(255, 245, 245, 246),
      brightness: Brightness.light
    );
  }
}