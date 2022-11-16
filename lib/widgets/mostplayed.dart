import 'dart:developer';

import 'package:hive_flutter/adapters.dart';
import 'package:music_player/DataBase/DataBase_functions.dart';
import 'package:music_player/models/myMusic.dart';

addMostplay({required String id}) async {
  Box<MyMusic> allsongs = getSongModelBox();
  Box<List> allplaylistsongs = getPlaylistBox();
  List<MyMusic> allSongList = allsongs.values.toList();
  List<MyMusic> mostplaylistsong =
      allplaylistsongs.get('mostplay')!.toList().cast<MyMusic>();

  final selectedsong = allSongList.firstWhere((song) => song.id.contains(id));
  if (mostplaylistsong.length > 5) {
    mostplaylistsong.removeLast();
    log('most function');
  }
  if (mostplaylistsong.where((song) => song.id == selectedsong.id).isEmpty) {
    mostplaylistsong.insert(0, selectedsong);
    allplaylistsongs.put('mostplay', mostplaylistsong);
  } else {
    mostplaylistsong.removeWhere((element) => element.id == selectedsong.id);
    mostplaylistsong.insert(0, selectedsong);
    allplaylistsongs.put('mostplay', mostplaylistsong);
  }
}
