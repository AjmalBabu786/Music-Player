import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/DataBase/DataBase_functions.dart';
import 'package:music_player/models/myMusic.dart';
import 'package:music_player/widgets/common_widgets.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'miniplayer_widget.dart';
import 'package:flutter/material.dart';

allSongs({
  required List<MyMusic> songlist,
  required int index,
  required BuildContext context,
}) {
  return ListTile(
    onTap: () {
      miniplayersheet(context: context, index: index, songs: songlist);
      log('ontap');
    },
    leading: SizedBox(
      height: 80,
      width: 60,
      child: QueryArtworkWidget(
          nullArtworkWidget: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              'asset/images/DefaultNew.webp',
              fit: BoxFit.fill,
            ),
          ),
          id: int.parse(songlist[index].id),
          type: ArtworkType.AUDIO),
    ),
    title: Text(
      songlist[index].title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 17.0,
        color: Colors.white,
      ),
    ),
    subtitle: Text(
      songlist[index].artist,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
        color: Colors.white,
      ),
    ),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        homeScreenIcons(
          icons: Icons.favorite,
          iconColor: favouriteiconchange(id: songlist[index].id),
          iconSize: 30,
          onpressed: () {
            addfavouritesong(
              id: songlist[index].id,
            );
            log('function');
          },
        ),
        const SizedBox(
          width: 10,
        ),
        homeScreenIcons(
          icons: Icons.playlist_add,
          iconColor: Colors.white,
          iconSize: 30,
          onpressed: () {
            // playLIstAddModelSheet(
            //     context: context,
            //     songName: assetsongList[index].metas.title!,
            //     artistName: assetsongList[index].metas.artist!,
            //     songImage: assetsongimage[index]);
            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ,))
          },
        ),
      ],
    ),
  );
}

listviewontainer(
    {required String bgimage,
    required String libraryText,
    required Function() librartontap,
    required BuildContext context}) {
  Size size = MediaQuery.of(context).size;
  return Stack(
    children: [
      GestureDetector(
        onTap: librartontap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          height: size.height * 0.3,
          width: size.width * 0.4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image: AssetImage(bgimage),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            child: Text(
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              libraryText,
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.6),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            margin: EdgeInsets.symmetric(horizontal: 6),
            height: size.height * 0.04,
            width: 60,
          ))
    ],
  );
}

// goToNowPlay(BuildContext context, String imageName, int index, String songName,
//     String artistName) async {
//   Navigator.of(context).push(MaterialPageRoute(
//     builder: (context) => Nowplay(
//       ArtistName: artistName,
//       songName: songName,
//       imageName: imageName,
//       index: index,
//     ),
//   ));
// }

homeScreenIcons(
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

Widget drawersettings(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Drawer(
    width: size.width * 0.8,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(bottomRight: Radius.circular(300)),
    ),
    backgroundColor: Color.fromARGB(255, 19, 10, 40),
    child: Container(
      child: Column(
        children: [
          Image.asset('asset/images/logo.webp'),
          settingsLIsttile(
            text: 'About',
            firstIcon: Icons.person,
            lastIcon: Icons.arrow_forward_ios_rounded,
          ),
          settingsLIsttile(
              text: 'Notifivation', firstIcon: Icons.notifications_active),
          settingsLIsttile(
            text: 'Privacy&Policy',
            firstIcon: Icons.policy_rounded,
            lastIcon: Icons.arrow_forward_ios_rounded,
          ),
          settingsLIsttile(
            text: 'Terms&Conditions',
            firstIcon:
                Icons.signal_cellular_connected_no_internet_0_bar_outlined,
            lastIcon: Icons.arrow_forward_ios_rounded,
          ),
          SizedBox(
            height: size.height * 0.06,
          ),
          Text(
            'Version',
            style: TextStyle(color: Color.fromARGB(255, 122, 107, 107)),
          ),
          Text(
            '1.0.0',
            style: TextStyle(color: Color.fromARGB(255, 122, 107, 107)),
          ),
        ],
      ),
    ),
  );
}

settingsLIsttile(
    {required String text,
    required IconData firstIcon,
    IconData? lastIcon,
    bool trueORfalse = true}) {
  return ListTile(
    leading: Icon(
      firstIcon,
      color: Colors.white,
    ),
    title: Text(
      text,
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
    trailing: lastIcon != null
        ? Icon(
            lastIcon,
            color: Colors.white,
          )
        : Switch(
            value: trueORfalse,
            onChanged: (value) {
              trueORfalse = value;
            },
          ),
  );
}

addfavouritesong({required String id}) async {
  final Box<MyMusic> hiveAllSongs = getSongModelBox();
  final List<MyMusic> allSongs = hiveAllSongs.values.toList();
  final Box<List> playlistsong = getPlaylistBox();
  final List<MyMusic> favouritelist =
      playlistsong.get('favourite')!.toList().cast<MyMusic>();
  final selectedsong = allSongs.firstWhere((song) => song.id.contains(id));
  if (favouritelist.where((song) => selectedsong.id == song.id).isEmpty) {
    favouritelist.add(selectedsong);
    await playlistsong.put('favourite', favouritelist);
    log('added');
  } else {
    favouritelist.remove(selectedsong);
    await playlistsong.put('favourite', favouritelist);
    log('removed');
  }
}
