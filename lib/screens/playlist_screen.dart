// import 'list_one.dart';
// import '../widgets/colorApp.dart';
// import '../widgets/common_widgets.dart';
// import 'package:flutter/material.dart';

// import '../widgets/playlist.dart';

// class Playlist_screen extends StatefulWidget {
//   const Playlist_screen({super.key});

//   @override
//   State<Playlist_screen> createState() => _PlaylistState();
// }

// class _PlaylistState extends State<Playlist_screen> {
//   bool textfieldvisiblity = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colormyapp.maincolor,
//       appBar: AppBar(
//         backgroundColor: Colormyapp.maincolor,
//         centerTitle: true,
//         titleTextStyle:
//             const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//         title: const Text(
//           'PLaylist',
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               createPLaylistTextField(
//                   context: context,
//                   alertTitle: 'Create Playlist',
//                   textLabel: 'entet playlist name');
//             },
//             icon: Icon(Icons.add_outlined),
//             iconSize: 30,
//           ),
//         ],
//         // leading: IconButton(
//         //     onPressed: () {}, icon: Icon(Icons.arrow_back_ios_rounded),
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 15,
//           ),
//           // TextField(
//           //     decoration: InputDecoration(
//           //         label: Text('search your playlist',
//           //             style:
//           //                 TextStyle(color: Color.fromARGB(255, 224, 207, 207))),
//           //         hintText: 'search your playlist',
//           //         hintStyle: TextStyle(color: Color.fromARGB(255, 74, 68, 68)),
//           //         border: OutlineInputBorder(
//           //             borderRadius: BorderRadius.circular(50)))),
//           SizedBox(
//             height: 15,
//           ),
//           Expanded(
//             child: GridView.count(
//               mainAxisSpacing: 2,
//               crossAxisCount: 2,
//               children: [
//                 playlistsshows(
//                   context: context,
//                   bgimage: 'asset/images/drive.jpg',
//                   libraryText: 'Drive',
//                   librartontap: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => Drive(),
//                     ));
//                   },
//                 ),
//                 playlistsshows(
//                   context: context,
//                   bgimage: 'asset/images/workout.webp',
//                   libraryText: 'Workout',
//                   librartontap: () {},
//                 ),
//                 playlistsshows(
//                   context: context,
//                   bgimage: 'asset/images/dj.jpeg',
//                   libraryText: 'DJ',
//                   librartontap: () {},
//                 ),
//                 playlistsshows(
//                   context: context,
//                   bgimage: 'asset/images/romantic.webp',
//                   libraryText: 'romantic',
//                   librartontap: () {},
//                 ),
//                 playlistsshows(
//                   context: context,
//                   bgimage: 'asset/images/billi eilish.jpg',
//                   libraryText: 'Bilie eilish',
//                   librartontap: () {},
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
