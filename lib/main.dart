import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/models/myMusic.dart';

import 'screens/splash_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(MyMusicAdapter().typeId)) {
    Hive.registerAdapter(MyMusicAdapter());
  }
  await Hive.openBox<MyMusic>('mysongs');
  await Hive.openBox<List>('playlist');
  await Hive.openBox<List>('playlistcreate');
  runApp(const MyMusicPlayer());
}

class MyMusicPlayer extends StatelessWidget {
  const MyMusicPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splash_screen(),
    );
  }
}
