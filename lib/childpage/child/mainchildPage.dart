import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '/childpage/child/favoriteChildren.dart';
import '/childpage/child/speakingchildtablet.dart';
import '/controller/data_one_time.dart';
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
  final _pageController = PageController(initialPage: 1);
  List<Widget> screens = [
    DeviceUtil.isTablet
        ? const SpeakingChildTablet()
        : const Scaffold(
            body: Center(
              child: Text("phone"),
            ),
          ),
    DeviceUtil.isTablet
        ? const SpeakingChildTablet()
        : const Scaffold(
            body: Center(
              child: Text("phone"),
            ),
          ),
    const FavoriteChildren(),
  ];
  late int indexpage;
  bool isLoading = true;
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
    //getColor();
    getVoice();
    getfemail();
    setparentmode();
    setDataChildOneTime().then((value) {
      setState(() {
        isLoading = false;
      });
    });
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
                bottomNavigationBar: AnimatedNotchBottomBar(
                  pageController: _pageController,
                  color: Colors.white,
                  showLabel: false,
                  notchColor: pinkColor,
                  bottomBarItems: [
                    BottomBarItem(
                      inActiveItem: Image.asset(
                        "assets/bell.png",
                        color: Colors.blueGrey,
                      ),
                      activeItem: Image.asset(
                        "assets/bell.png",
                        color: Colors.white,
                      ),
                      itemLabel: 'Page 3',
                    ),
                    BottomBarItem(
                      inActiveItem: Image.asset(
                        "assets/uiImages/home.png",
                        color: Colors.blueGrey,
                      ),
                      activeItem: Image.asset(
                        "assets/uiImages/home.png",
                        color: Colors.white,
                      ),
                    ),
                    BottomBarItem(
                      inActiveItem: Image.asset(
                        "assets/uiImages/star.png",
                        color: Colors.blueGrey,
                      ),
                      activeItem: Image.asset(
                        "assets/uiImages/star.png",
                        color: Colors.white,
                      ),
                    ),
                  ],
                  onTap: (index) {
                    if (index == 0) {
                      playaudio();
                    } else {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                )

                /*
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Container(
                    height: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? MediaQuery.of(context).size.height * .07
                        : MediaQuery.of(context).size.height * .09,
                    decoration: BoxDecoration(
                      color: const Color(0xffe9edf3),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 3)),
                      ],
                      border: Border.all(
                        width: 2,
                        color: Colors.grey,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                              onTap: () {
                                setState(() {
                                  indexpage = 1;
                                });
                              },
                              child: Image.asset(
                                "assets/uiImages/star.png",
                              )),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  indexpage = 0;
                                });
                              },
                              child: Image.asset(
                                "assets/uiImages/home.png",
                              )),
                          InkWell(
                              onTap: () {
                                playaudio();
                              },
                              child: Image.asset("assets/bell.png")),
                        ],
                      ),
                    ),
                  ),
                ),
            */
                ));
  }
}
