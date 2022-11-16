import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/DataBase/DataBase_functions.dart';
import 'package:music_player/models/myMusic.dart';

import 'package:flutter/material.dart';
import 'package:music_player/widgets/common_widgets.dart';

import '../widgets/colorApp.dart';

class favourite_screen extends StatefulWidget {
  const favourite_screen({super.key});

  @override
  State<favourite_screen> createState() => _favourite_screenState();
}

class _favourite_screenState extends State<favourite_screen> {
  AssetsAudioPlayer myassetaudio = AssetsAudioPlayer.withId('0');

  final Box<List> playlistsong = getPlaylistBox();

  @override
  void initState() {
    super.initState();
  }

  bool textfieldvisiblity = false;
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      backgroundColor: Colormyapp.maincolor,
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle:
            const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        backgroundColor: Colormyapp.maincolor,
        title: const Text(
          'favourite',
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: playlistsong.listenable(),
                builder: (BuildContext context, Box<List<dynamic>> value,
                    Widget? _) {
                  final List<MyMusic> favouritelist =
                      value.get('favourite')!.toList().cast<MyMusic>();
                  return (favouritelist.isEmpty)
                      ? const Center(
                          child: Text(
                            'The list is empty',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return ListtileWidget(
                              context: context,
                              index: index,
                              songList: favouritelist,
                            );
                          },
                          itemCount: favouritelist.length,
                        );
                }),
          ),
        ],
      ),
    );
  }
}
