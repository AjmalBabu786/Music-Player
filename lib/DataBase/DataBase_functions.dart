import 'package:hive_flutter/adapters.dart';
import 'package:music_player/models/myMusic.dart';

Box<MyMusic> getSongModelBox() {
  return Hive.box<MyMusic>('mysongs');
}

Box<List> getPlaylistBox() {
  return Hive.box<List>('playlist');
}
