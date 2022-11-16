import 'dart:developer';
import 'dart:ffi';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/models/myMusic.dart';
import 'package:music_player/screens/nowplay.dart';
import 'package:music_player/widgets/colorApp.dart';
import 'package:music_player/widgets/miniplayer_widget.dart';
import 'package:music_player/widgets/playlist.dart';
import 'package:music_player/widgets/recent_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../DataBase/DataBase_functions.dart';

import 'package:flutter/material.dart';

import 'favoutite_widget.dart';

class ListtileWidget extends StatefulWidget {
  const ListtileWidget({
    super.key,
    required this.context,
    required this.index,
    required this.songList,
  });

  final BuildContext context;

  final List<MyMusic> songList;
  final int index;

  @override
  State<ListtileWidget> createState() => _ListtileWidgetState();
}

class _ListtileWidgetState extends State<ListtileWidget> {
  Box<List> playlistadd = getCreatePlaylistBox();
  List<Audio> samplist = [];

  TextEditingController mytextController = TextEditingController();
  @override
  void initState() {
    favouriteiconchange(id: widget.songList[widget.index].id);
    super.initState();
  }

  convertsongs() {
    log('converted');
    for (var song in widget.songList) {
      Audio music = Audio.file(song.url,
          metas: Metas(
            artist: song.artist,
            title: song.title,
            id: song.id,
          ));

      samplist.add(music);
    }
  }

  @override
  Widget build(BuildContext context) {
    convertsongs();
    final List<String> playlistKeys = playlistadd.keys.toList().cast<String>();
    return ListTile(
      onTap: () {
        miniplayersamp(
            context: context, index: widget.index, songlist: samplist);

        addRecentplay(id: widget.songList[widget.index].id);
      },
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
          id: int.parse(widget.songList[widget.index].id),
        ),
      ),
      title: Text(
        widget.songList[widget.index].title,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17.0,
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        widget.songList[widget.index].artist,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
          color: Colors.white,
        ),
      ),
      trailing: StatefulBuilder(builder: (context, setstate) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            favouriteIcons(
              icons: Icons.favorite,
              iconColor:
                  favouriteiconchange(id: widget.songList[widget.index].id),
              iconSize: 30,
              onpressed: () {
                setstate(() {
                  addfavouritesong(
                      id: widget.songList[widget.index].id, context: context);
                  favouriteiconchange(id: widget.songList[widget.index].id);
                  setState(() {});
                });
              },
            ),
            const SizedBox(
              width: 10,
            ),
            favouriteIcons(
              icons: Icons.playlist_add,
              iconColor: Colors.white,
              iconSize: 30,
              onpressed: () {
                playLIstAddModelSheet(
                    id: widget.songList[widget.index].id,
                    mytextController: mytextController,
                    context: context,
                    songName: widget.songList[widget.index].title,
                    artistName: widget.songList[widget.index].artist);
              },
            ),
          ],
        );
      }),
    );
    ;
  }
}

// ***************PlaylistAdd BottomSheet Function*************

// ***************Playlist Add Function***************
songlisttile(
    {required String songname,
    required String artist,
    required songimage,
    required BuildContext context,
    required Color iconolor,
    required List<MyMusic> favlist,
    required int index}) {
  // return ListTile(
  //   onTap: () {

  //   },
  //   leading: Container(
  //     height: 80,
  //     width: 60,
  //     child: QueryArtworkWidget(
  //       type: ArtworkType.AUDIO,
  //       nullArtworkWidget: ClipRRect(
  //           borderRadius: BorderRadius.circular(50),
  //           child: Image.asset(
  //             'asset/images/DefaultNew.webp',
  //             fit: BoxFit.fill,
  //           )),
  //       id: int.parse(songimage),
  //     ),
  //   ),
  //   title: Text(
  //     songname,
  //     overflow: TextOverflow.ellipsis,
  //     style: const TextStyle(
  //       fontWeight: FontWeight.bold,
  //       fontSize: 17.0,
  //       color: Colors.white,
  //     ),
  //   ),
  //   subtitle: Text(
  //     artist,
  //     overflow: TextOverflow.ellipsis,
  //     style: const TextStyle(
  //       fontWeight: FontWeight.bold,
  //       fontSize: 12.0,
  //       color: Colors.white,
  //     ),
  //   ),
  //   trailing: Row(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       favouriteIcons(
  //         icons: Icons.favorite,
  //         iconColor: favouriteiconchange(id: favlist[index].id),
  //         iconSize: 30,
  //         onpressed: () {
  //           addfavouritesong(id: favlist[index].id);
  //         },
  //       ),
  //       const SizedBox(
  //         width: 10,
  //       ),
  //       favouriteIcons(
  //         icons: Icons.playlist_add,
  //         iconColor: Colors.white,
  //         iconSize: 30,
  //         onpressed: () {
  //           // playLIstAddModelSheet(
  //           //     context: context,
  //           //     songName: assetsongList[index].metas.title!,
  //           //     artistName: assetsongList[index].metas.artist!,
  //           //     songImage: assetsongimage[index]);
  //         },
  //       ),
  //     ],
  //   ),
  // );
}

// ***********PLAYLIST CTRATE DIALOGBOX***********

//Mini player samp

miniplayersamp(
    {required BuildContext context,
    required int index,
    required List<Audio> songlist}) {
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.withId('0');
  showBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      backgroundColor: const Color.fromARGB(255, 150, 152, 179),
      context: context,
      builder: (context) {
        //find functoion
        Audio find(List<Audio> source, String fromPath) {
          return source.firstWhere((song) {
            return song.path == fromPath;
          });
        }

        //play function
        assetsAudioPlayer.open(Playlist(audios: songlist, startIndex: index));

        //
        return GestureDetector(
          onTap: (() {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NowPlayingScreen(
                      assetsAudioPlayer: assetsAudioPlayer,
                      index: index,
                      songList: songlist,
                    )));
          }),
          child: assetsAudioPlayer.builderCurrent(
              builder: (BuildContext context, Playing playing) {
            final myAudio = find(songlist, playing.audio.assetAudioPath);
            addRecentplay(id: myAudio.metas.id!);
            return ListTile(
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
                    id: int.parse(myAudio.metas.id!),
                    type: ArtworkType.AUDIO),
              ),
              title: Text(
                '${myAudio.metas.title}',
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                '${myAudio.metas.artist}',
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  myAudio == songlist[0]
                      ? SizedBox()
                      : GestureDetector(
                          onTap: () async {
                            await Future.delayed(Duration(milliseconds: 500));
                            assetsAudioPlayer.previous();
                          },
                          child: Icon(
                            Icons.skip_previous_outlined,
                            size: 30,
                          )),
                  const SizedBox(
                    width: 20,
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
                              size: 30,
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              assetsAudioPlayer.play();
                            },
                            child: Icon(
                              Icons.play_circle_fill_sharp,
                              size: 30,
                            ),
                          );
                  }),
                  const SizedBox(
                    width: 20,
                  ),
                  myAudio == songlist[songlist.length - 1]
                      ? SizedBox()
                      : GestureDetector(
                          onTap: () async {
                            await Future.delayed(
                                const Duration(milliseconds: 500));
                            assetsAudioPlayer.next();
                          },
                          child: const Icon(
                            Icons.skip_next_outlined,
                            size: 30,
                          )),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            );
          }),
        );
      });
}
