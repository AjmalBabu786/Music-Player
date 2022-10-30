import 'dart:developer';

import 'package:hive_flutter/adapters.dart';
import 'package:music_player/DataBase/DataBase_functions.dart';
import 'package:music_player/models/myMusic.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

import 'home_screen.dart';
import '../widgets/colorApp.dart';
import 'package:flutter/material.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  Box<List> playlistbox = getPlaylistBox();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchsong();
    favsongAdd();
  }

  final OnAudioQuery myOnAudioQuery = OnAudioQuery();
  Box<MyMusic> mymusicsBox = getSongModelBox();

  List<SongModel> fetchedsongsList = [];
  List<MyMusic> musicsList = [];

  Future fetchsong() async {
    log('haayyyy   1');
    await Permission.storage.request();
    fetchedsongsList = await myOnAudioQuery.querySongs(
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        sortType: SongSortType.TITLE,
        uriType: UriType.EXTERNAL);
    addtohivebox();
  }

  addtohivebox() async {
    log(fetchedsongsList.length.toString());
    log('haayyyy');
    for (var song in fetchedsongsList) {
      var audio = MyMusic(
        id: song.id.toString(),
        title: song.displayNameWOExt,
        artist: song.artist!,
        url: song.uri!,
      );
      mymusicsBox.put(audio.id, audio);
    }
    goToHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colormyapp.maincolor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              width: 100,
              height: 100,
              child: Center(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomRight: Radius.circular(100)),
                  child: Image.asset(
                    "asset/images/logo.webp",
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Music Player',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ],
      ),
    );
  }

  goToHome(context) async {
    log(mymusicsBox.length.toString());

    log('haayyyy   to home');
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const home_screem(),
    ));
  }

  favsongAdd() async {
    if (!playlistbox.keys.contains('favourite')) {
      await playlistbox.put('favourite', []);
      log('favourite get');
    }
  }
}
