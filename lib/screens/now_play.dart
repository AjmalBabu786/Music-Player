import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/models/myMusic.dart';
import 'package:music_player/widgets/common_widgets.dart';
import 'package:music_player/widgets/home_widgets.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../DataBase/DataBase_functions.dart';
import '../assetsAudio.dart';
import '../widgets/colorApp.dart';
import '../widgets/now_play_widget.dart';
import 'package:flutter/material.dart';

class Nowplay extends StatefulWidget {
  Nowplay({
    required this.index,
    required this.songlists,
  });
  final int index;
  final List<Audio> songlists;

  State<Nowplay> createState() => _NowplayState();
}

class _NowplayState extends State<Nowplay> {
  Box<MyMusic> allsonglist = getSongModelBox();

  Box<List> playlist = getPlaylistBox();

  AssetsAudioPlayer myassetaudio = AssetsAudioPlayer.withId('0');
  // List songList = AssetAudioList.audioListReturn();
  // List<Audio> Mysongs = AssetAudioList.audioListReturn();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colormyapp.maincolor,
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle:
            const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        backgroundColor: Colormyapp.maincolor,
        title: const Text(
          'Now Playing',
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              Container(
                height: size.height * 0.4,
                width: size.width * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(180),
                ),
                child: ClipOval(
                  child: QueryArtworkWidget(
                      // artworkWidth: 190,
                      // artworkHeight: 190,
                      nullArtworkWidget: Image.asset(
                        'asset/images/DefaultNew.webp',
                        fit: BoxFit.cover,
                      ),
                      id: int.parse(
                        widget.songlists[widget.index].metas.id!,
                      ),
                      artworkBorder: BorderRadius.circular(85),
                      type: ArtworkType.AUDIO),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  newPlaySong(
                    context: context,
                    fontsize: 25,
                    iconolor: favouriteiconchange(
                        id: widget.songlists[widget.index].metas.id.toString()),
                    SongName:
                        widget.songlists[widget.index].metas.title.toString(),
                    FavAndPlaylist: (Icons.favorite),
                    iconSize: 35,
                    favOnpress: () {
                      addfavouritesong(
                          id: widget.songlists[widget.index].metas.id
                              .toString());
                      log('worked');
                    },
                  ),
                  // SizedBox(
                  //   height: 2,
                  // ),
                  newPlaySong(
                      context: context,
                      SongName: widget.songlists[widget.index].metas.artist
                          .toString(),
                      FavAndPlaylist: (Icons.playlist_add),
                      iconSize: 35,
                      favOnpress: () {},
                      iconolor: Colors.white,
                      fontsize: 15)
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const ProgressBar(
                  progress: Duration(seconds: 55),
                  total: Duration(minutes: 4),
                  progressBarColor: Colors.white,
                  baseBarColor: Colors.grey,
                  thumbColor: Colors.white,
                  timeLabelTextStyle: TextStyle(color: Colors.white)),
              SizedBox(
                height: 10,
              ),
              myassetaudio.builderRealtimePlayingInfos(
                builder: (context, realtimePlayingInfos) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      noePlayBUttons(
                        icons: Icons.repeat_one,
                        iconSize: 40,
                        onpressed: () {},
                      ),
                      noePlayBUttons(
                        icons: Icons.skip_previous,
                        iconSize: 40,
                        onpressed: () {
                          myassetaudio.previous();
                        },
                      ),
                      Container(
                        // color: Colors.black,
                        height: size.height * 0.1,
                        width: size.width * 0.2,
                        child: noePlayBUttons(
                          icons: realtimePlayingInfos.isPlaying
                              ? Icons.pause_circle
                              : Icons.play_circle,
                          iconSize: 70,
                          onpressed: () {
                            myassetaudio.playOrPause();
                          },
                        ),
                      ),
                      noePlayBUttons(
                        icons: Icons.skip_next_sharp,
                        iconSize: 40,
                        onpressed: () {
                          myassetaudio.next();
                        },
                      ),
                      noePlayBUttons(
                        icons: Icons.shuffle,
                        iconSize: 40,
                        onpressed: () {},
                      ),
                    ],
                  );
                },
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     noePlayBUttons(
                //       icons: Icons.repeat_one,
                //       iconSize: 40,
                //       onpressed: () {},
                //     ),
                //     noePlayBUttons(
                //       icons: Icons.skip_previous,
                //       iconSize: 40,
                //       onpressed: () {
                //         myassetaudio.previous();
                //       },
                //     ),
                //     Container(
                //       // color: Colors.black,
                //       height: size.height * 0.1,
                //       width: size.width * 0.2,
                //       child: noePlayBUttons(
                //         icons: Icons.pause_circle,
                //         iconSize: 70,
                //         onpressed: () {
                //           myassetaudio.playOrPause();
                //         },
                //       ),
                //     ),
                //     noePlayBUttons(
                //       icons: Icons.skip_next_sharp,
                //       iconSize: 40,
                //       onpressed: () {
                //         myassetaudio.next();
                //       },
                //     ),
                //     noePlayBUttons(
                //       icons: Icons.shuffle,
                //       iconSize: 40,
                //       onpressed: () {},
                //     ),
                //   ],
                // ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
