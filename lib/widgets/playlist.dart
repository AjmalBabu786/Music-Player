import 'colorApp.dart';
import 'common_widgets.dart';
import 'package:flutter/material.dart';

playlistsshows(
    {required BuildContext context,
    required String bgimage,
    required String libraryText,
    required Function() librartontap}) {
  return Stack(
    children: [
      GestureDetector(
        onTap: librartontap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          height: 180,
          width: 180,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image: AssetImage(bgimage),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 15,
        left: 0,
        right: 5,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.6),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          height: 25,
          width: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                        libraryText,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 46, 62, 87),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50)),
                          ),
                          height: 300,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.only(
                                        left: 30, right: 30, top: 8, bottom: 8),
                                    backgroundColor: Colormyapp.maincolor,
                                  ),
                                  onPressed: () {
                                    createPLaylistTextField(
                                        context: context,
                                        alertTitle: 'Rename PLaylist',
                                        textLabel: 'Rename');
                                  },
                                  icon: const Icon(Icons.edit_note_rounded),
                                  label: const Text('Rename')),
                              ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(10),
                                    backgroundColor: Colormyapp.maincolor,
                                  ),
                                  onPressed: () {
                                    deletePlaylistAlertBox(context);
                                  },
                                  icon: const Icon(Icons.delete),
                                  label: const Text('Delete PLaylist'))
                            ],
                          ),
                        );
                      },
                    );
                    print('clicked');
                  },
                  child: const Icon(
                    Icons.playlist_add,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    ],
  );
}

// *************DELETE PLAYLIST ALERTBOX**********

deletePlaylistAlertBox(BuildContext context) {
  return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colormyapp.maincolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Confirm Deletion',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Do you want to delete this Playlist',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        );
      });
}
