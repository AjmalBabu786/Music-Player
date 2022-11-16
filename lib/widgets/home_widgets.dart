import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/screens/splash_screen.dart';
import 'package:music_player/settings/about.dart';
import 'package:music_player/settings/privacyPolicy.dart';
import 'package:music_player/settings/termsAndConditions.dart';
import 'package:music_player/widgets/colorApp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class settingsNotification extends StatefulWidget {
  settingsNotification({
    super.key,
    required this.text,
    required this.firstIcon,
    this.lastIcon,
  });
  String text;
  IconData firstIcon;
  IconData? lastIcon;

  @override
  State<settingsNotification> createState() => _settingsNotificationState();
}

class _settingsNotificationState extends State<settingsNotification> {
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

  Future setnotification({required bool myvalue}) async {
    final SharedPreferences shareprefrnc =
        await SharedPreferences.getInstance();
    await shareprefrnc.setBool('notifications', myvalue);
    setState(() {
      mynotificatinon = myvalue;
      mynotificatinon!
          ? audioPlayer.showNotification = true
          : audioPlayer.showNotification = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        widget.firstIcon,
        color: Colors.white,
      ),
      title: Text(
        widget.text,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
      trailing: widget.lastIcon != null
          ? Icon(
              widget.lastIcon,
              color: Colors.white,
            )
          : Switch(
              inactiveTrackColor: Colors.blue,
              activeTrackColor: Colors.red,
              value: mynotificatinon!,
              onChanged: (value) async {
                await setnotification(myvalue: value);
              },
            ),
    );
  }
}

listviewontainer(
    {required String bgimage,
    required String libraryText,
    required Function() librartontap,
    required BuildContext context}) {
  Size size = MediaQuery.of(context).size;
  return Stack(
    children: [
      GestureDetector(
        onTap: librartontap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          height: size.height * 0.3,
          width: size.width * 0.4,
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
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            child: Text(
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              libraryText,
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.6),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 6),
            height: size.height * 0.04,
            width: 60,
          ))
    ],
  );
}

homeScreenIcons(
    {required IconData icons,
    required double iconSize,
    required Color iconColor,
    required Function() onpressed}) {
  return IconButton(
    onPressed: onpressed,
    icon: Icon(
      icons,
      size: iconSize,
    ),
    color: (iconColor),
  );
}

Widget drawersettings(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Drawer(
    width: size.width * 0.8,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(bottomRight: Radius.circular(300)),
    ),
    backgroundColor: Colormyapp.maincolor,
    child: Container(
      child: Column(
        children: [
          Image.asset(
            'asset/images/Microphone_and_headset_logo_-_Made_with_PosterMyWall-removebg-preview.png',
            width: size.width * 0.5,
          ),
          GestureDetector(
            onTap: () {
              aboutMeFunction(context: context);
            },
            child: settingsNotification(
              text: 'About Me',
              firstIcon: Icons.person,
              lastIcon: Icons.arrow_forward_ios_rounded,
            ),
          ),
          settingsNotification(
              text: 'Notification', firstIcon: Icons.notifications_active),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PrivacyAndPolicy(),
              ));
            },
            child: settingsNotification(
              text: 'Privacy&Policy',
              firstIcon: Icons.policy_rounded,
              lastIcon: Icons.arrow_forward_ios_rounded,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TermsAndCondition(),
              ));
            },
            child: settingsNotification(
              text: 'Terms&Conditions',
              firstIcon:
                  Icons.signal_cellular_connected_no_internet_0_bar_outlined,
              lastIcon: Icons.arrow_forward_ios_rounded,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LicensePage(
                    applicationIcon: Image.asset(
                      'asset/images/new logo png.png',
                      height: size.height * 0.5,
                      width: size.width * 0.8,
                    ),
                    applicationVersion: '1.0.0',
                    applicationLegalese: 'AjmalShaz'),
              ));
            },
            child: settingsNotification(
              text: 'License',
              firstIcon: Icons.warning,
              lastIcon: Icons.arrow_forward_ios_rounded,
            ),
          ),
          SizedBox(
            height: size.height * 0.06,
          ),
          const Text(
            'Version',
            style: TextStyle(color: Color.fromARGB(255, 122, 107, 107)),
          ),
          const Text(
            '1.0.0',
            style: TextStyle(color: Color.fromARGB(255, 122, 107, 107)),
          ),
        ],
      ),
    ),
  );
}
