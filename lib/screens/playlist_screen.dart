import 'dart:developer';

import 'package:hive_flutter/adapters.dart';
import 'package:music_player/DataBase/DataBase_functions.dart';
import 'package:music_player/screens/listOpen.dart';
import 'package:music_player/widgets/favoutite_widget.dart';

import '../widgets/colorApp.dart';

import 'package:flutter/material.dart';

import '../widgets/playlist.dart';

class Playlist_screen extends StatefulWidget {
  const Playlist_screen({super.key, this.id});
  final String? id;

  @override
  State<Playlist_screen> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist_screen> {
  Box<List> playlistadd = getCreatePlaylistBox();

  TextEditingController mytextController = TextEditingController();
  bool textfieldvisiblity = false;
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colormyapp.maincolor,
      appBar: AppBar(
        backgroundColor: Colormyapp.maincolor,
        centerTitle: true,
        titleTextStyle:
            const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        title: const Text(
          'PLaylist',
        ),
        actions: [
          IconButton(
            onPressed: () {
              createPLaylistTextField(
                  mytextController: mytextController,
                  context: context,
                  alertTitle: 'Create Playlist',
                  textLabel: 'entet playlist name');
            },
            icon: const Icon(Icons.add_outlined),
            iconSize: 30,
          ),
        ],
        // leading: IconButton(
        //     onPressed: () {}, icon: Icon(Icons.arrow_back_ios_rounded),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: playlistadd.listenable(),
                builder:
                    (BuildContext context, Box<List<dynamic>> value, Widget_) {
                  final List playlistKeys =
                      playlistadd.keys.toList().cast<String>();

                  return playlistKeys.isEmpty
                      ? const Center(
                          child: Text(
                            'No Playlists',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 10,
                                  crossAxisCount:
                                      (orientation == Orientation.portrait)
                                          ? 2
                                          : 3),
                          itemBuilder: (ctx, index) {
                            TextEditingController mytextrenamecontroller =
                                TextEditingController(
                                    text: playlistKeys[index]);
                            return Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return Drive(
                                        songkey: playlistKeys[index],
                                        mytexteditcontroller: mytextController,
                                      );
                                    }));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    height: size.height * 0.3,
                                    width: size.width * 0.5,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: const Image(
                                        image: AssetImage(
                                            "asset/images/female singer.jpg"),
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
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.5),
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    height: 25,
                                    width: 60,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0,
                                                  ),
                                                  playlistKeys[index]
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: ctx,
                                                backgroundColor:
                                                    Colors.transparent,
                                                builder: (context) {
                                                  return Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 46, 62, 87),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(50),
                                                              topRight: Radius
                                                                  .circular(
                                                                      50)),
                                                    ),
                                                    height: 300,
                                                    child: Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        ElevatedButton.icon(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 30,
                                                                      right: 30,
                                                                      top: 8,
                                                                      bottom:
                                                                          8),
                                                              backgroundColor:
                                                                  Colormyapp
                                                                      .maincolor,
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                              RenameplaylistTextField(
                                                                  context:
                                                                      context,
                                                                  alertTitle:
                                                                      'Rename Playlist',
                                                                  textLabel:
                                                                      'Enter playlist name',
                                                                  mytextController:
                                                                      mytextrenamecontroller,
                                                                  mykey:
                                                                      playlistKeys[
                                                                          index]);
                                                            },
                                                            icon: const Icon(Icons
                                                                .edit_note_rounded),
                                                            label: const Text(
                                                                'Rename')),
                                                        ElevatedButton.icon(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              backgroundColor:
                                                                  Colormyapp
                                                                      .maincolor,
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(ctx)
                                                                  .pop();
                                                              deletePlaylistAlertBox(
                                                                  onPressed:
                                                                      () {
                                                                    log('message');
                                                                    Deleteplaylist(
                                                                        mykey: playlistKeys[
                                                                            index]);
                                                                    Navigator.of(
                                                                            ctx)
                                                                        .pop();
                                                                    showFavouritesSnackBar(
                                                                      txrclr:
                                                                          Colors
                                                                              .red,
                                                                      context:
                                                                          ctx,
                                                                      songName:
                                                                          playlistKeys[
                                                                              index],
                                                                      message:
                                                                          'Playlist Deleted',
                                                                    );
                                                                  },
                                                                  context:
                                                                      context,
                                                                  comment:
                                                                      'Do you want to delete this playlist');
                                                            },
                                                            icon: const Icon(
                                                                Icons.delete),
                                                            label: const Text(
                                                                'Delete PLaylist'))
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                              print('clicked');
                                            },
                                            child: const Icon(
                                              Icons.playlist_add,
                                              size: 30,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                          itemCount: playlistKeys.length,
                        );
                }),
          ),
        ],
      ),
    );
  }
}
