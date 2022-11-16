import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/DataBase/DataBase_functions.dart';
import 'package:music_player/models/myMusic.dart';
import 'package:music_player/screens/favourite.dart';
import 'package:music_player/screens/most_play.dart';

import 'package:music_player/screens/recetly_played.dart';
import 'package:music_player/screens/searchscreen.dart';
import 'package:music_player/widgets/common_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/colorApp.dart';
import '../widgets/home_widgets.dart';

import 'package:flutter/material.dart';

import 'playlist_screen.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class home_screem extends StatefulWidget {
  const home_screem({super.key});

  @override
  State<home_screem> createState() => _home_screemState();
}

class _home_screemState extends State<home_screem> {
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  TextEditingController _textEditingController = TextEditingController();
  Box<MyMusic> hiveAllSongs = getSongModelBox();
  List<MyMusic> myAllSongs = [];
  tolist() async {
    myAllSongs = hiveAllSongs.values.toList();
  }

  @override
  void initState() {
    super.initState();
    tolist();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: drawersettings(context),
      backgroundColor: Colormyapp.maincolor,
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle:
            const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        backgroundColor: Colormyapp.maincolor,
        title: const Text(
          'Home',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const search_screen(),
                ));
              },
              icon: const Icon(
                Icons.search,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 20),
                    child: Text(
                      'Library',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Container(
                height: 150,
                // **************************************************************
                child: Row(
                  children: [
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          listviewontainer(
                            context: context,
                            libraryText: 'Playlist',
                            bgimage: 'asset/images/most played.jpg',
                            librartontap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Playlist_screen(),
                              ));
                            },
                          ),
                          listviewontainer(
                            context: context,
                            libraryText: 'Favourite',
                            bgimage: 'asset/images/new one 1.jpg',
                            librartontap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const favourite_screen()));
                            },
                          ),
                          listviewontainer(
                            context: context,
                            libraryText: 'Most Played',
                            bgimage: 'asset/images/favorite.jpg',
                            librartontap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Most_played(),
                              ));
                            },
                          ),
                          listviewontainer(
                            context: context,
                            libraryText: 'Recently ',
                            bgimage: 'asset/images/zayn-malik.jpg',
                            librartontap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Recenty_played(),
                              ));
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Row(
              children: const [
                Text(
                  'All Songs',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          ValueListenableBuilder(
              valueListenable: hiveAllSongs.listenable(),
              builder: (BuildContext context, Box<MyMusic> value, Widget? _) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListtileWidget(
                      context: context,
                      index: index,
                      songList: myAllSongs,
                    );
                  },
                  itemCount: myAllSongs.length,
                );
              }),
        ],
      ),
    );
  }
}
