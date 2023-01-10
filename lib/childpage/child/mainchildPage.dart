// ignore_for_file: file_names

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

import '/childpage/child/favoriteChildren.dart';
import '/childpage/child/speakingchildtablet.dart';
import '/controller/istablet.dart';
import '/controller/var.dart';
import '/view/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainChildPage extends StatefulWidget {
  final int index;
  const MainChildPage({super.key, required this.index});

  @override
  State<MainChildPage> createState() => _MainChildPageState();
}

class _MainChildPageState extends State<MainChildPage> {
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;

  int _selectedItemPosition = 1;

  Color selectedColor = pinkColor;

  //////////
  final _pageController = PageController(initialPage: 1);
  List<Widget> screens = [
    const FavoriteChildren(),
    const SpeakingChildTablet(),
    const SpeakingChildTablet(),
  ];
  late int indexpage;
  bool isLoading = false;
  playaudio() async {
    final player = AudioPlayer(); // Create a player
    await player.setAsset(// Load a URL
        noteVoices[notevoiceindex]); // Schemes: (https: | file: | asset: )
    player.play();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    indexpage = widget.index;

    getVoice();
    getfemail();
    setparentmode();

    super.initState();
  }

  getVoice() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      notevoiceindex = pref.getInt("noteVoiceIndex") ?? 0;
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

  setparentmode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setBool("isParentMode", false);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                body: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children:
                      List.generate(screens.length, (index) => screens[index]),
                ),
                extendBody: true,
                drawer: const Drawerc(),
                bottomNavigationBar: SnakeNavigationBar.color(
                  shadowColor: Colors.black,
                  elevation: 20,
                  backgroundColor: Color.fromARGB(255, 245, 236, 244),
                  behaviour: snakeBarStyle,
                  snakeShape: SnakeShape.circle,
                  shape: const RoundedRectangleBorder(
                    borderRadius: /*BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))*/
                        BorderRadius.all(Radius.circular(25)),
                  ),
                  padding:
                      const EdgeInsets.only(bottom: 5, right: 20, left: 20),
                  snakeViewColor: selectedColor,
                  selectedItemColor: SnakeShape.circle == SnakeShape.indicator
                      ? selectedColor
                      : null,
                  showUnselectedLabels: false,
                  showSelectedLabels: false,
                  currentIndex: _selectedItemPosition,
                  onTap: (index) {
                    if (index == 2) {
                      setState(() {
                        _selectedItemPosition = index;
                      });
                      Future.delayed(Duration(milliseconds: 1000))
                          .then((value) {
                        setState(() {
                          _selectedItemPosition = 1;
                        });
                        _pageController.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      });
                      playaudio();
                    } else {
                      setState(() {
                        _selectedItemPosition = index;
                      });
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/uiImages/star.png",
                            color: _selectedItemPosition == 0
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        label: 'calendar'),
                    BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/uiImages/home.png",
                            color: _selectedItemPosition == 1
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        label: 'home'),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/bell.png",
                          color: _selectedItemPosition == 2
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ));
  }
}
