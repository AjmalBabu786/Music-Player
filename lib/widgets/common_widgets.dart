import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/models/myMusic.dart';
import 'package:music_player/widgets/miniplayer_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../DataBase/DataBase_functions.dart';
import 'colorApp.dart';
import 'home_widgets.dart';
import 'package:flutter/material.dart';

import 'favoutite_widget.dart';

class ListtileWidget extends StatefulWidget {
  const ListtileWidget({
    super.key,
    required this.context,
    required this.index,
    required this.songList,
  });

  final BuildContext context;

  final List<MyMusic> songList;
  final int index;

  @override
  State<ListtileWidget> createState() => _ListtileWidgetState();
}

class _ListtileWidgetState extends State<ListtileWidget> {
  @override
  void initState() {
    favouriteiconchange(id: widget.songList[widget.index].id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        miniplayersheet(
          context: context,
          index: widget.index,
          songs: widget.songList,
        );
      },
      leading: Container(
        height: 80,
        width: 60,
        child: QueryArtworkWidget(
          type: ArtworkType.AUDIO,
          nullArtworkWidget: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'asset/images/DefaultNew.webp',
                fit: BoxFit.fill,
              )),
          id: int.parse(widget.songList[widget.index].id),
        ),
      ),
      title: Text(
        widget.songList[widget.index].title,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17.0,
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        widget.songList[widget.index].artist,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
          color: Colors.white,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          favouriteIcons(
            icons: Icons.favorite,
            iconColor:
                favouriteiconchange(id: widget.songList[widget.index].id),
            iconSize: 30,
            onpressed: () {
              setState(() {
                addfavouritesong(id: widget.songList[widget.index].id);
                favouriteiconchange(id: widget.songList[widget.index].id);
              });
            },
          ),
          const SizedBox(
            width: 10,
          ),
          favouriteIcons(
            icons: Icons.playlist_add,
            iconColor: Colors.white,
            iconSize: 30,
            onpressed: () {
              // playLIstAddModelSheet(
              //     context: context,
              //     songName: assetsongList[index].metas.title!,
              //     artistName: assetsongList[index].metas.artist!,
              //     songImage: assetsongimage[index]);
            },
          ),
        ],
      ),
    );
    ;
  }
}

// ***************PlaylistAdd BottomSheet Function*************
playLIstAddModelSheet(
    {required BuildContext context,
    required String songName,
    required String artistName,
    required String songImage}) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 27, 33, 43),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50)),
        ),
        height: 300,
        child: Column(
          children: [
            Container(
                height: 150,
                width: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: AssetImage(
                                songImage,
                              ),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      songName,
                      style: const TextStyle(fontSize: 17, color: Colors.white),
                    ),
                    Text(
                      artistName,
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                )),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: Colormyapp.maincolor,
                ),
                onPressed: () {
                  createPLaylistTextField(
                      context: context,
                      alertTitle: 'Create PLaylist',
                      textLabel: 'Enter Name');
                },
                icon: const Icon(Icons.playlist_play_sharp),
                label: const Text('CreatePlaylist'))
          ],
        ),
      );
    },
  );
}

// ***************Playlist Add Function***************
songlisttile(
    {required String songname,
    required String artist,
    required songimage,
    required BuildContext context,
    required Color iconolor,
    required List<MyMusic> favlist,
    required int index}) {
  // return ListTile(
  //   onTap: () {

  //   },
  //   leading: Container(
  //     height: 80,
  //     width: 60,
  //     child: QueryArtworkWidget(
  //       type: ArtworkType.AUDIO,
  //       nullArtworkWidget: ClipRRect(
  //           borderRadius: BorderRadius.circular(50),
  //           child: Image.asset(
  //             'asset/images/DefaultNew.webp',
  //             fit: BoxFit.fill,
  //           )),
  //       id: int.parse(songimage),
  //     ),
  //   ),
  //   title: Text(
  //     songname,
  //     overflow: TextOverflow.ellipsis,
  //     style: const TextStyle(
  //       fontWeight: FontWeight.bold,
  //       fontSize: 17.0,
  //       color: Colors.white,
  //     ),
  //   ),
  //   subtitle: Text(
  //     artist,
  //     overflow: TextOverflow.ellipsis,
  //     style: const TextStyle(
  //       fontWeight: FontWeight.bold,
  //       fontSize: 12.0,
  //       color: Colors.white,
  //     ),
  //   ),
  //   trailing: Row(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       favouriteIcons(
  //         icons: Icons.favorite,
  //         iconColor: favouriteiconchange(id: favlist[index].id),
  //         iconSize: 30,
  //         onpressed: () {
  //           addfavouritesong(id: favlist[index].id);
  //         },
  //       ),
  //       const SizedBox(
  //         width: 10,
  //       ),
  //       favouriteIcons(
  //         icons: Icons.playlist_add,
  //         iconColor: Colors.white,
  //         iconSize: 30,
  //         onpressed: () {
  //           // playLIstAddModelSheet(
  //           //     context: context,
  //           //     songName: assetsongList[index].metas.title!,
  //           //     artistName: assetsongList[index].metas.artist!,
  //           //     songImage: assetsongimage[index]);
  //         },
  //       ),
  //     ],
  //   ),
  // );
}

// ***********PLAYLIST CTRATE DIALOGBOX***********

playlistCreateAlertBox({required BuildContext context}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colormyapp.maincolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Create playlist',
            style: TextStyle(
                color: Colormyapp.white,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text(
                'Cancel',
                style: TextStyle(color: Colormyapp.white, fontSize: 15),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Confirm',
                style: TextStyle(color: Colormyapp.white, fontSize: 15),
              ),
            ),
          ],
        );
      });
}

// ***********PLAYLIST TEXTFIED ADD PLAYLIST************

createPLaylistTextField({
  required BuildContext context,
  required String alertTitle,
  required String textLabel,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colormyapp.maincolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          alertTitle,
          style: TextStyle(color: Colormyapp.white),
        ),
        content: TextFormField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            labelText: textLabel,
            labelStyle: const TextStyle(color: Colors.grey),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Cancel',
              style: TextStyle(color: Colormyapp.white, fontSize: 15),
            ),
          ),
          TextButton(
            onPressed: () {
              return;
            },
            child: Text(
              'Confirm',
              style: TextStyle(color: Colormyapp.white, fontSize: 15),
            ),
          ),
        ],
      );
    },
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
