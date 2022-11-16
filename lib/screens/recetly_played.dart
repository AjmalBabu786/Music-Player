import 'package:hive_flutter/adapters.dart';
import 'package:music_player/DataBase/DataBase_functions.dart';
import 'package:music_player/models/myMusic.dart';
import 'package:music_player/widgets/now_play_widget.dart';

import '../widgets/colorApp.dart';
import 'package:flutter/material.dart';

import '../widgets/common_widgets.dart';

class Recenty_played extends StatefulWidget {
  const Recenty_played({super.key});

  @override
  State<Recenty_played> createState() => _Recenty_playedState();
}

class _Recenty_playedState extends State<Recenty_played> {
  Box<MyMusic> allsongs = getSongModelBox();
  Box<List> playlist = getPlaylistBox();

  @override
  Widget build(BuildContext context) {
    List<MyMusic> recentlysonglist =
        playlist.get('recently')!.toList().cast<MyMusic>();
    return Scaffold(
        backgroundColor: Colormyapp.maincolor,
        appBar: AppBar(
          centerTitle: true,
          titleTextStyle:
              const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          backgroundColor: Colormyapp.maincolor,
          title: Text('Recently Played'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListtileWidget(
                    context: context,
                    index: index,
                    songList: recentlysonglist,
                  );
                },
                itemCount: recentlysonglist.length,
              ),
            )
          ],
        ));
  }
}
