import 'package:flutter/rendering.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/DataBase/DataBase_functions.dart';
import 'package:music_player/models/myMusic.dart';
import 'package:music_player/widgets/favoutite_widget.dart';
import 'package:music_player/widgets/playlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../widgets/colorApp.dart';
import '../widgets/common_widgets.dart';
import 'package:flutter/material.dart';

class Drive extends StatefulWidget {
  const Drive(
      {super.key, required this.songkey, required this.mytexteditcontroller});

  final songkey;
  final mytexteditcontroller;
  @override
  State<Drive> createState() => _DriveState();
}

class _DriveState extends State<Drive> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Box<List> allsongs = getCreatePlaylistBox();

    final List<MyMusic> songlist =
        allsongs.get(widget.songkey)!.toList().cast<MyMusic>();

    return Scaffold(
      backgroundColor: Colormyapp.maincolor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colormyapp.maincolor,
        title: Text(
          widget.songkey,
          style: TextStyle(fontSize: 30),
        ),
        actions: [
          IconButton(
            onPressed: () {
              allsongbottomsheet(context: context, mykey: widget.songkey);
            },
            icon: const Icon(Icons.add_outlined),
            iconSize: 30,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: allsongs.listenable(),
                builder:
                    (BuildContext context, Box<List<dynamic>> value, Widget_) {
                  final List<MyMusic> songlist =
                      value.get(widget.songkey)!.toList().cast<MyMusic>();

                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Builder(builder: (context) {
                        return GestureDetector(
                          onLongPress: () {
                            deletePlaylistAlertBox(
                                onPressed: () {
                                  DeleteFromPlaylist(
                                      playlistkey: widget.songkey,
                                      songid: songlist[index].id);
                                  Navigator.pop(context);
                                  showFavouritesSnackBar(
                                      context: context,
                                      songName: songlist[index].id,
                                      message: 'Song Deleted',
                                      txrclr: Colors.red);
                                },
                                context: context,
                                comment: 'Do you want to delete this song');
                          },
                          child: ListtileWidget(
                            context: context,
                            index: index,
                            songList: songlist,
                          ),
                        );
                      });
                    },
                    itemCount: songlist.length,
                  );
                }),
          ),
        ],
      ),
    );
  }
}

allsongbottomsheet({
  required BuildContext context,
  required String mykey,
}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Container(
        height: 550,
        child: ListView.builder(
          itemBuilder: (context, index) {
            Box<MyMusic> hiveAllSongs = getSongModelBox();
            final myAllSongs = hiveAllSongs.values.toList();

            return Container(
              color: Colormyapp.maincolor,
              child: ListTile(
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
                      id: int.parse(myAllSongs[index].id),
                    ),
                  ),
                  title: Text(
                    myAllSongs[index].title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    myAllSongs[index].artist,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      color: Colors.white,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.add_box_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      addSonginPlaylist(
                          mykey: mykey,
                          id: myAllSongs[index].id,
                          context: context);
                      Navigator.pop(context);
                    },
                  )),
            );
          },
        ),
      );
    },
  );
}
