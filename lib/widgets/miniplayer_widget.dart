import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:music_player/models/myMusic.dart';

import 'package:music_player/screens/nowplay.dart';
import 'package:music_player/widgets/recent_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:flutter/material.dart';

class Miniplayer extends StatefulWidget {
  Miniplayer({
    Key? key,
    required this.index,
    required this.songlists,
  }) : super(key: key);
  final int index;
  final List<MyMusic> songlists;
  final List<Audio> mysongs = [];

  @override
  State<Miniplayer> createState() => _MiniplayerState();
}

class _MiniplayerState extends State<Miniplayer> {
  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((song) {
      return song.path == fromPath;
    });
  }

  AssetsAudioPlayer myAudioPlayer = AssetsAudioPlayer.withId('0');
  convertsongs() {
    log('converted');
    for (var song in widget.songlists) {
      Audio music = Audio.file(song.url,
          metas: Metas(
            artist: song.artist,
            title: song.title,
            id: song.id,
          ));

      widget.mysongs.add(music);
    }
    log(widget.mysongs.length.toString());
  }

  songlistplay() {
    myAudioPlayer.open(
        loopMode: LoopMode.playlist,
        autoStart: true,
        Playlist(audios: widget.mysongs, startIndex: widget.index));
  }

  List<Audio> assetsongList = [];

  @override
  void initState() {
    convertsongs();
    print(assetsongList);
    songlistplay();

    super.initState();
    // openAudio();
  }

  @override
  Widget build(BuildContext context) {
    return myAudioPlayer.builderCurrent(
        builder: (BuildContext context, Playing playing) {
      final myAudio = find(widget.mysongs, playing.audio.assetAudioPath);
      addRecentplay(id: myAudio.metas.id!);
      return ListTile(
          onTap: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => Now_playing(
            //       // index: widget.index,
            //       // songlists: widget.mysongs,
            //       ),
            // ));

            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return Text('data');
                // return const NowPlayingScreen();
              },
            ));
          },
          leading: Container(
            height: 80,
            width: 60,
            child: QueryArtworkWidget(
                nullArtworkWidget: ClipOval(
                  child: Image.asset(
                    'asset/images/DefaultNew.webp',
                    fit: BoxFit.fill,
                  ),
                ),
                id: int.parse(widget.songlists[widget.index].id),
                type: ArtworkType.AUDIO),
          ),
          title: Text(
            myAudioPlayer.getCurrentAudioTitle,
            // widget.mysongs[widget.index].metas.title!,

            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(myAudioPlayer.getCurrentAudioArtist,
              overflow: TextOverflow.ellipsis),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {
                    myAudioPlayer.previous();
                  },
                  icon: const Icon(Icons.skip_previous)),
              myAudioPlayer.builderRealtimePlayingInfos(
                  builder: (context, realtimePlayingInfos) {
                return IconButton(
                    onPressed: () {
                      myAudioPlayer.playOrPause();
                    },
                    icon: Icon(
                      realtimePlayingInfos.isPlaying
                          ? Icons.pause_circle
                          : Icons.play_circle,
                    ));
              }),
              IconButton(
                  onPressed: () {
                    myAudioPlayer.next();
                  },
                  icon: const Icon(Icons.skip_next_sharp)),
            ],
          ));
    });
  }
}

miniplayersheet(
    {required List<MyMusic> songs,
    required int index,
    required BuildContext context}) {
  return showBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      backgroundColor: const Color.fromARGB(255, 150, 152, 179),
      context: context,
      builder: (ctx) {
        return Miniplayer(
          index: index,
          songlists: songs,
        );
      });
}
