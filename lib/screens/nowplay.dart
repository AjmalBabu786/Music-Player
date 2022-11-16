import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/DataBase/DataBase_functions.dart';
import 'package:music_player/lyrics/lyricsfunction.dart';
import 'package:music_player/models/myMusic.dart';

import 'package:music_player/widgets/colorApp.dart';
import 'package:music_player/widgets/favoutite_widget.dart';
import 'package:music_player/widgets/now_play_widget.dart';
import 'package:music_player/widgets/playlist.dart';
import 'package:music_player/widgets/recent_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlayingScreen extends StatefulWidget {
  const NowPlayingScreen(
      {super.key,
      required this.songList,
      required this.index,
      required this.assetsAudioPlayer});
  final List<Audio> songList;
  final int index;
  final AssetsAudioPlayer assetsAudioPlayer;

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  Box<MyMusic> hiveAllSongs = getSongModelBox();
  bool shuffles = false;
  bool loops = false;

  final TextEditingController mytextController = TextEditingController();
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.withId('0');

//find function
  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((song) {
      return song.path == fromPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colormyapp.maincolor,
      appBar: AppBar(
        backgroundColor: Colormyapp.maincolor,
        centerTitle: true,
        title: const Text('NOW PLAY'),
        titleTextStyle:
            const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        actions: [
          assetsAudioPlayer.builderCurrent(
            builder: (BuildContext context, Playing playing) {
              final myAudio =
                  find(widget.songList, playing.audio.assetAudioPath);
              return IconButton(
                onPressed: () async {
                  final songLyrics = await getSongLyrics(
                      title: myAudio.metas.title!,
                      artist: myAudio.metas.artist!);
                  log(songLyrics.toString());
                  String lyrics = songLyrics.lyrics ?? 'No Lyrics Found Sorry';
                  LyricBottomSheet(context: context, lyrics: lyrics);
                },
                icon: Icon(Icons.music_note_outlined),
              );
            },
            // IconButton(
            //   onPressed: () {},
            //   icon: const Icon(Icons.music_note_rounded),
            // ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: widget.assetsAudioPlayer.builderCurrent(
            builder: (BuildContext context, Playing playing) {
          final myAuido = find(widget.songList, playing.audio.assetAudioPath);
          return Column(
            children: [
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
                      id: int.parse(myAuido.metas.id!),
                      artworkBorder: BorderRadius.circular(85),
                      type: ArtworkType.AUDIO),
                ),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * 0.5,
                        child: Text(
                          '${myAuido.metas.title}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 25, color: Colors.white),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          addfavouritesong(
                              context: context,
                              id: myAuido.metas.id.toString());

                          // favouriteiconchange(id: myAuido.metas.id!);
                          log('worked');
                        },
                        child: ValueListenableBuilder(
                            valueListenable: hiveAllSongs.listenable(),
                            builder: (BuildContext context, Box<MyMusic> value,
                                Widget_) {
                              return Icon(
                                Icons.favorite,
                                color:
                                    favouriteiconchange(id: myAuido.metas.id!),
                                size: 40,
                              );
                            }),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * 0.5,
                        child: Text(
                          '${myAuido.metas.artist}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          playLIstAddModelSheet(
                              context: context,
                              songName: myAuido.metas.title!,
                              artistName: myAuido.metas.artist!,
                              mytextController: mytextController,
                              id: myAuido.metas.id!);
                        },
                        child: Icon(
                          Icons.playlist_add,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              assetsAudioPlayer.builderRealtimePlayingInfos(
                  builder: (context, playing) {
                return ProgressBar(
                  onSeek: (value) {
                    assetsAudioPlayer.seek(value);
                  },
                  progress: playing.currentPosition,
                  total: playing.duration,
                  progressBarColor: Colors.white,
                  baseBarColor: Colors.grey,
                  thumbColor: Colors.white,
                  timeLabelTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                );
              }),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          if (loops == false) {
                            loops = true;
                            assetsAudioPlayer.toggleLoop();
                          } else if (loops == true) {
                            loops = false;
                            assetsAudioPlayer.toggleLoop();
                          }
                        });
                      },
                      child: loops
                          ? Icon(
                              Icons.repeat_one_on_outlined,
                              color: Colormyapp.red,
                              size: 30,
                            )
                          : Icon(
                              Icons.repeat_one_on_outlined,
                              color: Colormyapp.white,
                              size: 30,
                            )),
                  GestureDetector(
                    onTap: () async {
                      await Future.delayed(Duration(milliseconds: 500));
                      widget.assetsAudioPlayer.previous();
                    },
                    child: Icon(
                      Icons.skip_previous,
                      color: Colormyapp.white,
                      size: 45,
                    ),
                  ),
                  assetsAudioPlayer.builderIsPlaying(
                      builder: (context, isPlaying) {
                    return isPlaying
                        ? GestureDetector(
                            onTap: () {
                              assetsAudioPlayer.pause();
                            },
                            child: Icon(
                              Icons.pause_circle_filled_sharp,
                              color: Colormyapp.white,
                              size: 60,
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              assetsAudioPlayer.play();
                            },
                            child: Icon(
                              Icons.play_circle_fill_sharp,
                              color: Colormyapp.white,
                              size: 60,
                            ),
                          );
                  }),
                  GestureDetector(
                    onTap: () async {
                      await Future.delayed(Duration(milliseconds: 500));
                      widget.assetsAudioPlayer.next();
                    },
                    child: Icon(
                      Icons.skip_next_sharp,
                      color: Colormyapp.white,
                      size: 45,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        if (shuffles == false) {
                          shuffles = true;
                          assetsAudioPlayer.toggleShuffle();
                        } else if (shuffles == true) {
                          shuffles = false;
                          assetsAudioPlayer.toggleShuffle();
                        }
                      },
                      child: assetsAudioPlayer.isShuffling.value
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  assetsAudioPlayer.toggleShuffle();
                                });
                              },
                              child: Icon(
                                Icons.shuffle_on_outlined,
                                color: Colormyapp.red,
                                size: 30,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  assetsAudioPlayer.toggleShuffle();
                                });
                              },
                              child: Icon(
                                Icons.shuffle_on_outlined,
                                color: Colormyapp.white,
                                size: 30,
                              ),
                            )),
                ],
              )
            ],
          );
        }),
      ),
    );
  }
}
