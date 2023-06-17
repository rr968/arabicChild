// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import '../../main.dart';
import '/childpage/child/mainchildPage.dart';
import '/childpage/constant.dart';
import '/childpage/parent/mainparent.dart';
import '/controller/istablet.dart';
import '/controller/my_provider.dart';
import '/view/drawer/HowToUse.dart';
import 'package:provider/provider.dart';

import '/controller/button.dart';
import '/controller/checkinternet.dart';
import '/view/Auth/login.dart';
import '/view/drawer/aboutapp.dart';
import '/view/drawer/contactus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volume_controller/volume_controller.dart';

import '../../controller/erroralert.dart';
import '../../controller/removeallshared.dart';
import '../../controller/var.dart';
import 'libraryUplodedSettings.dart';

class Drawerc extends StatefulWidget {
  const Drawerc({Key? key}) : super(key: key);

  @override
  State<Drawerc> createState() => _DrawercState();
}

class _DrawercState extends State<Drawerc> {
  int radiovalue1 = isFemale ? 1 : 0;
  int radiovalue2 = 0;
  int radiovalue3 = size;
  int radiovalue4 = notevoiceindex;
  int radiovalue5 = 1;
  bool isExpanded = false;
  bool isExpanded1 = false;
  bool isLoading = true;
  late bool isParentMode;
  late bool switchValue;
  bool isDeleting = false;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    getdata().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  Future getdata() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    radiovalue2 = pref.getInt("volume") ?? 0;
    isParentMode = pref.getBool("isParentMode") ?? false;
    switchValue = pref.getBool("switchValue") ?? true;
    radiovalue5 = pref.getInt("CurrentSpeakSpeed") ?? 1;
  }

  double fontSize = 24;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: pinkColor,
            ),
          )
        : Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(1)),
            child: Drawer(
                // backgroundColor: Color(0xffd6e4e7),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30)),
                ),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(),
                  child: ListView(
                    children: [
                      Image.asset(
                        "assets/uiImages/logo1.png",
                        height: DeviceUtil.isTablet ? 160 : 150,
                        width: DeviceUtil.isTablet ? 100 : 90,
                        fit: BoxFit.contain,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Center(
                            child: FittedBox(
                          child: Text(
                            "   ${user!.email ?? 'Anonymous'}  ",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        )),
                      ),
                      Container(
                        height: DeviceUtil.isTablet ? 20 : 0,
                      ),
                      ExpansionTile(
                        title: Row(children: [
                          Image.asset(
                            "assets/uiImages/settings.png",
                            height: 30,
                          ),
                          Container(
                            width: 10,
                          ),
                          Text(
                            "الإعدادات",
                            style: TextStyle(
                              fontSize: fontSize,
                              color: isExpanded
                                  ? pinkColor
                                  : const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ]),
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      ExpansionTile(
                                        title: Row(
                                          children: [
                                            Image.asset(
                                              "assets/uiImages/microphone.png",
                                              height: 30,
                                            ),
                                            Container(
                                              width: 10,
                                            ),
                                            Text(
                                              "صوت المتحدث",
                                              style: TextStyle(
                                                fontSize: fontSize,
                                                color: isExpanded1
                                                    ? pinkColor
                                                    : const Color.fromARGB(
                                                        255, 0, 0, 0),
                                              ),
                                            ),
                                          ],
                                        ),
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  ListTile(
                                                    title: Text(
                                                      "رجل",
                                                      style: TextStyle(
                                                        fontSize: fontSize,
                                                      ),
                                                    ),
                                                    leading: Radio(
                                                      value: 0,
                                                      groupValue: radiovalue1,
                                                      onChanged: (v) async {
                                                        SharedPreferences
                                                            female =
                                                            await SharedPreferences
                                                                .getInstance();
                                                        female.setBool(
                                                            "female", false);
                                                        setState(() {
                                                          isFemale = false;
                                                          radiovalue1 =
                                                              v as int;
                                                        });
                                                      },
                                                      activeColor: pinkColor,
                                                    ),
                                                  ),
                                                  ListTile(
                                                    title: Text(
                                                      "امرأة",
                                                      style: TextStyle(
                                                        fontSize: fontSize,
                                                      ),
                                                    ),
                                                    leading: Radio(
                                                        value: 1,
                                                        groupValue: radiovalue1,
                                                        onChanged: (v) async {
                                                          SharedPreferences
                                                              female =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          female.setBool(
                                                              "female", true);
                                                          setState(() {
                                                            isFemale = true;
                                                            radiovalue1 =
                                                                v as int;
                                                          });
                                                        },
                                                        activeColor: pinkColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                        onExpansionChanged: (bool expanding) =>
                                            setState(
                                                () => isExpanded1 = expanding),
                                      ),
                                      ExpansionTile(
                                        title: Row(
                                          children: [
                                            const Icon(Icons.speed),
                                            Container(
                                              width: 10,
                                            ),
                                            Text(
                                              "سرعة المتحدث",
                                              style: TextStyle(
                                                fontSize: fontSize,
                                                color: isExpanded1
                                                    ? pinkColor
                                                    : const Color.fromARGB(
                                                        255, 0, 0, 0),
                                              ),
                                            ),
                                          ],
                                        ),
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  ListTile(
                                                    title: Text(
                                                      "عادي",
                                                      style: TextStyle(
                                                        fontSize: fontSize,
                                                      ),
                                                    ),
                                                    leading: Radio(
                                                      value: 0,
                                                      groupValue: radiovalue5,
                                                      onChanged: (v) async {
                                                        SharedPreferences
                                                            speed =
                                                            await SharedPreferences
                                                                .getInstance();
                                                        speed.setInt(
                                                            "CurrentSpeakSpeed",
                                                            0);
                                                        setState(() {
                                                          currentSpeakSpead = 0;
                                                          radiovalue5 =
                                                              v as int;
                                                        });
                                                      },
                                                      activeColor: pinkColor,
                                                    ),
                                                  ),
                                                  ListTile(
                                                    title: Text(
                                                      "متوسط",
                                                      style: TextStyle(
                                                        fontSize: fontSize,
                                                      ),
                                                    ),
                                                    leading: Radio(
                                                        value: 1,
                                                        groupValue: radiovalue5,
                                                        onChanged: (v) async {
                                                          SharedPreferences
                                                              speed =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          speed.setInt(
                                                              "CurrentSpeakSpeed",
                                                              1);
                                                          setState(() {
                                                            currentSpeakSpead =
                                                                1;
                                                            radiovalue5 =
                                                                v as int;
                                                          });
                                                        },
                                                        activeColor: pinkColor),
                                                  ),
                                                  ListTile(
                                                    title: Text(
                                                      "بطيء",
                                                      style: TextStyle(
                                                        fontSize: fontSize,
                                                      ),
                                                    ),
                                                    leading: Radio(
                                                        value: 2,
                                                        groupValue: radiovalue5,
                                                        onChanged: (v) async {
                                                          SharedPreferences
                                                              speed =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          speed.setInt(
                                                              "CurrentSpeakSpeed",
                                                              2);
                                                          setState(() {
                                                            currentSpeakSpead =
                                                                2;
                                                            radiovalue5 =
                                                                v as int;
                                                          });
                                                        },
                                                        activeColor: pinkColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                        onExpansionChanged: (bool expanding) =>
                                            setState(
                                                () => isExpanded1 = expanding),
                                      ),
                                      ExpansionTile(
                                        title: Row(
                                          children: [
                                            Image.asset(
                                              "assets/uiImages/bell-ring.png",
                                              height: 30,
                                            ),
                                            Container(
                                              width: 10,
                                            ),
                                            Text(
                                              "صوت التنبيه",
                                              style: TextStyle(
                                                fontSize: fontSize,
                                                color: isExpanded1
                                                    ? pinkColor
                                                    : const Color.fromARGB(
                                                        255, 0, 0, 0),
                                              ),
                                            ),
                                          ],
                                        ),
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  ListTile(
                                                    title: Text(
                                                      "تنبيه ١",
                                                      style: TextStyle(
                                                        fontSize: fontSize,
                                                      ),
                                                    ),
                                                    leading: Radio(
                                                      value: 0,
                                                      groupValue: radiovalue4,
                                                      onChanged: (v) async {
                                                        SharedPreferences pref =
                                                            await SharedPreferences
                                                                .getInstance();
                                                        pref.setInt(
                                                            "noteVoiceIndex",
                                                            v as int);
                                                        final player =
                                                            AudioPlayer();
                                                        await player.setAsset(
                                                            noteVoices[0]);
                                                        player.play();
                                                        setState(() {
                                                          radiovalue4 = v;
                                                          notevoiceindex =
                                                              radiovalue4;
                                                        });
                                                      },
                                                      activeColor: pinkColor,
                                                    ),
                                                  ),
                                                  ListTile(
                                                    title: Text(
                                                      "تنبيه ٢",
                                                      style: TextStyle(
                                                        fontSize: fontSize,
                                                      ),
                                                    ),
                                                    leading: Radio(
                                                        value: 1,
                                                        groupValue: radiovalue4,
                                                        onChanged: (v) async {
                                                          SharedPreferences
                                                              pref =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          pref.setInt(
                                                              "noteVoiceIndex",
                                                              v as int);
                                                          final player =
                                                              AudioPlayer();
                                                          await player.setAsset(
                                                              // Load a URL
                                                              noteVoices[
                                                                  v]); // Schemes: (https: | file: | asset: )
                                                          player.play();
                                                          setState(() {
                                                            radiovalue4 = v;
                                                            notevoiceindex =
                                                                radiovalue4;
                                                          });
                                                        },
                                                        activeColor: pinkColor),
                                                  ),
                                                  ListTile(
                                                    title: Text(
                                                      "تنبيه ٣",
                                                      style: TextStyle(
                                                        fontSize: fontSize,
                                                      ),
                                                    ),
                                                    leading: Radio(
                                                        value: 2,
                                                        groupValue: radiovalue4,
                                                        onChanged: (v) async {
                                                          SharedPreferences
                                                              pref =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          pref.setInt(
                                                              "noteVoiceIndex",
                                                              v as int);
                                                          final player =
                                                              AudioPlayer();
                                                          await player.setAsset(
                                                              // Load a URL
                                                              noteVoices[
                                                                  v]); // Schemes: (https: | file: | asset: )
                                                          player.play();
                                                          setState(() {
                                                            radiovalue4 = v;
                                                            notevoiceindex =
                                                                radiovalue4;
                                                          });
                                                        },
                                                        activeColor: pinkColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                        onExpansionChanged: (bool expanding) =>
                                            setState(
                                                () => isExpanded1 = expanding),
                                      ),
                                      ExpansionTile(
                                        title: Row(
                                          children: [
                                            Image.asset(
                                              "assets/uiImages/megaphone.png",
                                              height: 30,
                                            ),
                                            Container(
                                              width: 10,
                                            ),
                                            Text(
                                              "مستوى الصوت",
                                              style: TextStyle(
                                                fontSize: fontSize,
                                                color: isExpanded1
                                                    ? pinkColor
                                                    : const Color.fromARGB(
                                                        255, 0, 0, 0),
                                              ),
                                            ),
                                          ],
                                        ),
                                        children: <Widget>[
                                          /////////////////////////////////////////
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  ListTile(
                                                    title: Text(
                                                      "مرتفع",
                                                      style: TextStyle(
                                                        fontSize: fontSize,
                                                      ),
                                                    ),
                                                    leading: Radio(
                                                      value: 0,
                                                      groupValue: radiovalue2,
                                                      onChanged: (v) async {
                                                        SharedPreferences
                                                            volume =
                                                            await SharedPreferences
                                                                .getInstance();
                                                        volume.setInt(
                                                            "volume", 0);
                                                        VolumeController()
                                                            .setVolume(1);
                                                        setState(() {
                                                          radiovalue2 =
                                                              v as int;
                                                        });
                                                      },
                                                      activeColor: pinkColor,
                                                    ),
                                                  ),
                                                  ListTile(
                                                    title: Text(
                                                      "متوسط",
                                                      style: TextStyle(
                                                        fontSize: fontSize,
                                                      ),
                                                    ),
                                                    leading: Radio(
                                                        value: 1,
                                                        groupValue: radiovalue2,
                                                        onChanged: (v) async {
                                                          SharedPreferences
                                                              volume =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          volume.setInt(
                                                              "volume", 1);
                                                          VolumeController()
                                                              .setVolume(.65);
                                                          setState(() {
                                                            radiovalue2 =
                                                                v as int;
                                                          });
                                                        },
                                                        activeColor: pinkColor),
                                                  ),
                                                  ListTile(
                                                    title: Text(
                                                      "منخفض",
                                                      style: TextStyle(
                                                        fontSize: fontSize,
                                                      ),
                                                    ),
                                                    leading: Radio(
                                                        value: 2,
                                                        groupValue: radiovalue2,
                                                        onChanged: (v) async {
                                                          SharedPreferences
                                                              volume =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          volume.setInt(
                                                              "volume", 2);
                                                          VolumeController()
                                                              .setVolume(.4);
                                                          setState(() {
                                                            radiovalue2 =
                                                                v as int;
                                                          });
                                                        },
                                                        activeColor: pinkColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                        onExpansionChanged: (bool expanding) =>
                                            setState(
                                                () => isExpanded1 = expanding),
                                      ),
                                      ExpansionTile(
                                        title: Row(
                                          children: [
                                            Image.asset(
                                              "assets/uiImages/pixabay.png",
                                              height: 30,
                                            ),
                                            Container(
                                              width: 10,
                                            ),
                                            Text(
                                              "حجم الواجهة",
                                              style: TextStyle(
                                                fontSize: fontSize,
                                                color: isExpanded1
                                                    ? pinkColor
                                                    : const Color.fromARGB(
                                                        255, 0, 0, 0),
                                              ),
                                            ),
                                          ],
                                        ),
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  ListTile(
                                                    title: Text(
                                                      "افتراضي",
                                                      style: TextStyle(
                                                        fontSize: fontSize,
                                                      ),
                                                    ),
                                                    leading: Radio(
                                                        value: 1,
                                                        groupValue: radiovalue3,
                                                        onChanged: (v) async {
                                                          SharedPreferences
                                                              pref =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          pref.setInt(
                                                              "size", 1);
                                                          setState(() {
                                                            radiovalue3 =
                                                                v as int;
                                                            size = radiovalue3;
                                                          });

                                                          Navigator.pushAndRemoveUntil(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      const MainChildPage(
                                                                          index:
                                                                              0)),
                                                              (route) => false);
                                                        },
                                                        activeColor: pinkColor),
                                                  ),
                                                  ListTile(
                                                    title: Text(
                                                      "كبير",
                                                      style: TextStyle(
                                                        fontSize: fontSize,
                                                      ),
                                                    ),
                                                    leading: Radio(
                                                      value: 0,
                                                      groupValue: radiovalue3,
                                                      onChanged: (v) async {
                                                        SharedPreferences pref =
                                                            await SharedPreferences
                                                                .getInstance();
                                                        pref.setInt("size", 0);

                                                        setState(() {
                                                          radiovalue3 =
                                                              v as int;
                                                          size = radiovalue3;
                                                        });

                                                        Navigator.pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    const MainChildPage(
                                                                        index:
                                                                            0)),
                                                            (route) => false);
                                                      },
                                                      activeColor: pinkColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                        onExpansionChanged: (bool expanding) =>
                                            setState(
                                                () => isExpanded1 = expanding),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 20, bottom: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  "assets/uiImages/comment-text.png",
                                                  height: 30,
                                                ),
                                                Container(
                                                  width: 10,
                                                ),
                                                FittedBox(
                                                  child: Text(
                                                    "النطق أثناء الكتابة",
                                                    style: TextStyle(
                                                      fontSize: 22,
                                                      color: isExpanded1
                                                          ? pinkColor
                                                          : const Color
                                                                  .fromARGB(
                                                              255, 0, 0, 0),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Switch(
                                                value: switchValue,
                                                activeColor: pinkColor,
                                                onChanged: ((value) async {
                                                  setState(() {
                                                    switchValue = value;
                                                  });
                                                  SharedPreferences switchV =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  switchV
                                                      .setBool(
                                                          "switchValue", value)
                                                      .then((value) => Navigator
                                                          .pushAndRemoveUntil(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      const MainChildPage(
                                                                          index:
                                                                              0)),
                                                              (route) =>
                                                                  false));
                                                })),
                                          ],
                                        ),
                                      ),
                                      /* InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditFilesContent()));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20, bottom: 15),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.edit),
                                              Container(
                                                width: 10,
                                              ),
                                              FittedBox(
                                                child: Text(
                                                  "تعديل محتوى الملفات",
                                                  style: TextStyle(
                                                    fontSize: 22,
                                                    color: isExpanded1
                                                        ? pinkColor
                                                        : const Color.fromARGB(
                                                            255, 0, 0, 0),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  */
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                        onExpansionChanged: (bool expanding) =>
                            setState(() => isExpanded = expanding),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                        child: InkWell(
                          child: SizedBox(
                            height: 60,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(children: [
                                const Icon(
                                  Icons.menu_book_outlined,
                                  size: 34,
                                ),
                                /*Image.asset(
                                "assets/uiImages/comment-info.png",
                                height: 30,
                              ),*/
                                Container(
                                  width: 10,
                                ),
                                Text("شرح التطبيق",
                                    style: TextStyle(
                                      fontSize: fontSize,
                                    )),
                              ]),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HowToUse()));
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                        child: InkWell(
                          child: SizedBox(
                            height: 60,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(children: [
                                Image.asset(
                                  "assets/uiImages/comment-info.png",
                                  height: 30,
                                ),
                                Container(
                                  width: 10,
                                ),
                                Text("عن التطبيق",
                                    style: TextStyle(
                                      fontSize: fontSize,
                                    )),
                              ]),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AboutApp()));
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                        child: InkWell(
                          child: SizedBox(
                            height: 60,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(children: [
                                const Icon(
                                  Icons.mail_outline,
                                  size: 35,
                                ),
                                /*  Image.asset(
                                "assets/uiImages/bell-ring.png",
                                height: 30,
                              ),*/
                                Container(
                                  width: 10,
                                ),
                                Text("تواصل معنا",
                                    style: TextStyle(
                                      fontSize: fontSize,
                                    )),
                              ]),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Contactus(),
                                ));
                          },
                        ),
                      ),
                      FirebaseAuth.instance.currentUser!.uid ==
                              "ROobAfpdsdP8nViYxAKJbQu2fkr1"
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, left: 8.0),
                              child: InkWell(
                                  child: SizedBox(
                                    height: 60,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(children: [
                                        Icon(
                                          Icons.control_camera,
                                          color: maincolor,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text("متابعة التنزيلات",
                                              style: TextStyle(
                                                fontSize: fontSize,
                                              )),
                                        ),
                                      ]),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LibraryUploadedSettings()));
                                  }),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                        child: InkWell(
                          child: SizedBox(
                            height: 60,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(children: [
                                Image.asset(
                                  "assets/uiImages/sign-in-alt.png",
                                  height: 30,
                                ),
                                Container(
                                  width: 10,
                                ),
                                Text("تسجيل الخروج",
                                    style: TextStyle(
                                      fontSize: fontSize,
                                    )),
                              ]),
                            ),
                          ),
                          onTap: () async {
                            if (await internetConnection()) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      title: const Text(
                                        'تسجيل الخروج',
                                        textDirection: TextDirection.rtl,
                                      ),
                                      content: const Text(
                                        "هل أنت متأكد من تسجيل الخروج",
                                        textDirection: TextDirection.rtl,
                                      ),
                                      actions: <Widget>[
                                        button(() {
                                          Navigator.of(context).pop();
                                        }, 'لا، تراجع'),
                                        button(() async {
                                          await FirebaseAuth.instance.signOut();
                                          SharedPreferences myLoginInfo =
                                              await SharedPreferences
                                                  .getInstance();
                                          List<String> myInfo =
                                              myLoginInfo.getStringList(
                                                      "myLoginInfo") ??
                                                  [];

                                          removeAllSharedPrefrences()
                                              .then((value) {
                                            if (myInfo.isNotEmpty) {
                                              myLoginInfo.setStringList(
                                                  "myLoginInfo", myInfo);
                                            }
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Login()),
                                                (route) => false);
                                          });
                                        }, 'نعم، أنا متأكد')
                                      ],
                                    );
                                  });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      " فضلا تأكد من اتصالك بالإنترنت",
                                      textAlign: TextAlign.right),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                        child: InkWell(
                          child: SizedBox(
                            height: 60,
                            child: Row(children: [
                              const Icon(
                                Icons.delete_outlined,
                                size: 40,
                              ),
                              Container(
                                width: 10,
                              ),
                              Text(
                                "حذف الحساب",
                                style: TextStyle(
                                    color: Colors.red, fontSize: fontSize),
                              ),
                            ]),
                          ),
                          onTap: () {
                            internetConnection().then((value) {
                              if (value == true) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        title: const Text(
                                          'حذف الحساب',
                                          textDirection: TextDirection.rtl,
                                        ),
                                        content: const Text(
                                          "هل أنت متأكد من حذف حسابك؟",
                                          textDirection: TextDirection.rtl,
                                        ),
                                        actions: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  height: 34,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: maincolor),
                                                  child: const Center(
                                                      child: Padding(
                                                    padding: EdgeInsets.all(7),
                                                    child: FittedBox(
                                                      child: Text(
                                                        'لا، تراجع',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  )),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  User user = FirebaseAuth
                                                      .instance.currentUser!;
                                                  Provider.of<MyProvider>(
                                                          context,
                                                          listen: false)
                                                      .isLoading(true);
                                                  try {
                                                    await user
                                                        .delete()
                                                        .then((value) async {
                                                      /* await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'childUsers')
                                                          .doc(user.uid)
                                                          .delete();*/
                                                      Navigator.pushAndRemoveUntil(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const Login()),
                                                          (route) => false);
                                                      isFemale =
                                                          false; // default
                                                      removeAllSharedPrefrences();
                                                      ScaffoldMessenger.of(
                                                              navigatorKey
                                                                  .currentContext!)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                        'تم حذف الحساب بنجاح',
                                                        textDirection:
                                                            TextDirection.rtl,
                                                      )));
                                                      Provider.of<MyProvider>(
                                                              context,
                                                              listen: false)
                                                          .isLoading(false);
                                                    });
                                                  } on Exception catch (_) {
                                                    Provider.of<MyProvider>(
                                                            context,
                                                            listen: false)
                                                        .isLoading(false);
                                                    removeAllSharedPrefrences();
                                                    Navigator.pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const Login()),
                                                        (route) => false);
                                                    ScaffoldMessenger.of(
                                                            navigatorKey
                                                                .currentContext!)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                      'تم حذف الحساب بنجاح',
                                                      textDirection:
                                                          TextDirection.rtl,
                                                    )));
                                                  }
                                                },
                                                child: Container(
                                                  height: 34,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: maincolor),
                                                  child: Center(
                                                      child: Provider.of<
                                                                      MyProvider>(
                                                                  context,
                                                                  listen: true)
                                                              .isloading
                                                          ? const CircularProgressIndicator(
                                                              color:
                                                                  Colors.white,
                                                            )
                                                          : const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8),
                                                              child: FittedBox(
                                                                child: Text(
                                                                  'نعم، أنا متأكد',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                            )),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    });
                              } else {
                                erroralert(context, "تحقق من اتصالك بالانترنت");
                              }
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 30, left: 30, top: 25),
                        child: InkWell(
                          onTap: () {
                            if (isParentMode) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MainChildPage(index: 0)),
                                  (route) => false);
                            } else {
                              Random random = Random();
                              int n1 = random.nextInt(10);
                              int n2 = random.nextInt(10);
                              int n3 = random.nextInt(10);
                              int n4 = random.nextInt(10);
                              String text = "";
                              for (int i = 1; i <= 4; i++) {
                                if (i == 1) {
                                  text += "${getNumber(n1)},";
                                } else if (i == 2) {
                                  text += "${getNumber(n2)},";
                                } else if (i == 3) {
                                  text += "${getNumber(n3)},";
                                } else if (i == 4) {
                                  text += getNumber(n4);
                                }
                              }

                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: AlertDialog(
                                          insetPadding: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      DeviceUtil.isTablet
                                                          ? 32
                                                          : 20))),
                                          title: Column(
                                            children: [
                                              InkWell(
                                                onTap: () =>
                                                    Navigator.pop(context),
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Icon(
                                                    Icons.close,
                                                    size: DeviceUtil.isTablet
                                                        ? 40
                                                        : 24,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      flex: DeviceUtil.isTablet
                                                          ? 1
                                                          : 4,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    greyColor),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    DeviceUtil
                                                                            .isTablet
                                                                        ? 32
                                                                        : 20)),
                                                        child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                height: 17,
                                                              ),
                                                              Image.asset(
                                                                "assets/uiImages/lock.png",
                                                                height: DeviceUtil
                                                                        .isTablet
                                                                    ? 80
                                                                    : 50,
                                                              ),
                                                              Padding(
                                                                padding: DeviceUtil
                                                                        .isTablet
                                                                    ? const EdgeInsets
                                                                        .all(15)
                                                                    : const EdgeInsets
                                                                            .only(
                                                                        top: 10,
                                                                        bottom:
                                                                            10),
                                                                child: Text(
                                                                  "الدخول للصلاحيات",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        DeviceUtil.isTablet
                                                                            ? 30
                                                                            : 17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900,
                                                                    color:
                                                                        pinkColor,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: DeviceUtil
                                                                            .isTablet
                                                                        ? 8.0
                                                                        : 2,
                                                                    right: DeviceUtil
                                                                            .isTablet
                                                                        ? 8.0
                                                                        : 2,
                                                                    bottom: 8),
                                                                child: Text(
                                                                  "الرجاء إدخال الرمز التالي للدخول",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        DeviceUtil.isTablet
                                                                            ? 18
                                                                            : 10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        greyColor,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: DeviceUtil
                                                                            .isTablet
                                                                        ? 8.0
                                                                        : 2,
                                                                    right: DeviceUtil
                                                                            .isTablet
                                                                        ? 8.0
                                                                        : 2,
                                                                    bottom: DeviceUtil
                                                                            .isTablet
                                                                        ? 15
                                                                        : 9),
                                                                child: Text(
                                                                  text,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        DeviceUtil.isTablet
                                                                            ? 18
                                                                            : 13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        greyColor,
                                                                  ),
                                                                ),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  Container(
                                                                    height: DeviceUtil
                                                                            .isTablet
                                                                        ? 60
                                                                        : 30,
                                                                    width: DeviceUtil
                                                                            .isTablet
                                                                        ? 60
                                                                        : 30,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border: Border.all(
                                                                            color:
                                                                                greyColor),
                                                                        borderRadius: BorderRadius.circular(DeviceUtil.isTablet
                                                                            ? 15
                                                                            : 5)),
                                                                    child: Center(
                                                                        child: Text(
                                                                      Provider.of<MyProvider>(context).pass4 ==
                                                                              -1
                                                                          ? ""
                                                                          : Provider.of<MyProvider>(context)
                                                                              .pass4
                                                                              .toString(),
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize: DeviceUtil.isTablet
                                                                              ? 35
                                                                              : 20),
                                                                    )),
                                                                  ),
                                                                  Container(
                                                                    height: DeviceUtil
                                                                            .isTablet
                                                                        ? 60
                                                                        : 30,
                                                                    width: DeviceUtil
                                                                            .isTablet
                                                                        ? 60
                                                                        : 30,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border: Border.all(
                                                                            color:
                                                                                greyColor),
                                                                        borderRadius: BorderRadius.circular(DeviceUtil.isTablet
                                                                            ? 15
                                                                            : 5)),
                                                                    child: Center(
                                                                        child: Text(
                                                                      Provider.of<MyProvider>(context).pass3 ==
                                                                              -1
                                                                          ? ""
                                                                          : Provider.of<MyProvider>(context)
                                                                              .pass3
                                                                              .toString(),
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize: DeviceUtil.isTablet
                                                                              ? 35
                                                                              : 20),
                                                                    )),
                                                                  ),
                                                                  Container(
                                                                    height: DeviceUtil
                                                                            .isTablet
                                                                        ? 60
                                                                        : 30,
                                                                    width: DeviceUtil
                                                                            .isTablet
                                                                        ? 60
                                                                        : 30,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border: Border.all(
                                                                            color:
                                                                                greyColor),
                                                                        borderRadius: BorderRadius.circular(DeviceUtil.isTablet
                                                                            ? 15
                                                                            : 5)),
                                                                    child: Center(
                                                                        child: Text(
                                                                      Provider.of<MyProvider>(context).pass2 ==
                                                                              -1
                                                                          ? ""
                                                                          : Provider.of<MyProvider>(context)
                                                                              .pass2
                                                                              .toString(),
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize: DeviceUtil.isTablet
                                                                              ? 35
                                                                              : 20),
                                                                    )),
                                                                  ),
                                                                  Container(
                                                                    height: DeviceUtil
                                                                            .isTablet
                                                                        ? 60
                                                                        : 30,
                                                                    width: DeviceUtil
                                                                            .isTablet
                                                                        ? 60
                                                                        : 30,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border: Border.all(
                                                                            color:
                                                                                greyColor),
                                                                        borderRadius: BorderRadius.circular(DeviceUtil.isTablet
                                                                            ? 15
                                                                            : 5)),
                                                                    child: Center(
                                                                        child: Text(
                                                                      Provider.of<MyProvider>(context).pass1 ==
                                                                              -1
                                                                          ? ""
                                                                          : Provider.of<MyProvider>(context)
                                                                              .pass1
                                                                              .toString(),
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize: DeviceUtil.isTablet
                                                                              ? 35
                                                                              : 20),
                                                                    )),
                                                                  ),
                                                                ],
                                                              ),
                                                              Provider.of<MyProvider>(
                                                                          context,
                                                                          listen:
                                                                              true)
                                                                      .errorpass
                                                                  ? const Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        "رمز خاطئ",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.red),
                                                                      ),
                                                                    )
                                                                  : Container(),
                                                              Container(
                                                                height: 20,
                                                              ),
                                                            ]),
                                                      )),
                                                  Container(
                                                    width: DeviceUtil.isTablet
                                                        ? 30
                                                        : 6,
                                                  ),
                                                  Expanded(
                                                      flex: DeviceUtil.isTablet
                                                          ? 1
                                                          : 3,
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  setpass(
                                                                      3,
                                                                      n1,
                                                                      n2,
                                                                      n3,
                                                                      n4,
                                                                      false);
                                                                },
                                                                child: Padding(
                                                                  padding: EdgeInsets.all(
                                                                      DeviceUtil
                                                                              .isTablet
                                                                          ? 8.0
                                                                          : 2),
                                                                  child:
                                                                      Container(
                                                                    height: DeviceUtil
                                                                            .isTablet
                                                                        ? 75
                                                                        : 32,
                                                                    width: DeviceUtil
                                                                            .isTablet
                                                                        ? 75
                                                                        : 32,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border: Border.all(
                                                                            color:
                                                                                greyColor),
                                                                        borderRadius: BorderRadius.circular(DeviceUtil.isTablet
                                                                            ? 15
                                                                            : 9)),
                                                                    child: Center(
                                                                        child: Text(
                                                                      "3",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize: DeviceUtil.isTablet
                                                                              ? 35
                                                                              : 22),
                                                                    )),
                                                                  ),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  setpass(
                                                                      2,
                                                                      n1,
                                                                      n2,
                                                                      n3,
                                                                      n4,
                                                                      false);
                                                                },
                                                                child: Padding(
                                                                  padding: EdgeInsets.all(
                                                                      DeviceUtil
                                                                              .isTablet
                                                                          ? 8.0
                                                                          : 2),
                                                                  child:
                                                                      Container(
                                                                    height: DeviceUtil
                                                                            .isTablet
                                                                        ? 75
                                                                        : 32,
                                                                    width: DeviceUtil
                                                                            .isTablet
                                                                        ? 75
                                                                        : 32,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border: Border.all(
                                                                            color:
                                                                                greyColor),
                                                                        borderRadius: BorderRadius.circular(DeviceUtil.isTablet
                                                                            ? 15
                                                                            : 9)),
                                                                    child: Center(
                                                                        child: Text(
                                                                      "2",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize: DeviceUtil.isTablet
                                                                              ? 35
                                                                              : 22),
                                                                    )),
                                                                  ),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  setpass(
                                                                      1,
                                                                      n1,
                                                                      n2,
                                                                      n3,
                                                                      n4,
                                                                      false);
                                                                },
                                                                child: Padding(
                                                                  padding: EdgeInsets.all(
                                                                      DeviceUtil
                                                                              .isTablet
                                                                          ? 8.0
                                                                          : 2),
                                                                  child:
                                                                      Container(
                                                                    height: DeviceUtil
                                                                            .isTablet
                                                                        ? 75
                                                                        : 32,
                                                                    width: DeviceUtil
                                                                            .isTablet
                                                                        ? 75
                                                                        : 32,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border: Border.all(
                                                                            color:
                                                                                greyColor),
                                                                        borderRadius: BorderRadius.circular(DeviceUtil.isTablet
                                                                            ? 15
                                                                            : 9)),
                                                                    child: Center(
                                                                        child: Text(
                                                                      "1",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize: DeviceUtil.isTablet
                                                                              ? 35
                                                                              : 22),
                                                                    )),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  setpass(
                                                                      6,
                                                                      n1,
                                                                      n2,
                                                                      n3,
                                                                      n4,
                                                                      false);
                                                                },
                                                                child: Padding(
                                                                  padding: EdgeInsets.all(
                                                                      DeviceUtil
                                                                              .isTablet
                                                                          ? 8.0
                                                                          : 2),
                                                                  child:
                                                                      Container(
                                                                    height: DeviceUtil
                                                                            .isTablet
                                                                        ? 75
                                                                        : 32,
                                                                    width: DeviceUtil
                                                                            .isTablet
                                                                        ? 75
                                                                        : 32,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border: Border.all(
                                                                            color:
                                                                                greyColor),
                                                                        borderRadius: BorderRadius.circular(DeviceUtil.isTablet
                                                                            ? 15
                                                                            : 9)),
                                                                    child: Center(
                                                                        child: Text(
                                                                      "6",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize: DeviceUtil.isTablet
                                                                              ? 35
                                                                              : 22),
                                                                    )),
                                                                  ),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  setpass(
                                                                      5,
                                                                      n1,
                                                                      n2,
                                                                      n3,
                                                                      n4,
                                                                      false);
                                                                },
                                                                child: Padding(
                                                                  padding: EdgeInsets.all(
                                                                      DeviceUtil
                                                                              .isTablet
                                                                          ? 8.0
                                                                          : 2),
                                                                  child:
                                                                      Container(
                                                                    height: DeviceUtil
                                                                            .isTablet
                                                                        ? 75
                                                                        : 32,
                                                                    width: DeviceUtil
                                                                            .isTablet
                                                                        ? 75
                                                                        : 32,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border: Border.all(
                                                                            color:
                                                                                greyColor),
                                                                        borderRadius: BorderRadius.circular(DeviceUtil.isTablet
                                                                            ? 15
                                                                            : 9)),
                                                                    child: Center(
                                                                        child: Text(
                                                                      "5",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize: DeviceUtil.isTablet
                                                                              ? 35
                                                                              : 22),
                                                                    )),
                                                                  ),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  setpass(
                                                                      4,
                                                                      n1,
                                                                      n2,
                                                                      n3,
                                                                      n4,
                                                                      false);
                                                                },
                                                                child: Padding(
                                                                  padding: EdgeInsets.all(
                                                                      DeviceUtil
                                                                              .isTablet
                                                                          ? 8.0
                                                                          : 2),
                                                                  child:
                                                                      Container(
                                                                    height: DeviceUtil
                                                                            .isTablet
                                                                        ? 75
                                                                        : 32,
                                                                    width: DeviceUtil
                                                                            .isTablet
                                                                        ? 75
                                                                        : 32,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border: Border.all(
                                                                            color:
                                                                                greyColor),
                                                                        borderRadius: BorderRadius.circular(DeviceUtil.isTablet
                                                                            ? 15
                                                                            : 9)),
                                                                    child: Center(
                                                                        child: Text(
                                                                      "4",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize: DeviceUtil.isTablet
                                                                              ? 35
                                                                              : 22),
                                                                    )),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  setpass(
                                                                      9,
                                                                      n1,
                                                                      n2,
                                                                      n3,
                                                                      n4,
                                                                      false);
                                                                },
                                                                child: Padding(
                                                                  padding: EdgeInsets.all(
                                                                      DeviceUtil
                                                                              .isTablet
                                                                          ? 8.0
                                                                          : 2),
                                                                  child:
                                                                      Container(
                                                                    height: DeviceUtil
                                                                            .isTablet
                                                                        ? 75
                                                                        : 32,
                                                                    width: DeviceUtil
                                                                            .isTablet
                                                                        ? 75
                                                                        : 32,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border: Border.all(
                                                                            color:
                                                                                greyColor),
                                                                        borderRadius: BorderRadius.circular(DeviceUtil.isTablet
                                                                            ? 15
                                                                            : 9)),
                                                                    child: Center(
                                                                        child: Text(
                                                                      "9",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize: DeviceUtil.isTablet
                                                                              ? 35
                                                                              : 22),
                                                                    )),
                                                                  ),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  setpass(
                                                                      8,
                                                                      n1,
                                                                      n2,
                                                                      n3,
                                                                      n4,
                                                                      false);
                                                                },
                                                                child: Padding(
                                                                  padding: EdgeInsets.all(
                                                                      DeviceUtil
                                                                              .isTablet
                                                                          ? 8.0
                                                                          : 2),
                                                                  child:
                                                                      Container(
                                                                    height: DeviceUtil
                                                                            .isTablet
                                                                        ? 75
                                                                        : 32,
                                                                    width: DeviceUtil
                                                                            .isTablet
                                                                        ? 75
                                                                        : 32,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border: Border.all(
                                                                            color:
                                                                                greyColor),
                                                                        borderRadius: BorderRadius.circular(DeviceUtil.isTablet
                                                                            ? 15
                                                                            : 9)),
                                                                    child: Center(
                                                                        child: Text(
                                                                      "8",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize: DeviceUtil.isTablet
                                                                              ? 35
                                                                              : 22),
                                                                    )),
                                                                  ),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  setpass(
                                                                      7,
                                                                      n1,
                                                                      n2,
                                                                      n3,
                                                                      n4,
                                                                      false);
                                                                },
                                                                child: Padding(
                                                                  padding: EdgeInsets.all(
                                                                      DeviceUtil
                                                                              .isTablet
                                                                          ? 8.0
                                                                          : 2),
                                                                  child:
                                                                      Container(
                                                                    height: DeviceUtil
                                                                            .isTablet
                                                                        ? 75
                                                                        : 32,
                                                                    width: DeviceUtil
                                                                            .isTablet
                                                                        ? 75
                                                                        : 32,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border: Border.all(
                                                                            color:
                                                                                greyColor),
                                                                        borderRadius: BorderRadius.circular(DeviceUtil.isTablet
                                                                            ? 15
                                                                            : 9)),
                                                                    child: Center(
                                                                        child: Text(
                                                                      "7",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize: DeviceUtil.isTablet
                                                                              ? 35
                                                                              : 22),
                                                                    )),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  setpass(
                                                                      0,
                                                                      n1,
                                                                      n2,
                                                                      n3,
                                                                      n4,
                                                                      true);
                                                                },
                                                                child: Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: DeviceUtil
                                                                              .isTablet
                                                                          ? 15
                                                                          : 7,
                                                                      right: DeviceUtil
                                                                              .isTablet
                                                                          ? 15
                                                                          : 3),
                                                                  child:
                                                                      Container(
                                                                          height: DeviceUtil.isTablet
                                                                              ? 60
                                                                              : 30,
                                                                          width: DeviceUtil.isTablet
                                                                              ? 60
                                                                              : 30,
                                                                          decoration:
                                                                              const BoxDecoration(
                                                                            image:
                                                                                DecorationImage(image: AssetImage("assets/uiImages/delete.png"), matchTextDirection: true),
                                                                          )),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  setpass(
                                                                      0,
                                                                      n1,
                                                                      n2,
                                                                      n3,
                                                                      n4,
                                                                      false);
                                                                },
                                                                child: Padding(
                                                                  padding: EdgeInsets.all(
                                                                      DeviceUtil
                                                                              .isTablet
                                                                          ? 8.0
                                                                          : 2),
                                                                  child:
                                                                      Container(
                                                                    height: DeviceUtil
                                                                            .isTablet
                                                                        ? 75
                                                                        : 32,
                                                                    width: DeviceUtil
                                                                            .isTablet
                                                                        ? 75
                                                                        : 32,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border: Border.all(
                                                                            color:
                                                                                greyColor),
                                                                        borderRadius: BorderRadius.circular(DeviceUtil.isTablet
                                                                            ? 15
                                                                            : 9)),
                                                                    child: Center(
                                                                        child: Text(
                                                                      "0",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize: DeviceUtil.isTablet
                                                                              ? 35
                                                                              : 22),
                                                                    )),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      )),
                                                ],
                                              )
                                            ],
                                          ),
                                        ));
                                  });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Container(
                              height: 55,
                              decoration: BoxDecoration(
                                  color: pinkColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Center(
                                  child: FittedBox(
                                    child: Text(
                                      isParentMode
                                          ? "شاشة الطفل"
                                          : "صلاحية التعديل",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          );
  }

  setpass(int num, int n1, int n2, int n3, int n4, bool isDelete) {
    int a = -1;
    if (Provider.of<MyProvider>(context, listen: false).pass1 == -1) {
      if (isDelete) {
      } else {
        Provider.of<MyProvider>(context, listen: false).incPass1(num);
      }
    } else if (Provider.of<MyProvider>(context, listen: false).pass2 == -1) {
      if (isDelete) {
        Provider.of<MyProvider>(context, listen: false).incPass1(-1);
      } else {
        Provider.of<MyProvider>(context, listen: false).incPass2(num);
      }
    } else if (Provider.of<MyProvider>(context, listen: false).pass3 == -1) {
      if (isDelete) {
        Provider.of<MyProvider>(context, listen: false).incPass2(-1);
      } else {
        Provider.of<MyProvider>(context, listen: false).incPass3(num);
      }
    } else if (Provider.of<MyProvider>(context, listen: false).pass4 == -1) {
      if (isDelete) {
        Provider.of<MyProvider>(context, listen: false).incPass3(-1);
      } else {
        Provider.of<MyProvider>(context, listen: false).incPass4(num);
        if (Provider.of<MyProvider>(context, listen: false).pass1 == n1 &&
            Provider.of<MyProvider>(context, listen: false).pass2 == n2 &&
            Provider.of<MyProvider>(context, listen: false).pass3 == n3 &&
            Provider.of<MyProvider>(context, listen: false).pass4 == n4) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainParentPage(index: 1)),
              (route) => false);
          a = 0;
          Provider.of<MyProvider>(context, listen: false).seterror(false);
        }
        if (a == -1) {
          Provider.of<MyProvider>(context, listen: false).seterror(true);
        }
        Provider.of<MyProvider>(context, listen: false).incPass1(-1);
        Provider.of<MyProvider>(context, listen: false).incPass2(-1);
        Provider.of<MyProvider>(context, listen: false).incPass3(-1);
        Provider.of<MyProvider>(context, listen: false).incPass4(-1);
      }
    }
  }
}
