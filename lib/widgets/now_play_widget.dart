// import 'package:flutter/material.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:music_player/DataBase/DataBase_functions.dart';
// import 'package:music_player/models/myMusic.dart';
// import 'package:music_player/widgets/colorApp.dart';

// noePlayBUttons(
//     {required IconData icons,
//     required double iconSize,
//     required Function() onpressed}) {
//   return IconButton(
//     onPressed: onpressed,
//     icon: Icon(
//       icons,
//       size: iconSize,
//     ),
//     color: Colors.white,
//   );
// }

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/DataBase/DataBase_functions.dart';
import 'package:music_player/models/myMusic.dart';
import 'package:music_player/widgets/colorApp.dart';

newPlaySong(
    {required String SongName,
    required IconData FavAndPlaylist,
    required double iconSize,
    required iconolor,
    required Function() favOnpress,
    required double fontsize,
    required BuildContext context}) {
  Size size = MediaQuery.of(context).size;
  return Container(
    height: size.height * 0.05,
    child: Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: size.width * 0.5,
            child: Text(
              SongName,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontsize,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              FavAndPlaylist,
              size: iconSize,
              color: iconolor,
            ),
            onPressed: favOnpress,
            // favIcon,
            // color: iconolor,
            // size: 35,
          ),
        ],
      ),
    ),
  );
}

noePlayBUttons({required IconData icons, required double iconSize}) {
  return IconButton(
    onPressed: () {},
    icon: Icon(
      icons,
      size: iconSize,
    ),
    color: Colors.white,
  );
}

repeateiconchange() {
  Box<MyMusic> hiveAllSong = getSongModelBox();
  Box<List> playlistsongbox = getPlaylistBox();
  List<MyMusic> allSongs = hiveAllSong.values.toList();
  List<MyMusic> playlistSongs =
      playlistsongbox.get('repeate')!.toList().cast<MyMusic>();
}

LyricBottomSheet({required BuildContext context, required String lyrics}) {
  Size size = MediaQuery.of(context).size;
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext ctx, StateSetter setState) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colormyapp.maincolor),
            height: size.height * 0.7,
            child: Column(
              children: [
                Text('LYRICS'),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      lyrics,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      });
}
