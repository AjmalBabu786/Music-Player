import 'dart:developer';

import 'package:hive_flutter/adapters.dart';
import 'package:music_player/DataBase/DataBase_functions.dart';
import 'package:music_player/models/myMusic.dart';

import 'colorApp.dart';
import 'package:flutter/material.dart';

class PlaylistCreate extends StatefulWidget {
  const PlaylistCreate({super.key});

  @override
  State<PlaylistCreate> createState() => _PlaylistCreateState();
}

class _PlaylistCreateState extends State<PlaylistCreate> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

playlistsshows(
    {required BuildContext context,
    required String bgimage,
    required String libraryText,
    required Function() librartontap,
    required TextEditingController edittextcontroller}) {}

// *************DELETE PLAYLIST ALERTBOX**********

deletePlaylistAlertBox(
    {required BuildContext context,
    required comment,
    required void Function() onPressed}) {
  return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colormyapp.maincolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Confirm Deletion',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            comment,
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            TextButton(
              onPressed: onPressed,
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        );
      });
}

// playlistCreateAlertBox(
//     {required BuildContext context,
//     required TextEditingController mytextController}) {
//   return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colormyapp.maincolor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           title: Text(
//             'Create playlist',
//             style: TextStyle(
//                 color: Colormyapp.white,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {},
//               child: Text(
//                 'Cancel',
//                 style: TextStyle(color: Colormyapp.white, fontSize: 15),
//               ),
//             ),
//             TextButton(
//               onPressed: () {},
//               child: Text(
//                 'Confirm',
//                 style: TextStyle(color: Colormyapp.white, fontSize: 15),
//               ),
//             ),
//           ],
//         );
//       });
// }

// ***********PLAYLIST TEXTFIED ADD PLAYLIST************

createPLaylistTextField(
    {required BuildContext context,
    required String alertTitle,
    required String textLabel,
    required TextEditingController mytextController}) {
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
          controller: mytextController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            labelText: textLabel,
            labelStyle: const TextStyle(color: Colors.grey),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              mytextController.clear();
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: Colormyapp.white, fontSize: 15),
            ),
          ),
          TextButton(
            onPressed: () {
              playlistNameadd(
                  mytextController: mytextController, context: context);
              log('worked');
              mytextController.clear();
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

playLIstAddModelSheet({
  required BuildContext context,
  required String songName,
  required String artistName,
  required TextEditingController mytextController,
  required String id,
}

//     String songImage
    ) {
  final playlistBox = getCreatePlaylistBox();

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
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: Colormyapp.maincolor,
                ),
                onPressed: () {
                  createPLaylistTextField(
                      context: context,
                      alertTitle: "Create Playlist",
                      textLabel: 'Enter Playlist Name ',
                      mytextController: mytextController);
                },
                icon: const Icon(Icons.playlist_play_sharp),
                label: const Text('Create Playlist')),
            ValueListenableBuilder(
                valueListenable: playlistBox.listenable(),
                builder: (BuildContext context, Box<List<dynamic>> value,
                    Widget? _) {
                  return Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: playlistBox.listenable(),
                        builder: (BuildContext context,
                            Box<List<dynamic>> value, Widget? _) {
                          final List<String> playlistKeys =
                              playlistBox.keys.toList().cast<String>();

                          return ListView.builder(
                            itemBuilder: (context, index) {
                              Size size = MediaQuery.of(context).size;
                              return ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  addSonginPlaylist(
                                      mykey: playlistKeys[index],
                                      id: id,
                                      context: context);
                                  log("message");
                                },
                                leading: Image.asset(
                                  'asset/images/—Pngtree—music microphone_5421282.png',
                                  height: 30,
                                  width: 30,
                                ),
                                title: Text(
                                  playlistKeys[index],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              );
                            },
                            itemCount: playlistKeys.length,
                          );
                        }),
                  );
                })
          ],
        ),
      );
    },
  );
}

playlistNameadd(
    {required TextEditingController mytextController,
    required BuildContext context}) {
  Box<List> playlistNameAdd = getCreatePlaylistBox();
  playlistNameAdd.put(mytextController.text, []);
  log(playlistNameAdd.length.toString());
  Navigator.pop(context);
}

// *****************Add playlist function ******************
addSonginPlaylist(
    {required String mykey,
    required String id,
    required BuildContext context}) {
  Box<MyMusic> playlistsongadd = getSongModelBox();
  Box<List> addsongsplaylist = getCreatePlaylistBox();
  List<MyMusic> allsongs = playlistsongadd.values.toList();
  final playlistAddSongs = addsongsplaylist.get(mykey)!.toList();

  final selectedsong = allsongs.firstWhere((song) => song.id.contains(id));
  if (playlistAddSongs.where((song) => song.id == selectedsong.id).isEmpty) {
    playlistAddSongs.add(selectedsong);
    addsongsplaylist.put(mykey, playlistAddSongs);
    log(playlistAddSongs.length.toString());
    songAddplaylistSnackBar(
        context: context,
        songName: selectedsong.id,
        message: '{song added to$mykey}');
  } else {
    log(playlistAddSongs.length.toString());
    songAddplaylistSnackBar(
      context: context,
      message: 'This song wasalready added to your playlist',
      songName: selectedsong.title,
    );
  }
}

//  *********playlist snackbar***************
songAddplaylistSnackBar(
    {required BuildContext context,
    required String songName,
    required String message}) {
  final snackbatr = SnackBar(
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
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          songName,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13,
          ),
        ),
      ],
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbatr);
}
// ****************** delete song from playlist**************

DeleteFromPlaylist(
    {required String playlistkey, required String songid}) async {
  Box<List> playlistsong = getCreatePlaylistBox();
  final List<MyMusic> songplaylist =
      playlistsong.get(playlistkey)!.toList().cast<MyMusic>();
  Box<MyMusic> songsBox = getSongModelBox();
  List<MyMusic> allsongs = songsBox.values.toList().cast<MyMusic>();

  final selectedsong =
      allsongs.firstWhere((element) => element.id.contains(songid));
  songplaylist.removeWhere((element) => element.id == songid);
  await playlistsong.put(playlistkey, songplaylist);
}

// *************Edit playlist name *****************

renameplaylist(
    {required TextEditingController myTextcontroller, required String mykey}) {
  String renametext = myTextcontroller.text;
  Box<List> playlistBox = getCreatePlaylistBox();
  final List<MyMusic> playlistSongs =
      playlistBox.get(mykey)!.toList().cast<MyMusic>();
  playlistBox.delete(mykey);
  log('delete');
  playlistBox.put(renametext, playlistSongs);
  log('hive put');
}

RenameplaylistTextField(
    {required BuildContext context,
    required String alertTitle,
    required String textLabel,
    required TextEditingController mytextController,
    required String mykey}) {
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
          controller: mytextController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            labelText: textLabel,
            labelStyle: const TextStyle(color: Colors.grey),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: Colormyapp.white, fontSize: 15),
            ),
          ),
          TextButton(
            onPressed: () {
              renameplaylist(myTextcontroller: mytextController, mykey: mykey);
              log('rename function');
              Navigator.pop(context);
              mytextController.clear();
              log('worked');
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

//  *******************Delete playlist****************

Deleteplaylist({required String mykey}) {
  Box<List> playlistbox = getCreatePlaylistBox();
  playlistbox.delete(mykey);
  log('delete');
}
