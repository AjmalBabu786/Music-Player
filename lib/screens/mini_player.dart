// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class Miniplayer extends StatefulWidget {
//   Miniplayer({super.key});

//   @override
//   State<Miniplayer> createState() => _MiniplayerState();
// }

// class _MiniplayerState extends State<Miniplayer> {
//   AssetsAudioPlayer myassetaudio = AssetsAudioPlayer();

//   @override
//   void initState() {
//     myassetaudio.open(
//       Audio("asset/images/BoomiEnna.mp3"),
//       autoStart: true,
//     );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Image.asset(
//         'asset/images/main-qimg-bfc848e9334efd01043f057d3fcdcae6-lq.jpeg',
//       ),
//       title: Text('Jodi_Nilave'),
//       subtitle: Text('Anirudh Ravichander'),
//       trailing: Row(
//         children: [
//           Icon(Icons.skip_previous),
//           Icon(Icons.pause_circle),
//           Icon(Icons.skip_next_sharp),
//         ],
//       ),
//     );
//   }
// }
