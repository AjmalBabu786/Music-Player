// import 'package:assets_audio_player/assets_audio_player.dart';
// import '../assetsAudio.dart';
// import '../widgets/colorApp.dart';
// import '../widgets/common_widgets.dart';
// import 'package:flutter/material.dart';

// class Drive extends StatefulWidget {
//   const Drive({super.key});

//   @override
//   State<Drive> createState() => _DriveState();
// }

// class _DriveState extends State<Drive> {
//   List<Audio> assetsongList = AssetAudioList.audioListReturn();
//   List<String> assetsongimage = AssetAudioList.imageListReturn();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colormyapp.maincolor,
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colormyapp.maincolor,
//         title: const Text('Drive'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemBuilder: (context, index) {
//                 return songlisttile(
//                     songname: assetsongList[index].metas.title!,
//                     artist: assetsongList[index].metas.artist!,
//                     songimage: assetsongimage[index],
//                     context: context,
//                     iconolor: Colormyapp.white,
//                     index: index);
//               },
//               itemCount: assetsongimage.length,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
