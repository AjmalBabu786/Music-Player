import 'package:flutter/material.dart';

homeScreenhomeScreenIcons(
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

favouriteIcons(
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
