import 'package:flutter/material.dart';

bool isFemale = false;
int size = 1;
int currentSpeakSpead = 1;

Color maincolor = const Color(0xff724666);
Color purcolor = const Color(0xff724666);
Color greyColor = const Color(0xff808484);
Color pinkColor = const Color(0xffA73660);
Color yellowColor = const Color(0xffdad532);
Color greenColor = const Color(0xff57c497);

bool isoffline = false;
int notevoiceindex = 0;
List<String> noteVoices = [
  "assets/note1.wav",
  "assets/notification2.wav",
  "assets/notification3.wav"
];
List<Color> colorList = [
  const Color(0xff339870),
  const Color(0xff52681a),
  const Color.fromARGB(255, 156, 141, 190),
  const Color(0xff2291C9),
  const Color(0xff969696),
  const Color(0xffCB9322),
  const Color(0xff775B77),
  const Color(0xffF2926F),
  const Color(0xff36187B),
  const Color(0xffCC2326),
  // const Color(0xff121b0e),
];
