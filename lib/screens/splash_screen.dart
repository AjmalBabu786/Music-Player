import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/DataBase/DataBase_functions.dart';
import 'package:music_player/models/myMusic.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';
import '../widgets/colorApp.dart';
import 'package:flutter/material.dart';

bool? mynotificatinon;

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
    addarecent();
    mostplayed();
  }

  Future<void> checkNotification() async {
    final SharedPreferences shareprefrnc =
        await SharedPreferences.getInstance();
    mynotificatinon = shareprefrnc.getBool('notifications');
    mynotificatinon = mynotificatinon ??= true;
  }

  final OnAudioQuery myOnAudioQuery = OnAudioQuery();
  Box<MyMusic> mymusicsBox = getSongModelBox();

  List<SongModel> fetchedsongsList = [];
  List<MyMusic> musicsList = [];

  Future fetchsong() async {
    await checkNotification();

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

    for (var song in fetchedsongsList) {
      var audio = MyMusic(
        id: song.id.toString(),
        title: song.displayNameWOExt,
        artist: song.artist!,
        url: song.uri!,
        count: 0,
      );
      mymusicsBox.put(audio.id, audio);
    }
    goToHome(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colormyapp.maincolor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
              width: size.width * 0.3,
              height: size.height * 0.2,
              child: Center(
                child: ClipRRect(
                  child: Image.asset(
                    "asset/images/new logo png.png",
                    fit: BoxFit.cover,
                  ),
                ),
              )),

          SizedBox(
            child: TextLiquidFill(
              boxHeight: size.width * 0.15,
              loadDuration: Duration(seconds: 3),
              text: 'ShazMusic',
              waveColor: Color.fromARGB(255, 253, 254, 255),
              boxBackgroundColor: Colormyapp.maincolor,
              textStyle: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
              // boxHeight: 100.0,
            ),
          )
          // const Text(
          //   'Shaz Music',
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //       color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
          // ),
        ],
      ),
    );
  }

  goToHome(context) async {
    log(mymusicsBox.length.toString());

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

  addarecent() async {
    if (!playlistbox.keys.contains('recently')) {
      await playlistbox.put('recently', []);
      log('recentlyget');
    }
  }

  mostplayed() async {
    if (!playlistbox.keys.contains('mostplay')) {
      await playlistbox.put('mostplay', []);
    }
  }
}
