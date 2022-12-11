import '/childpage/child/favoriteChildren.dart';
import '/childpage/child/speakingchildtablet.dart';
import '/childpage/child/speakingchildphone.dart';
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
  List<Widget> screens = [
    DeviceUtil.isTablet
        ? const SpeakingChildTablet()
        : const SpeakingChildPhone(),
    const FavoriteChildren()
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

/*
  getColor() async {
    SharedPreferences color = await SharedPreferences.getInstance();
    int colorind = color.getInt("color") ?? 0;
    setState(() {
      purpleColor = colorList[colorind];
    });
  }
*/
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
                body: screens[indexpage],
                appBar: AppBar(
                  toolbarHeight: 40,
                  backgroundColor: maincolor,
                ),
                drawer: const Drawerc(),
                bottomNavigationBar: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).orientation !=
                              Orientation.portrait
                          ? 80
                          : 50),
                  child: Container(
                    height: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? MediaQuery.of(context).size.height * .07
                        : MediaQuery.of(context).size.height * .09,
                    decoration: BoxDecoration(
                      color: Color(0xffe9edf3),
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
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                              onTap: () {
                                setState(() {
                                  indexpage = 1;
                                });
                              },
                              child: Image.asset("assets/uiImages/star.png")),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  indexpage = 0;
                                });
                              },
                              child: Image.asset("assets/uiImages/home.png")),
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
              ));
  }
}
