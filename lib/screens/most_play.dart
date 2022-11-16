import 'package:hive_flutter/adapters.dart';
import 'package:music_player/DataBase/DataBase_functions.dart';
import 'package:music_player/models/myMusic.dart';

import '../widgets/colorApp.dart';
import '../widgets/common_widgets.dart';
import 'package:flutter/material.dart';

class Most_played extends StatefulWidget {
  const Most_played({super.key});

  @override
  State<Most_played> createState() => _Most_playedState();
}

class _Most_playedState extends State<Most_played> {
  Box<MyMusic> allsongs = getSongModelBox();
  Box<List> playlist = getPlaylistBox();
  List<MyMusic>? mostplaysonglist;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colormyapp.maincolor,
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle:
            const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        backgroundColor: Colormyapp.maincolor,
        title: Text('MostPlayed'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: playlist.listenable(),
                builder:
                    (BuildContext context, Box<List<dynamic>> value, Widget_) {
                  mostplaysonglist =
                      playlist.get('mostplay')!.toList().cast<MyMusic>();
                  return mostplaysonglist!.isEmpty
                      ? Center(
                          child: Text('No Songs',
                              style: TextStyle(color: Colors.grey)))
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return ListtileWidget(
                              context: context,
                              index: index,
                              songList: mostplaysonglist!,
                            );
                          },
                          itemCount: mostplaysonglist!.length,
                        );
                }),
          ),
        ],
      ),
    );
  }
}
