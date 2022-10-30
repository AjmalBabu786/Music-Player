// import 'package:assets_audio_player/assets_audio_player.dart';
// import '../assetsAudio.dart';
// import '../widgets/colorApp.dart';
// import 'package:flutter/material.dart';

// import '../widgets/common_widgets.dart';

// class Recenty_played extends StatefulWidget {
//   const Recenty_played({super.key});

//   @override
//   State<Recenty_played> createState() => _Recenty_playedState();
// }

// class _Recenty_playedState extends State<Recenty_played> {
//   List<Audio> assetsongList = AssetAudioList.audioListReturn();
//   List<String> assetsongimage = AssetAudioList.imageListReturn();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colormyapp.maincolor,
//         appBar: AppBar(
//           centerTitle: true,
//           titleTextStyle:
//               const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//           backgroundColor: Colormyapp.maincolor,
//           title: Text('Recently Played'),
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemBuilder: (context, index) {
//                   return songlisttile(
//                       index: index,
//                       songname: assetsongList[index].metas.title!,
//                       artist: assetsongList[index].metas.artist!,
//                       songimage: assetsongimage[index],
//                       context: context,
//                       iconolor: Colors.white);
//                 },
//                 itemCount: assetsongimage.length,
//               ),
//             )
//           ],
//         ));
//   }
// }
