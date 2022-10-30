import 'package:flutter/material.dart';

noePlayBUttons(
    {required IconData icons,
    required double iconSize,
    required Function() onpressed}) {
  return IconButton(
    onPressed: onpressed,
    icon: Icon(
      icons,
      size: iconSize,
    ),
    color: Colors.white,
  );
}

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

// noePlayBUttons({required IconData icons, required double iconSize}) {
//   return IconButton(
//     onPressed: () {
    
//     },
//     icon: Icon(
//       icons,
//       size: iconSize,
//     ),
//     color: Colors.white,
//   );
// }
