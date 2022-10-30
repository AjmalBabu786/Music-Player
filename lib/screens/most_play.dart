// import 'package:assets_audio_player/assets_audio_player.dart';
// import '../assetsAudio.dart';
// import '../widgets/colorApp.dart';
// import '../widgets/common_widgets.dart';
// import 'package:flutter/material.dart';

// class Most_played extends StatefulWidget {
//   const Most_played({super.key});

//   @override
//   State<Most_played> createState() => _Most_playedState();
// }

// class _Most_playedState extends State<Most_played> {
//   List<Audio> assetsongList = AssetAudioList.audioListReturn();
//   List<String> assetsongimage = AssetAudioList.imageListReturn();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colormyapp.maincolor,
//       appBar: AppBar(
//         centerTitle: true,
//         titleTextStyle:
//             const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//         backgroundColor: Colormyapp.maincolor,
//         title: Text('MostPlayed'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemBuilder: (context, index) {
//                 return songlisttile(
//                   index: index,
//                   artist: assetsongList[index].metas.artist!,
//                   songname: assetsongList[index].metas.title!,
//                   songimage: assetsongimage[index],
//                   context: context,
//                   iconolor: Colors.white,
//                 );
//               },
//               itemCount: assetsongimage.length - 2,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
