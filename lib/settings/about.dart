import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

aboutMeFunction({
  required BuildContext context,
}) {
  Size size = MediaQuery.of(context).size;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        title: Text(
          'About Me',
          textAlign: TextAlign.center,
        ),
        content: Text(
          'This App is Desingned and Developed by Ajmal Shaz',
          textAlign: TextAlign.center,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: GestureDetector(
                  onTap: () {
                    instagram(
                        url:
                            'https://instagram.com/_ajmal__shaz?igshid=YmMyMTA2M2Y=');
                  },
                  child: Image.asset(
                    'asset/images/instagram.icon.webp',
                    height: size.height * 0.07,
                    width: size.width * 0.07,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  instagram(
                      url:
                          'https://www.facebook.com/profile.php?id=100006340576205');
                },
                child: Image.asset(
                  'asset/images/facebook icon.png',
                  height: size.height * 0.07,
                  width: size.width * 0.07,
                ),
              ),
              GestureDetector(
                onTap: () {
                  instagram(
                      url: 'https://www.linkedin.com/in/ajmal-shaz-b0645b245/');
                },
                child: Image.asset(
                  'asset/images/linkedin.png',
                  height: size.height * 0.07,
                  width: size.width * 0.07,
                ),
              ),
            ],
          )
        ],
      );
    },
  );
}

Future<void> instagram({required String url}) async {
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(
    _url,
  )) {
    throw 'Could not launch $_url';
  }
}



// Future<void> _launchUrl() async {
//   if (!await launchUrl(
//     _url,
//   )) {
//     throw 'Could not launch $_url';
//   }
// }
