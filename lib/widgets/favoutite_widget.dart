import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/models/myMusic.dart';
import 'package:music_player/widgets/colorApp.dart';

import '../DataBase/DataBase_functions.dart';

homeScreenhomeScreenIcons(
    {required IconData icons,
    required double iconSize,
    required Color iconColor,
    required Function() onpressed}) {
  return IconButton(
    onPressed: onpressed,
    icon: Icon(
      icons,
      size: iconSize,
    ),
    color: (iconColor),
  );
}

favouriteIcons(
    {required IconData icons,
    required double iconSize,
    required Color iconColor,
    required Function() onpressed}) {
  return IconButton(
    onPressed: onpressed,
    icon: Icon(
      icons,
      size: iconSize,
    ),
    color: (iconColor),
  );
}

addfavouritesong({required String id, required BuildContext context}) async {
  final Box<MyMusic> hiveAllSongs = getSongModelBox();
  final List<MyMusic> allSongs = hiveAllSongs.values.toList();
  final Box<List> playlistsong = getPlaylistBox();
  final List<MyMusic> favouritelist =
      playlistsong.get('favourite')!.toList().cast<MyMusic>();
  final selectedsong = allSongs.firstWhere((song) => song.id.contains(id));
  if (favouritelist.where((song) => selectedsong.id == song.id).isEmpty) {
    favouritelist.add(selectedsong);
    await playlistsong.put('favourite', favouritelist);
    showFavouritesSnackBar(
        txrclr: Colors.green,
        context: context,
        message: 'Added to favourites',
        songName: selectedsong.title);
    log('added');
  } else {
    favouritelist.remove(selectedsong);
    await playlistsong.put('favourite', favouritelist);
    showFavouritesSnackBar(
        txrclr: Colors.red,
        context: context,
        songName: selectedsong.title,
        message: 'Removed from favourite');
    log('removed');
  }
}

showFavouritesSnackBar(
    {required BuildContext context,
    required String songName,
    required String message,
    required Color txrclr}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: Colormyapp.black,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: TextStyle(
              color: txrclr,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            songName,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
            ),
          ),
        ],
      ),
    ),
  );
}

Color favouriteiconchange({required String id}) {
  final Box<MyMusic> hiveAllSongs = getSongModelBox();
  final List<MyMusic> allSongs = hiveAllSongs.values.toList();
  final Box<List> playlistsong = getPlaylistBox();
  final List<MyMusic> favouritelist =
      playlistsong.get('favourite')!.toList().cast<MyMusic>();

  MyMusic favsongs = allSongs.firstWhere((song) => song.id.contains(id));
  return favouritelist.where((song) => song.id == favsongs.id).isEmpty
      ? Colors.white
      : Colors.red;
}
