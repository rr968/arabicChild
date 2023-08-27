// ignore_for_file: file_names

import 'dart:convert';

import 'package:arabic_speaker_child/childpage/child/speakingchildphone.dart';
import 'package:arabic_speaker_child/controller/istablet.dart';
import 'package:arabic_speaker_child/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

import '../../controller/Rating_view.dart';
import '../../controller/checkinternet.dart';
import '../../controller/erroralert.dart';
import '../../controller/harakatPrediction.dart';
import '../../model/content.dart';
import '../../model/filesContent.dart';
import '../../model/library.dart';
import '../../pay/deviceinfo.dart';
import '../../pay/pay.dart';
import '../../view/block_user.dart';
import '/childpage/child/favoriteChildren.dart';
import '/childpage/child/speakingchildtablet.dart';
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
  bool loading = true;
  bool loading2 = true;
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;

  int _selectedItemPosition = 1;
  Color selectedColor = pinkColor;
  final _pageController = PageController(initialPage: 1);
  List<Widget> screens = [
    const FavoriteChildren(),
    DeviceUtil.isTablet
        ? const SpeakingChildTablet()
        : const SpeakingChildPhone(),
    DeviceUtil.isTablet
        ? const SpeakingChildTablet()
        : const SpeakingChildPhone(),
  ];
  late int indexpage;

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
    checkIfBlockedUser();
    internetConnection().then((value) async {
      if (value) {
        SharedPreferences isRating = await SharedPreferences.getInstance();
        String IsR = isRating.getString("israting") ?? "false";

        IsR == "true" ? "" : openDilogRating(context);
      }
    });
    ///////pay
    internetConnection().then((value) {
      if (value) {
        initPlatformState().then((value) {
          String d = "${value[0]}${value[1]}";
          FirebaseFirestore.instance
              .collection("payChildApp")
              .doc("mi63rhuIAw1hKJDnLNwx")
              .get()
              .then((value) {
            if (value.data() != null) {
              if (value.data()![d] != null) {
                Timestamp v = value.data()![d];
                if (v.toDate().isBefore(DateTime.now())) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return WillPopScope(
                        onWillPop: () async {
                          // Disable the back button functionality
                          return false;
                        },
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: AlertDialog(
                            title: const Text("لقد انتهى الاشتراك الخاص بك"),
                            content:
                                const Text("قيمة الاشتراك السنوي ٤٩ ريال "),
                            actions: [
                              TextButton(
                                child: const Text(
                                  "اشتراك",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  //  if (Platform.isAndroid) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PaymentViewScreen(amount: 49)));
                                  // }   /*else {*/
                                  /*    PayModel data = await MoyasarPayment().applePay(
                                      amount: 49,
                                      publishableKey:
                                          "pk_live_5HcCv9pGLqGGttnHj95LrTntgqphFMmn2Fop35dk",
                                      applepayMerchantId:
                                          "merchant.sa.org.tawasal.store",
                                      paymentItems: {' ': 49},
                                      currencyCode: "SAR",
                                      countryCode: "SA",
                                      description: "تحدث");

                                  if (data.status == 'paid') {
                                    internetConnection().then((value) {
                                      if (value) {
                                        initPlatformState().then((value) {
                                          try {
                                            FirebaseFirestore.instance
                                                .collection("payChildApp")
                                                .doc("mi63rhuIAw1hKJDnLNwx")
                                                .set({
                                              "${value[0]}${value[1]}":
                                                  DateTime.now().add(
                                                      const Duration(days: 365))
                                            }, SetOptions(merge: true));
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const MainChildPage(
                                                  index: 0,
                                                ),
                                              ),
                                            );
                                          } catch (_) {}
                                        });
                                      }
                                    });
                                  }*/
                                  // }
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }
            }
          });
        });
      }
    });

    ///////end pay
    indexpage = widget.index;

    getData().then((val) {
      setState(() {
        loading = false;
      });
    });
    getworddata().then((val) {
      setState(() {
        loading2 = false;
      });
    });

    getVoice();
    getfemail();
    setparentmode();

    super.initState();
  }

  getworddata() async {
    librarywordChild = [];
    SharedPreferences liblistwordChild = await SharedPreferences.getInstance();
    List<String>? libraryword = liblistwordChild.getStringList("wordListChild");
    if (libraryword != null) {
      for (String element in libraryword) {
        List e = json.decode(element);
        List<Content> contentwordlist = [];
        for (List l in e[3]) {
          contentwordlist.add(Content(l[0], l[1], l[2], l[3], l[4], l[5]));
        }
        librarywordChild.add(lib(e[0], e[1], e[2], contentwordlist));
      }
    } else {
      librarywordChild = wordLib;
    }
  }

  getData() async {
    dataImage = dataIfNoData;
    harakatWord = harakatIfNoData;
    /* SharedPreferences pref = await SharedPreferences.getInstance();
    var a = pref.getString("PredictionData");

    if (a == null) {
      dataImage = dataIfNoData;
    } else {
      dataImage = List<List>.from(json.decode(a));
    }

    var harakat = pref.getString("Harakat");

    if (harakat == null) {
      harakatWord = harakatIfNoData;
    } else {
      harakatWord = List<List>.from(json.decode(harakat));
    }*/
  }

  getVoice() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      size = pref.getInt("size") ?? 1;
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

  getCurrentSpeakSpeed() async {
    SharedPreferences currentSpeed = await SharedPreferences.getInstance();
    var f = currentSpeed.getInt("CurrentSpeakSpeed");
    if (f == null) {
      setState(() {
        currentSpeakSpead = 1;
      });
    } else {
      setState(() {
        currentSpeakSpead = f;
      });
    }
  }

  setparentmode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setBool("isParentMode", false);
  }

  checkIfBlockedUser() async {
    try {
      var blockedEmails = await FirebaseFirestore.instance
          .collection("blockedEmails")
          .doc("CFpjKa35zNa83PaQDtRU")
          .get();

      Map<String, dynamic> data = blockedEmails.data() ?? {};
      List userDatablocked =
          json.decode(data[FirebaseAuth.instance.currentUser!.email]) ?? [];
      if (userDatablocked.isNotEmpty) {
        if (userDatablocked[0] == "1" && userDatablocked[1] == "false") {
          data[FirebaseAuth.instance.currentUser!.email.toString()] =
              """["1","true"]""";
          await FirebaseFirestore.instance
              .collection("blockedEmails")
              .doc("CFpjKa35zNa83PaQDtRU")
              .set(data);
          blockAlert(context, 1);
        } else if (userDatablocked[0] == "2" && userDatablocked[1] == "false") {
          data[FirebaseAuth.instance.currentUser!.email.toString()] =
              """["2","true"]""";
          await FirebaseFirestore.instance
              .collection("blockedEmails")
              .doc("CFpjKa35zNa83PaQDtRU")
              .set(data);
          blockAlert(context, 2);
        } else if (userDatablocked[0] == "3") {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => blockedUser(context)),
              (route) => false);
        }
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: loading || loading2
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : PageView(
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
            backgroundColor: const Color.fromARGB(255, 245, 236, 244),
            behaviour: snakeBarStyle,
            snakeShape: SnakeShape.circle,
            shape: const RoundedRectangleBorder(
              borderRadius: /*BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))*/
                  BorderRadius.all(Radius.circular(25)),
            ),
            padding: EdgeInsets.only(
                bottom: DeviceUtil.isTablet ? 5 : 0, right: 20, left: 20),
            snakeViewColor: selectedColor,
            selectedItemColor: SnakeShape.circle == SnakeShape.indicator
                ? selectedColor
                : null,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            height: DeviceUtil.isTablet ? 56 : 50,
            currentIndex: _selectedItemPosition,
            onTap: (index) {
              if (index == 2) {
                setState(() {
                  _selectedItemPosition = index;
                });
                Future.delayed(const Duration(milliseconds: 1000))
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

  openDilogRating(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: RatingView(),
          );
        });
  }
}
