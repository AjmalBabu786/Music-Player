import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/DataBase/DataBase_functions.dart';
import 'package:music_player/models/myMusic.dart';
import 'package:music_player/widgets/colorApp.dart';
import 'package:music_player/widgets/common_widgets.dart';
import 'package:music_player/widgets/home_widgets.dart';
import 'package:music_player/widgets/miniplayer_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

class search_screen extends StatefulWidget {
  const search_screen({super.key});

  @override
  State<search_screen> createState() => _search_screenState();
}

class _search_screenState extends State<search_screen> {
  TextEditingController mysearchcontroller = TextEditingController();
  Box<MyMusic> allsonglist = getSongModelBox();
  Box<List> playlist = getPlaylistBox();

  List<MyMusic>? myallsonglist;
  List<MyMusic>? mysearchlist;

  searchSongfunction({required String value}) {
    setState(() {
      mysearchlist = myallsonglist!
          .where((element) =>
              element.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    myallsonglist = allsonglist.values.toList();
    mysearchlist = List.from(myallsonglist!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colormyapp.maincolor,
      appBar: AppBar(
        backgroundColor: Colormyapp.maincolor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: mysearchcontroller,
              onChanged: (value) {
                searchSongfunction(value: value);
                log('search worked');
              },
              style: TextStyle(color: Colormyapp.white),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 71, 76, 74)),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  hintText: 'search your song',
                  hintStyle: TextStyle(color: Colormyapp.grey)),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: playlist.listenable(),
            builder: (BuildContext context, Box<List> value, Widget? child) {
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        miniplayersheet(
                            context: context,
                            index: index,
                            songs: mysearchlist!);
                      },
                      leading: SizedBox(
                        height: 80,
                        width: 60,
                        child: QueryArtworkWidget(
                            nullArtworkWidget: ClipRRect(
                              child:
                                  Image.asset('asset/images/Defaultimages.jpg'),
                            ),
                            id: int.parse(mysearchlist![index].id),
                            type: ArtworkType.AUDIO),
                      ),
                      title: Text(
                        mysearchlist![index].title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        mysearchlist![index].artist,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          homeScreenIcons(
                            icons: Icons.favorite,
                            iconColor: favouriteiconchange(
                                id: myallsonglist![index].id),
                            iconSize: 30,
                            onpressed: () {
                              addfavouritesong(id: myallsonglist![index].id);
                              log('added');
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          homeScreenIcons(
                            icons: Icons.playlist_add,
                            iconColor: Colors.white,
                            iconSize: 30,
                            onpressed: () {
                              // playLIstAddModelSheet(
                              //     context: context,
                              //     songName: assetsongList[index].metas.title!,
                              //     artistName: assetsongList[index].metas.artist!,
                              //     songImage: assetsongimage[index]);
                              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ,))
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: mysearchlist!.length,
                ),
              );
            },
          )
        ],
      )),
    );
  }
}
