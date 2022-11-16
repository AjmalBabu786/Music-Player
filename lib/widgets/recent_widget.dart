import 'dart:developer';

import 'package:hive_flutter/adapters.dart';
import 'package:music_player/DataBase/DataBase_functions.dart';
import 'package:music_player/models/myMusic.dart';
import 'package:music_player/widgets/mostplayed.dart';

addRecentplay({required String id}) async {
  Box<MyMusic> allsongs = getSongModelBox();
  Box<List> allplaylistsongs = getPlaylistBox();
  List<MyMusic> allSongList = allsongs.values.toList();
  List<MyMusic> recentplaylistsong =
      await allplaylistsongs.get('recently')!.toList().cast<MyMusic>();

  final selectedsong = allSongList.firstWhere((song) => song.id.contains(id));
  int? mostcount = selectedsong.count;
  selectedsong.count = (mostcount! + 1);
  if (selectedsong.count! > 4) {
    log('most worked');
    addMostplay(id: id);
  }
  if (recentplaylistsong.length > 9) {
    recentplaylistsong.removeLast();
  }
  if (recentplaylistsong.where((song) => song.id == selectedsong.id).isEmpty) {
    recentplaylistsong.insert(0, selectedsong);
    allplaylistsongs.put('recently', recentplaylistsong);
  } else {
    recentplaylistsong.removeWhere((element) => element.id == selectedsong.id);
    recentplaylistsong.insert(0, selectedsong);
    allplaylistsongs.put('recently', recentplaylistsong);
  }
}
