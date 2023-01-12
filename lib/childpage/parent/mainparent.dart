import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

import '/childpage/parent/contentLibrary.dart';
import '/childpage/parent/mainparentSettings.dart';
import '/childpage/parent/parentSettingsFav.dart';
import '/controller/my_provider.dart';
import '/controller/var.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainParentPage extends StatefulWidget {
  final int index;
  const MainParentPage({super.key, required this.index});

  @override
  State<MainParentPage> createState() => _MainParentPageState();
}

class _MainParentPageState extends State<MainParentPage> {
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;

  Color selectedColor = maincolor;
  List<Widget> parentScreens = [
    const ParentSettingsFav(),
    const MainParentSettings(),
    const MainParentSettings(),
  ];

  late int indexpage;

  playaudio() async {
    final player = AudioPlayer(); // Create a player
    await player.setAsset(// Load a URL
        noteVoices[notevoiceindex]); // Schemes: (https: | file: | asset: )
    player.play();
  }

  @override
  void initState() {
    indexpage = widget.index;

    getSize();

    getVoice();
    getfemail();
    setparentmode();
    super.initState();
  }

  setparentmode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setBool("isParentMode", true);
  }

  getVoice() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      notevoiceindex = pref.getInt("noteVoiceIndex") ?? 0;
    });
  }

  getSize() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      size = pref.getInt("size") ?? 1;
    });
  }

  getfemail() async {
    SharedPreferences female = await SharedPreferences.getInstance();
    var f = female.getBool("female");
    if (f == null) {
      setState(() {
        isFemale = false;
      });
    } else {
      setState(() {
        isFemale = f;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Provider.of<MyProvider>(context, listen: true)
                      .iscontentOfLibrary !=
                  -1
              ? contentLibraryChild(
                  libIndex: Provider.of<MyProvider>(context, listen: true)
                      .iscontentOfLibrary)
              : parentScreens[indexpage],
          bottomNavigationBar: SnakeNavigationBar.color(
            shadowColor: Colors.black,
            elevation: 20,
            backgroundColor: const Color.fromARGB(255, 245, 236, 244),
            behaviour: snakeBarStyle,
            snakeShape: SnakeShape.circle,
            shape: const RoundedRectangleBorder(
              borderRadius: /*BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))*/
                  BorderRadius.all(Radius.circular(25)),
            ),
            padding: const EdgeInsets.only(bottom: 5, right: 20, left: 20),
            snakeViewColor: selectedColor,
            selectedItemColor: SnakeShape.circle == SnakeShape.indicator
                ? selectedColor
                : null,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            currentIndex: indexpage,
            onTap: (index) {
              if (index == 2) {
                setState(() {
                  indexpage = index;
                });
                Future.delayed(const Duration(milliseconds: 1000))
                    .then((value) {
                  Provider.of<MyProvider>(context, listen: false)
                      .setIscontentOfLibrary(-1);
                  setState(() {
                    indexpage = 1;
                  });
                });
                playaudio();
              } else {
                Provider.of<MyProvider>(context, listen: false)
                    .setIscontentOfLibrary(-1);
                setState(() {
                  indexpage = index;
                });
              }
            },
            items: [
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/uiImages/star.png",
                      color: indexpage == 0 ? Colors.white : Colors.black,
                    ),
                  ),
                  label: 'calendar'),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/uiImages/home.png",
                      color: indexpage == 1 ? Colors.white : Colors.black,
                    ),
                  ),
                  label: 'home'),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/bell.png",
                    color: indexpage == 2 ? Colors.white : Colors.black,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
