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
  List<Widget> parentScreens = [MainParentSettings(), ParentSettingsFav()];

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
          bottomNavigationBar: Container(
            height: MediaQuery.of(context).orientation == Orientation.portrait
                ? MediaQuery.of(context).size.height * .07
                : MediaQuery.of(context).size.height * .09,
            decoration: BoxDecoration(
              color: Color(0xffe9edf3),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
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
                        Provider.of<MyProvider>(context, listen: false)
                            .setIscontentOfLibrary(-1);
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
        ));
  }
}
