// ignore_for_file: use_build_context_synchronously

import 'dart:math';

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
import '/view/drawer/deleteaccount.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volume_controller/volume_controller.dart';

import '../../controller/erroralert.dart';
import '../../controller/removeallshared.dart';
import '../../controller/var.dart';

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
  bool isExpanded = false;
  bool isExpanded1 = false;
  bool isLoading = true;
  late bool isParentMode;
  late bool switchValue;
  ///////////////////

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
  }

  double fontSize = size == 0 ? 28 : 24;
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
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: Image.asset(
                              "assets/uiImages/logo.png",
                              height: 200,
                              width: 200,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 20,
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
                                        padding:
                                            const EdgeInsets.only(right: 20),
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
                                          button(() {
                                            Navigator.of(context).pop();
                                          }, 'لا، تراجع'),
                                          button(() {
                                            Navigator.of(context).pop();
                                            deleteAccount();
                                          }, 'نعم، أنا متأكد')
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
                                          backgroundColor: Colors.white,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(32.0))),
                                          title: Column(
                                            children: [
                                              InkWell(
                                                onTap: () =>
                                                    Navigator.pop(context),
                                                child: const Align(
                                                  alignment: Alignment.topRight,
                                                  child: Icon(
                                                    Icons.close,
                                                    size: 40,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: greyColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(32)),
                                                    child: Column(children: [
                                                      Container(
                                                        height: 17,
                                                      ),
                                                      Image.asset(
                                                        "assets/uiImages/lock.png",
                                                        height: 80,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15),
                                                        child: Text(
                                                          "الدخول للصلاحيات",
                                                          style: TextStyle(
                                                            fontSize: 30,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            color: pinkColor,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0,
                                                                right: 8,
                                                                bottom: 8),
                                                        child: Text(
                                                          "الرجاء إدخال الرمز التالي للدخول",
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: greyColor,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0,
                                                                right: 8,
                                                                bottom: 15),
                                                        child: Text(
                                                          text,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: greyColor,
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
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            child: Center(
                                                                child: Text(
                                                              Provider.of<MyProvider>(
                                                                              context)
                                                                          .pass4 ==
                                                                      -1
                                                                  ? ""
                                                                  : Provider.of<
                                                                              MyProvider>(
                                                                          context)
                                                                      .pass4
                                                                      .toString(),
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 35),
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
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            child: Center(
                                                                child: Text(
                                                              Provider.of<MyProvider>(
                                                                              context)
                                                                          .pass3 ==
                                                                      -1
                                                                  ? ""
                                                                  : Provider.of<
                                                                              MyProvider>(
                                                                          context)
                                                                      .pass3
                                                                      .toString(),
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 35),
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
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            child: Center(
                                                                child: Text(
                                                              Provider.of<MyProvider>(
                                                                              context)
                                                                          .pass2 ==
                                                                      -1
                                                                  ? ""
                                                                  : Provider.of<
                                                                              MyProvider>(
                                                                          context)
                                                                      .pass2
                                                                      .toString(),
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 35),
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
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            child: Center(
                                                                child: Text(
                                                              Provider.of<MyProvider>(
                                                                              context)
                                                                          .pass1 ==
                                                                      -1
                                                                  ? ""
                                                                  : Provider.of<
                                                                              MyProvider>(
                                                                          context)
                                                                      .pass1
                                                                      .toString(),
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 35),
                                                            )),
                                                          ),
                                                        ],
                                                      ),
                                                      Provider.of<MyProvider>(
                                                                  context,
                                                                  listen: true)
                                                              .errorpass
                                                          ? const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                "رمز خاطئ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                            )
                                                          : Container(),
                                                      Container(
                                                        height: 20,
                                                      ),
                                                    ]),
                                                  )),
                                                  Container(
                                                    width: 30,
                                                  ),
                                                  Expanded(
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
                                                              padding: EdgeInsets
                                                                  .all(DeviceUtil
                                                                          .isTablet
                                                                      ? 8.0
                                                                      : 2),
                                                              child: Container(
                                                                height: DeviceUtil
                                                                        .isTablet
                                                                    ? 75
                                                                    : 30,
                                                                width: DeviceUtil
                                                                        .isTablet
                                                                    ? 75
                                                                    : 30,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        color:
                                                                            greyColor),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                                child: Center(
                                                                    child: Text(
                                                                  "3",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize: DeviceUtil
                                                                              .isTablet
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
                                                              padding: EdgeInsets
                                                                  .all(DeviceUtil
                                                                          .isTablet
                                                                      ? 8.0
                                                                      : 2),
                                                              child: Container(
                                                                height: DeviceUtil
                                                                        .isTablet
                                                                    ? 75
                                                                    : 30,
                                                                width: DeviceUtil
                                                                        .isTablet
                                                                    ? 75
                                                                    : 30,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        color:
                                                                            greyColor),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                                child: Center(
                                                                    child: Text(
                                                                  "2",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize: DeviceUtil
                                                                              .isTablet
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
                                                              padding: EdgeInsets
                                                                  .all(DeviceUtil
                                                                          .isTablet
                                                                      ? 8.0
                                                                      : 2),
                                                              child: Container(
                                                                height: DeviceUtil
                                                                        .isTablet
                                                                    ? 75
                                                                    : 30,
                                                                width: DeviceUtil
                                                                        .isTablet
                                                                    ? 75
                                                                    : 30,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        color:
                                                                            greyColor),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                                child: Center(
                                                                    child: Text(
                                                                  "1",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize: DeviceUtil
                                                                              .isTablet
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
                                                              padding: EdgeInsets
                                                                  .all(DeviceUtil
                                                                          .isTablet
                                                                      ? 8.0
                                                                      : 2),
                                                              child: Container(
                                                                height: DeviceUtil
                                                                        .isTablet
                                                                    ? 75
                                                                    : 30,
                                                                width: DeviceUtil
                                                                        .isTablet
                                                                    ? 75
                                                                    : 30,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        color:
                                                                            greyColor),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                                child: Center(
                                                                    child: Text(
                                                                  "6",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize: DeviceUtil
                                                                              .isTablet
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
                                                              padding: EdgeInsets
                                                                  .all(DeviceUtil
                                                                          .isTablet
                                                                      ? 8.0
                                                                      : 2),
                                                              child: Container(
                                                                height: DeviceUtil
                                                                        .isTablet
                                                                    ? 75
                                                                    : 30,
                                                                width: DeviceUtil
                                                                        .isTablet
                                                                    ? 75
                                                                    : 30,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        color:
                                                                            greyColor),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                                child: Center(
                                                                    child: Text(
                                                                  "5",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize: DeviceUtil
                                                                              .isTablet
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
                                                              padding: EdgeInsets
                                                                  .all(DeviceUtil
                                                                          .isTablet
                                                                      ? 8.0
                                                                      : 2),
                                                              child: Container(
                                                                height: DeviceUtil
                                                                        .isTablet
                                                                    ? 75
                                                                    : 30,
                                                                width: DeviceUtil
                                                                        .isTablet
                                                                    ? 75
                                                                    : 30,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        color:
                                                                            greyColor),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                                child: Center(
                                                                    child: Text(
                                                                  "4",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize: DeviceUtil
                                                                              .isTablet
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
                                                              padding: EdgeInsets
                                                                  .all(DeviceUtil
                                                                          .isTablet
                                                                      ? 8.0
                                                                      : 2),
                                                              child: Container(
                                                                height: DeviceUtil
                                                                        .isTablet
                                                                    ? 75
                                                                    : 30,
                                                                width: DeviceUtil
                                                                        .isTablet
                                                                    ? 75
                                                                    : 30,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        color:
                                                                            greyColor),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                                child: Center(
                                                                    child: Text(
                                                                  "9",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize: DeviceUtil
                                                                              .isTablet
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
                                                              padding: EdgeInsets
                                                                  .all(DeviceUtil
                                                                          .isTablet
                                                                      ? 8.0
                                                                      : 2),
                                                              child: Container(
                                                                height: DeviceUtil
                                                                        .isTablet
                                                                    ? 75
                                                                    : 30,
                                                                width: DeviceUtil
                                                                        .isTablet
                                                                    ? 75
                                                                    : 30,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        color:
                                                                            greyColor),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                                child: Center(
                                                                    child: Text(
                                                                  "8",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize: DeviceUtil
                                                                              .isTablet
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
                                                              padding: EdgeInsets
                                                                  .all(DeviceUtil
                                                                          .isTablet
                                                                      ? 8.0
                                                                      : 2),
                                                              child: Container(
                                                                height: DeviceUtil
                                                                        .isTablet
                                                                    ? 75
                                                                    : 30,
                                                                width: DeviceUtil
                                                                        .isTablet
                                                                    ? 75
                                                                    : 30,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        color:
                                                                            greyColor),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                                child: Center(
                                                                    child: Text(
                                                                  "7",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize: DeviceUtil
                                                                              .isTablet
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
                                                              setpass(0, n1, n2,
                                                                  n3, n4, true);
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 15,
                                                                      right:
                                                                          15),
                                                              child: Container(
                                                                  height: DeviceUtil
                                                                          .isTablet
                                                                      ? 60
                                                                      : 25,
                                                                  width: DeviceUtil
                                                                          .isTablet
                                                                      ? 60
                                                                      : 25,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    image: DecorationImage(
                                                                        image: AssetImage(
                                                                            "assets/uiImages/delete.png"),
                                                                        matchTextDirection:
                                                                            true),
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
                                                              padding: EdgeInsets
                                                                  .all(DeviceUtil
                                                                          .isTablet
                                                                      ? 8.0
                                                                      : 2),
                                                              child: Container(
                                                                height: DeviceUtil
                                                                        .isTablet
                                                                    ? 75
                                                                    : 30,
                                                                width: DeviceUtil
                                                                        .isTablet
                                                                    ? 75
                                                                    : 30,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        color:
                                                                            greyColor),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                                child: Center(
                                                                    child: Text(
                                                                  "0",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize: DeviceUtil
                                                                              .isTablet
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
                  builder: (context) => const MainParentPage(index: 0)),
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
