// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:arabic_speaker_child/controller/harakatPrediction.dart';
import 'package:arabic_speaker_child/controller/realtime.dart';
import 'package:arabic_speaker_child/data.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../controller/erroralert.dart';
import '../../controller/my_provider.dart';
import '/childpage/constant.dart';
import '/controller/images.dart';
import '/controller/speak.dart';
import '/controller/uploaddataChild.dart';
import '/controller/var.dart';
import '/model/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/content.dart';

class SpeakingChildTablet extends StatefulWidget {
  const SpeakingChildTablet({super.key});

  @override
  State<SpeakingChildTablet> createState() => _SpeakingChildTabletState();
}

class _SpeakingChildTabletState extends State<SpeakingChildTablet> {
  int coloredOpenLibraryindex = 0;
  double _scrollOffset = 0;
  List<List<List<String>>> constant = [
    [
      ["أنا", getImageWord("أنا")],
      ["هل", getImageWord("هل")],
      ["كم", getImageWord("كم")],
      ["متى", getImageWord("متى")],
      ["أين", getImageWord("أين")],
      ["بكم", getImageWord("بكم")],
      ["هذا", getImageWord("هذا")],
      ["أبغى", getImageWord("أبغى")],
      ["كيف", getImageWord("كيف")],
      ["طيب", getImageWord("طيب")],
      ["عندي", getImageWord("عندي")],
      ["شكرا", getImageWord("شكرا")],
      ["السلام", getImageWord("السلام")],
      ["لكن", getImageWord("لكن")],
      ["ممكن", getImageWord("ممكن")],
      ["لو", getImageWord("لو")],
    ],
    [
      ["أستطيع", getImageWord("أستطيع")],
      ["أشتري", getImageWord("أشتري")],
      ["أريد", getImageWord("أريد")],
      ["أحب", getImageWord("أحب")],
      ["أشعر", getImageWord("أشعر")],
      ["أعمل", getImageWord("أعمل")],
      ["أرى", getImageWord("أرى")],
      ["أروح", getImageWord("أروح")],
      ["أدرس", getImageWord("أدرس")],
      ["ألعب", getImageWord("ألعب")],
      ["أعطني", getImageWord("أعطني")],
      ["ألبس", getImageWord("ألبس")],
      ["أنام", getImageWord("أنام")],
      ["اتألم", getImageWord("اتألم")],
      ["أتحرك", getImageWord("أتحرك")],
      ["أمشي", getImageWord("أمشي")],
    ],
    [
      ["من", getImageWord("من")],
      ["إلى", getImageWord("إلى")],
      ["عن", getImageWord("عن")], //
      ["على", getImageWord("على")], //
      ["في", getImageWord("في")], //
      ["لم", getImageWord("لم")], //
      ["لا", getImageWord("لا")], //
      ["قد", getImageWord("قد")], //
      ["إلا", getImageWord("إلا")], //
      ["بلى", getImageWord("بلى")], //
      ["حتى", getImageWord("حتى")], //
      ["لن", getImageWord("لن")], //
      ["لما", getImageWord("لما")], //
      ["ما", getImageWord("ما")], //
      ["ثم", getImageWord("ثم")], //
      ["و", getImageWord("و")], //
    ],
    [
      ["سعيد", getImageWord("سعيد")],
      ["حزين", getImageWord("حزين")],
      ["جوعان", getImageWord("جوعان")],
      ["عطشان", getImageWord("عطشان")],
      ["خائف", getImageWord("خائف")],
      ["رائع", getImageWord("رائع")],
      ["جميل", getImageWord("جميل")],
      ["سهل", getImageWord("سهل")],
      ["صعب", getImageWord("صعب")],
      ["سريع", getImageWord("سريع")],
      ["بطيء", getImageWord("بطيء")],
      ["تعبان", getImageWord("تعبان")],
      ["طويل", getImageWord("طويل")],
      ["قصير", getImageWord("قصير")],
      ["جيد", getImageWord("جيد")],
      ["سيء", getImageWord("سيء")],
    ],
  ];
  late List<List<String>> predictionWords;
  List<Content> fieldContent = [];
  List<Content> contentWord = [];
  List<String> LocalDB = [];
  List<String> fav = [];
  TextEditingController controller = TextEditingController();
  final controllerList = ScrollController();
  final contentWordController = ScrollController();
  double currentOffsetScroll = 0;
  bool isLoading = true;
  bool isFav = false;
  late bool speakingWordByWord;
  bool isLess = false;
  late int size;

  @override
  void initState() {
    contentWordController.addListener(() {
      double v = contentWordController.offset / (fieldContent.length * 50);
      setState(() {
        _scrollOffset = v < 0
            ? 0
            : v >= 1
                ? 1
                : v;
      });
    });
    predictionWords = pred;
    getFavData();
    getLocalDB();
    getdata().then((v) {
      contentWord =
          libraryListChild.isNotEmpty ? libraryListChild[0].contenlist : [];
      setState(() {
        isLoading = false;
      });
    });
    tryUploadDataChild();
    super.initState();
  }

  getdata() async {
    libraryListChild = [];
    SharedPreferences liblistChild = await SharedPreferences.getInstance();
    size = liblistChild.getInt("size") ?? 1;

    List<String>? library = liblistChild.getStringList("liblistChild");
    if (library != null) {
      for (String element in library) {
        List e = json.decode(element);
        List<Content> contentlist = [];
        for (List l in e[3]) {
          contentlist.add(Content(l[0], l[1], l[2], l[3], l[4], l[5]));
        }
        libraryListChild.add(lib(e[0], e[1], e[2], contentlist));
      }
    }
    speakingWordByWord = liblistChild.getBool("switchValue") ?? true;
  }

  getFavData() async {
    SharedPreferences favlist = await SharedPreferences.getInstance();
    var tem = favlist.getStringList("favlistChild");
    if (tem != null) {
      for (var element in tem) {
        List test = json.decode(element);
        String a = "";
        for (var element2 in test) {
          a += element2[0] + " ";
        }
        fav.add(a.trim());
      }
    }
  }

  getLocalDB() async {
    SharedPreferences LocalChild = await SharedPreferences.getInstance();
    List list = LocalChild.getStringList("LocalChild") ?? [];
    for (var element in list) {
      LocalDB.add(element);
    }
  }

  store_In_local(String Text) async {
    Text = Text.trim();
    Text = Text.replaceAll("  ", " ");
    SharedPreferences localChild = await SharedPreferences.getInstance();
    if (!LocalDB.contains(Text)) {
      LocalDB.add(Text);
      localChild.setStringList("LocalChild", LocalDB);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          extendBodyBehindAppBar: true,
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  children: [
                    //appbar
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 22, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => Scaffold.of(context).openDrawer(),
                            child: Image.asset(
                              "assets/uiImages/drawer.png",
                              height: 40,
                            ),
                          ),
                          Text(
                            "اختر الكلمات",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size == 0 ? 44 : 40,
                                color: pinkColor),
                          ),
                          Text(
                            "         ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: pinkColor),
                          )
                        ],
                      ),
                    ),
                    ////////////
                    SizedBox(
                      height: MediaQuery.of(context).orientation !=
                              Orientation.portrait
                          ? MediaQuery.of(context).size.height -
                              80 -
                              MediaQuery.of(context).size.height * .09
                          : MediaQuery.of(context).size.height -
                              80 -
                              MediaQuery.of(context).size.height * .07,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                          child: Padding(
                        padding: EdgeInsets.only(
                          top: size == 0 ? 3 : 10,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 15, left: 15),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      bool t = Provider.of<MyProvider>(context,
                                              listen: false)
                                          .isSpeakingNow;
                                      if (!t) {
                                        if (controller.text.trim().isNotEmpty) {
                                          setState(() {
                                            fieldContent.add(Content(
                                                controller.text.trim(),
                                                "",
                                                "yes",
                                                "",
                                                "",
                                                "yes"));
                                          });
                                          contentWordController.animateTo(
                                              contentWordController
                                                  .position.maxScrollExtent,
                                              duration: const Duration(
                                                  milliseconds: 750),
                                              curve: Curves.easeOut);

                                          controller.clear();
                                        }
                                        //speak
                                        String a = "";
                                        for (var element in fieldContent) {
                                          a += "${element.name} ";
                                        }

                                        if (fav.contains(a.trim())) {
                                          setState(() {
                                            isFav = true;
                                          });
                                        } else {
                                          setState(() {
                                            isFav = false;
                                          });
                                        }
                                        if (controller.text.trim().isNotEmpty) {
                                          predict(a
                                              .replaceAll("أ", "ا")
                                              .replaceAll("إ", "ا")
                                              .replaceAll("ة", "ه"));
                                        }
                                        howtospeak(a, context);
                                        store_In_local(a);
                                        tryUploadToRealTimeForChild(a);
                                      }
                                    },
                                    child: Container(
                                        height: size == 0 ? 140 : 130,
                                        width: 65,
                                        decoration: BoxDecoration(
                                          color: Provider.of<MyProvider>(
                                                      context,
                                                      listen: true)
                                                  .isSpeakingNow
                                              ? pinkColor.withOpacity(.6)
                                              : pinkColor,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                                spreadRadius: 3,
                                                blurRadius: 5,
                                                offset: const Offset(0, 3)),
                                          ],
                                          border: Border.all(
                                            width: 2,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/uiImages/volume.png",
                                              height: 45,
                                              color: Colors.white,
                                            ),
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(top: 8.0),
                                              child: Text(
                                                "نطق",
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                  Container(
                                    width: 7,
                                  ),
                                  Expanded(
                                      child: Container(
                                    height: size == 0 ? 150 : 140,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffe9edf3),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(27)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 3,
                                            blurRadius: 5,
                                            offset: const Offset(0, 3)),
                                      ],
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.all(size == 0 ? 3 : 7),
                                      child: Row(
                                        children: [
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: InkWell(
                                              onTap: () {
                                                // clear
                                                if (fieldContent.isNotEmpty) {
                                                  if (fieldContent.length ==
                                                      1) {
                                                    setState(() {
                                                      fieldContent = [];
                                                      isFav = false;
                                                      predictionWords = [
                                                        [
                                                          "انا",
                                                          getImageWord("انا")
                                                        ],
                                                        [
                                                          "هل",
                                                          getImageWord("هل")
                                                        ],
                                                        [
                                                          "كم",
                                                          getImageWord("كم")
                                                        ],
                                                        [
                                                          "متى",
                                                          getImageWord("متى")
                                                        ],
                                                        [
                                                          "اين",
                                                          getImageWord("اين")
                                                        ],
                                                        [
                                                          "بكم",
                                                          getImageWord("بكم")
                                                        ],
                                                        [
                                                          "هذا",
                                                          getImageWord("هذا")
                                                        ],
                                                        [
                                                          "أبغى",
                                                          getImageWord("أبغى")
                                                        ],
                                                        [
                                                          "كيف",
                                                          getImageWord("كيف")
                                                        ],
                                                        [
                                                          "طيب",
                                                          getImageWord("طيب")
                                                        ],
                                                        [
                                                          "عندي",
                                                          getImageWord("عندي")
                                                        ],
                                                        [
                                                          "شكرا",
                                                          getImageWord("شكرا")
                                                        ],
                                                        [
                                                          "السلام",
                                                          getImageWord("السلام")
                                                        ],
                                                        [
                                                          "لكن",
                                                          getImageWord("لكن")
                                                        ],
                                                        [
                                                          "ممكن",
                                                          getImageWord("ممكن")
                                                        ],
                                                        [
                                                          "لو",
                                                          getImageWord("لو")
                                                        ],
                                                      ];
                                                    });
                                                  } else {
                                                    setState(() {
                                                      fieldContent.removeAt(
                                                          fieldContent.length -
                                                              1);
                                                    });
                                                    String text = "";
                                                    for (var element
                                                        in fieldContent) {
                                                      text +=
                                                          "${element.name} ";
                                                    }
                                                    predict(text
                                                        .replaceAll("أ", "ا")
                                                        .replaceAll("إ", "ا")
                                                        .replaceAll("ة", "ه"));
                                                    if (fav.contains(
                                                        text.trim())) {
                                                      setState(() {
                                                        isFav = true;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        isFav = false;
                                                      });
                                                    }
                                                  }
                                                }
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Image.asset(
                                                  "assets/uiImages/delete.png",
                                                  height: size == 0 ? 42 : 38,
                                                  matchTextDirection: true,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: SizedBox(
                                              height: 140,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: ListView(
                                                      controller:
                                                          contentWordController,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      children: [
                                                        for (int i = 0;
                                                            i <
                                                                fieldContent
                                                                    .length;
                                                            i++)
                                                          fieldContent[i]
                                                                  .imgurl
                                                                  .isEmpty
                                                              ? FittedBox(
                                                                  child: Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        const SizedBox(
                                                                          height:
                                                                              110,
                                                                          width:
                                                                              110,
                                                                        ),
                                                                        Text(
                                                                          fieldContent[i]
                                                                              .name,
                                                                          style: TextStyle(
                                                                              fontSize: 40,
                                                                              fontWeight: FontWeight.w900,
                                                                              color: pinkColor),
                                                                        )
                                                                      ]),
                                                                )
                                                              : FittedBox(
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            12),
                                                                    child: Column(
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                110,
                                                                            width:
                                                                                110,
                                                                            child:
                                                                                getImage(fieldContent[i].imgurl),
                                                                          ),
                                                                          Text(
                                                                            fieldContent[i].name,
                                                                            style: TextStyle(
                                                                                fontSize: 40,
                                                                                fontWeight: FontWeight.w900,
                                                                                color: pinkColor),
                                                                          )
                                                                        ]),
                                                                  ),
                                                                ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 15),
                                                          child: SizedBox(
                                                            height: 140,
                                                            width: 300,
                                                            child: Center(
                                                              child: TextField(
                                                                controller:
                                                                    controller,
                                                                cursorColor:
                                                                    pinkColor,
                                                                onTap: () {
                                                                  controller.selection = TextSelection.fromPosition(TextPosition(
                                                                      offset: controller
                                                                          .text
                                                                          .trim()
                                                                          .length));
                                                                },
                                                                onChanged:
                                                                    (v) async {
                                                                  if (v
                                                                      .trim()
                                                                      .isNotEmpty) {
                                                                    autoComplete(
                                                                        v);
                                                                  } else if (v
                                                                          .trim()
                                                                          .isEmpty &&
                                                                      fieldContent
                                                                          .isNotEmpty) {
                                                                    predict(fieldContent[
                                                                            fieldContent.length -
                                                                                1]
                                                                        .name);
                                                                  } else if (fieldContent
                                                                          .isEmpty &&
                                                                      v
                                                                          .trim()
                                                                          .isEmpty) {
                                                                    setState(
                                                                        () {
                                                                      predictionWords =
                                                                          [
                                                                        [
                                                                          "انا",
                                                                          getImageWord(
                                                                              "انا")
                                                                        ],
                                                                        [
                                                                          "هل",
                                                                          getImageWord(
                                                                              "هل")
                                                                        ],
                                                                        [
                                                                          "كم",
                                                                          getImageWord(
                                                                              "كم")
                                                                        ],
                                                                        [
                                                                          "متى",
                                                                          getImageWord(
                                                                              "متى")
                                                                        ],
                                                                        [
                                                                          "اين",
                                                                          getImageWord(
                                                                              "اين")
                                                                        ],
                                                                        [
                                                                          "بكم",
                                                                          getImageWord(
                                                                              "بكم")
                                                                        ],
                                                                        [
                                                                          "هذا",
                                                                          getImageWord(
                                                                              "هذا")
                                                                        ],
                                                                        [
                                                                          "أبغى",
                                                                          getImageWord(
                                                                              "أبغى")
                                                                        ],
                                                                        [
                                                                          "كيف",
                                                                          getImageWord(
                                                                              "كيف")
                                                                        ],
                                                                        [
                                                                          "طيب",
                                                                          getImageWord(
                                                                              "طيب")
                                                                        ],
                                                                        [
                                                                          "عندي",
                                                                          getImageWord(
                                                                              "عندي")
                                                                        ],
                                                                        [
                                                                          "شكرا",
                                                                          getImageWord(
                                                                              "شكرا")
                                                                        ],
                                                                        [
                                                                          "السلام",
                                                                          getImageWord(
                                                                              "السلام")
                                                                        ],
                                                                        [
                                                                          "لكن",
                                                                          getImageWord(
                                                                              "لكن")
                                                                        ],
                                                                        [
                                                                          "ممكن",
                                                                          getImageWord(
                                                                              "ممكن")
                                                                        ],
                                                                        [
                                                                          "لو",
                                                                          getImageWord(
                                                                              "لو")
                                                                        ],
                                                                      ];
                                                                    });
                                                                  }
                                                                },
                                                                cursorWidth: 4,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        35,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900),
                                                                decoration:
                                                                    const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 20,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                            height: 10,
                                                            width: 250,
                                                            child: fieldContent
                                                                        .length >=
                                                                    6
                                                                ? SliderTheme(
                                                                    data: SliderTheme.of(
                                                                            context)
                                                                        .copyWith(
                                                                      activeTrackColor: const Color
                                                                              .fromARGB(
                                                                          255,
                                                                          114,
                                                                          114,
                                                                          114),
                                                                      inactiveTrackColor: const Color.fromARGB(
                                                                              255,
                                                                              114,
                                                                              114,
                                                                              114)
                                                                          .withOpacity(
                                                                              .5),
                                                                      trackShape:
                                                                          const RectangularSliderTrackShape(),
                                                                      trackHeight:
                                                                          5,
                                                                      thumbColor: const Color
                                                                              .fromARGB(
                                                                          255,
                                                                          114,
                                                                          114,
                                                                          114),
                                                                      thumbShape:
                                                                          const RoundSliderThumbShape(
                                                                              enabledThumbRadius: 12),
                                                                      overlayColor: Colors
                                                                          .red
                                                                          .withAlpha(
                                                                              32),
                                                                      overlayShape:
                                                                          const RoundSliderOverlayShape(
                                                                              overlayRadius: 28.0),
                                                                    ),
                                                                    child: Slider(
                                                                        value: _scrollOffset,
                                                                        onChanged: ((value) {
                                                                          contentWordController.animateTo(
                                                                              contentWordController.position.maxScrollExtent * value,
                                                                              duration: const Duration(seconds: 1),
                                                                              curve: Curves.easeOut);
                                                                        })),
                                                                  )
                                                                : Container()),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .25,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                width: 15,
                                                              ),
                                                              InkWell(
                                                                onTap:
                                                                    () async {
                                                                  setState(() {
                                                                    isFav =
                                                                        false;
                                                                    fieldContent =
                                                                        [];

                                                                    predictionWords =
                                                                        [
                                                                      [
                                                                        "انا",
                                                                        getImageWord(
                                                                            "انا")
                                                                      ],
                                                                      [
                                                                        "هل",
                                                                        getImageWord(
                                                                            "هل")
                                                                      ],
                                                                      [
                                                                        "كم",
                                                                        getImageWord(
                                                                            "كم")
                                                                      ],
                                                                      [
                                                                        "متى",
                                                                        getImageWord(
                                                                            "متى")
                                                                      ],
                                                                      [
                                                                        "اين",
                                                                        getImageWord(
                                                                            "اين")
                                                                      ],
                                                                      [
                                                                        "بكم",
                                                                        getImageWord(
                                                                            "بكم")
                                                                      ],
                                                                      [
                                                                        "هذا",
                                                                        getImageWord(
                                                                            "هذا")
                                                                      ],
                                                                      [
                                                                        "أبغى",
                                                                        getImageWord(
                                                                            "أبغى")
                                                                      ],
                                                                      [
                                                                        "كيف",
                                                                        getImageWord(
                                                                            "كيف")
                                                                      ],
                                                                      [
                                                                        "طيب",
                                                                        getImageWord(
                                                                            "طيب")
                                                                      ],
                                                                      [
                                                                        "عندي",
                                                                        getImageWord(
                                                                            "عندي")
                                                                      ],
                                                                      [
                                                                        "شكرا",
                                                                        getImageWord(
                                                                            "شكرا")
                                                                      ],
                                                                      [
                                                                        "السلام",
                                                                        getImageWord(
                                                                            "السلام")
                                                                      ],
                                                                      [
                                                                        "لكن",
                                                                        getImageWord(
                                                                            "لكن")
                                                                      ],
                                                                      [
                                                                        "ممكن",
                                                                        getImageWord(
                                                                            "ممكن")
                                                                      ],
                                                                      [
                                                                        "لو",
                                                                        getImageWord(
                                                                            "لو")
                                                                      ],
                                                                    ];
                                                                  });
                                                                  controller
                                                                      .clear();
                                                                },
                                                                child: SizedBox(
                                                                  height: 33,
                                                                  width: 33,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(0),
                                                                    child: Image
                                                                        .asset(
                                                                      "assets/uiImages/trash.png",
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: 15,
                                                              ),
                                                              InkWell(
                                                                onTap:
                                                                    () async {
                                                                  if (controller
                                                                      .text
                                                                      .trim()
                                                                      .isNotEmpty) {
                                                                    setState(
                                                                        () {
                                                                      fieldContent.add(Content(
                                                                          controller
                                                                              .text
                                                                              .trim(),
                                                                          "",
                                                                          "yes",
                                                                          "",
                                                                          "",
                                                                          "yes"));
                                                                    });

                                                                    controller
                                                                        .clear();
                                                                  }
                                                                  if (fieldContent
                                                                      .isNotEmpty) {
                                                                    //speak
                                                                    String
                                                                        text =
                                                                        "";
                                                                    for (var element
                                                                        in fieldContent) {
                                                                      text +=
                                                                          "${element.name} ";
                                                                    }
                                                                    if (controller
                                                                        .text
                                                                        .trim()
                                                                        .isNotEmpty) {
                                                                      predict(text
                                                                          .replaceAll(
                                                                              "أ",
                                                                              "ا")
                                                                          .replaceAll(
                                                                              "إ",
                                                                              "ا")
                                                                          .replaceAll(
                                                                              "ة",
                                                                              "ه"));
                                                                    }

                                                                    SharedPreferences
                                                                        favlist =
                                                                        await SharedPreferences
                                                                            .getInstance();
                                                                    if (!fav.contains(
                                                                        text.trim())) {
                                                                      setState(
                                                                          () {
                                                                        fav.add(
                                                                            text.trim());
                                                                        isFav =
                                                                            true;
                                                                      });

                                                                      String
                                                                          newFav =
                                                                          "";
                                                                      for (int y =
                                                                              0;
                                                                          y < fieldContent.length;
                                                                          y++) {
                                                                        String
                                                                            input =
                                                                            fieldContent[y].name;
                                                                        String
                                                                            imurl =
                                                                            fieldContent[y].imgurl;
                                                                        String
                                                                            isimup =
                                                                            fieldContent[y].isImageUpload;
                                                                        String
                                                                            voiceurl =
                                                                            fieldContent[y].opvoice;
                                                                        String
                                                                            voiceCache =
                                                                            fieldContent[y].cacheVoicePath;
                                                                        String
                                                                            isvoiceUp =
                                                                            fieldContent[y].isVoiceUpload;

                                                                        if (y ==
                                                                            fieldContent.length -
                                                                                1) {
                                                                          newFav +=
                                                                              """["$input","$imurl","$isimup","$voiceurl","$voiceCache","$isvoiceUp"]""";
                                                                        } else {
                                                                          newFav +=
                                                                              """["$input","$imurl","$isimup","$voiceurl","$voiceCache","$isvoiceUp"],""";
                                                                        }
                                                                      }
                                                                      newFav =
                                                                          "[$newFav]";
                                                                      List<String>
                                                                          favChildList =
                                                                          [];
                                                                      var temp =
                                                                          favlist
                                                                              .getStringList("favlistChild");
                                                                      if (temp ==
                                                                          null) {
                                                                        favChildList =
                                                                            [
                                                                          newFav
                                                                        ];
                                                                      } else {
                                                                        favChildList =
                                                                            temp;
                                                                        favChildList
                                                                            .add(newFav);
                                                                      }
                                                                      favlist.setStringList(
                                                                          "favlistChild",
                                                                          favChildList);
                                                                    } else {
                                                                      fav.remove(
                                                                          text.trim());
                                                                      setState(
                                                                          () {
                                                                        isFav =
                                                                            false;
                                                                      });
                                                                      List<String>
                                                                          v =
                                                                          favlist.getStringList("favlistChild") ??
                                                                              [];
                                                                      List
                                                                          favChild =
                                                                          [];
                                                                      for (var element
                                                                          in v) {
                                                                        favChild
                                                                            .add(json.decode(element));
                                                                      }
                                                                      favChild.removeWhere(
                                                                          (element) {
                                                                        if (element.length !=
                                                                            fieldContent.length) {
                                                                          return false;
                                                                        } else {
                                                                          bool
                                                                              sam =
                                                                              true;
                                                                          for (int o = 0;
                                                                              o < element.length;
                                                                              o++) {
                                                                            if (element[o][0] !=
                                                                                fieldContent[o].name) {
                                                                              sam = false;
                                                                            }
                                                                          }
                                                                          return sam;
                                                                        }
                                                                      });

                                                                      List<String>
                                                                          favString =
                                                                          convertFvaChildrenToString(
                                                                              favChild);
                                                                      favlist.setStringList(
                                                                          "favlistChild",
                                                                          favString);
                                                                    }
                                                                  } else {
                                                                    erroralert(
                                                                        context,
                                                                        "يرجى ملئ الحقل للاضافة الى المفضلة");
                                                                  }
                                                                },
                                                                child: SizedBox(
                                                                  height: 33,
                                                                  width: 33,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(0),
                                                                    child: isFav
                                                                        ? Image
                                                                            .asset(
                                                                            "assets/uiImages/star2.png",
                                                                            color:
                                                                                pinkColor,
                                                                            height:
                                                                                33,
                                                                          )
                                                                        : Image
                                                                            .asset(
                                                                            "assets/uiImages/star.png",
                                                                            height:
                                                                                33,
                                                                          ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: 15,
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  if (controller
                                                                      .text
                                                                      .trim()
                                                                      .isNotEmpty) {
                                                                    setState(
                                                                        () {
                                                                      fieldContent.add(Content(
                                                                          controller
                                                                              .text
                                                                              .trim(),
                                                                          "",
                                                                          "yes",
                                                                          "",
                                                                          "",
                                                                          "yes"));
                                                                    });
                                                                    contentWordController.animateTo(
                                                                        contentWordController
                                                                            .position
                                                                            .maxScrollExtent,
                                                                        duration: const Duration(
                                                                            milliseconds:
                                                                                750),
                                                                        curve: Curves
                                                                            .easeOut);

                                                                    controller
                                                                        .clear();
                                                                  }
                                                                  //speak
                                                                  String a = "";
                                                                  for (var element
                                                                      in fieldContent) {
                                                                    a +=
                                                                        "${element.name} ";
                                                                  }

                                                                  if (a
                                                                      .isNotEmpty) {
                                                                    Share.share(
                                                                        "متننت");
                                                                  } else {
                                                                    erroralert(
                                                                        context,
                                                                        "لا يمكن مشاركة حقل فارغ");
                                                                  }
                                                                },
                                                                child: SizedBox(
                                                                  height: 30,
                                                                  width: 30,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(0),
                                                                    child: Image
                                                                        .asset(
                                                                      "assets/uiImages/share.png",
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                            Expanded(
                                child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 15, left: 15),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, top: 8),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            border: Border.all(
                                                width: 2, color: greyColor)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5,
                                              left: 8,
                                              right: 8,
                                              bottom: 15),
                                          child:
                                              MediaQuery.of(context)
                                                          .orientation !=
                                                      Orientation.portrait
                                                  ? Column(
                                                      children: [
                                                        Expanded(
                                                            child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            predictionWords
                                                                    .isNotEmpty
                                                                ? box(0)
                                                                : const SizedBox(
                                                                    height: 140,
                                                                    width: 140,
                                                                  ),
                                                            predictionWords
                                                                        .length >=
                                                                    2
                                                                ? box(1)
                                                                : const SizedBox(
                                                                    height: 140,
                                                                    width: 140,
                                                                  ),
                                                            predictionWords
                                                                        .length >=
                                                                    3
                                                                ? box(2)
                                                                : const SizedBox(
                                                                    height: 140,
                                                                    width: 140,
                                                                  ),
                                                            predictionWords
                                                                        .length >=
                                                                    4
                                                                ? box(3)
                                                                : const SizedBox(
                                                                    height: 140,
                                                                    width: 140,
                                                                  ),
                                                            predictionWords
                                                                        .length >=
                                                                    5
                                                                ? box(4)
                                                                : const SizedBox(
                                                                    height: 140,
                                                                    width: 140,
                                                                  ),
                                                            InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  predictionWords =
                                                                      [
                                                                    [
                                                                      "سعيد",
                                                                      getImageWord(
                                                                          "سعيد")
                                                                    ],
                                                                    [
                                                                      "حزين",
                                                                      getImageWord(
                                                                          "حزين")
                                                                    ],
                                                                    [
                                                                      "جوعان",
                                                                      getImageWord(
                                                                          "جوعان")
                                                                    ],
                                                                    [
                                                                      "عطشان",
                                                                      getImageWord(
                                                                          "عطشان")
                                                                    ],
                                                                    [
                                                                      "خائف",
                                                                      getImageWord(
                                                                          "خائف")
                                                                    ],
                                                                    [
                                                                      "رائع",
                                                                      getImageWord(
                                                                          "رائع")
                                                                    ],
                                                                    [
                                                                      "جميل",
                                                                      getImageWord(
                                                                          "جميل")
                                                                    ],
                                                                    [
                                                                      "سهل",
                                                                      getImageWord(
                                                                          "سهل")
                                                                    ],
                                                                    [
                                                                      "صعب",
                                                                      getImageWord(
                                                                          "صعب")
                                                                    ],
                                                                    [
                                                                      "سريع",
                                                                      getImageWord(
                                                                          "سريع")
                                                                    ],
                                                                    [
                                                                      "بطيء",
                                                                      getImageWord(
                                                                          "بطيء")
                                                                    ],
                                                                    [
                                                                      "تعبان",
                                                                      getImageWord(
                                                                          "تعبان")
                                                                    ],
                                                                    [
                                                                      "طويل",
                                                                      getImageWord(
                                                                          "طويل")
                                                                    ],
                                                                    [
                                                                      "قصير",
                                                                      getImageWord(
                                                                          "قصير")
                                                                    ],
                                                                    [
                                                                      "جيد",
                                                                      getImageWord(
                                                                          "جيد")
                                                                    ],
                                                                    [
                                                                      "سيء",
                                                                      getImageWord(
                                                                          "سيء")
                                                                    ],
                                                                  ];
                                                                });
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            7),
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      size == 0
                                                                          ? 125
                                                                          : 120,
                                                                  decoration: BoxDecoration(
                                                                      color: const Color(
                                                                              0xff1367A2)
                                                                          .withOpacity(
                                                                              .6),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              30)),
                                                                  child:
                                                                      const Center(
                                                                    child: Text(
                                                                      "صفات",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              30),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  predictionWords =
                                                                      [
                                                                    [
                                                                      "أنا",
                                                                      getImageWord(
                                                                          "أنا")
                                                                    ],
                                                                    [
                                                                      "هل",
                                                                      getImageWord(
                                                                          "هل")
                                                                    ],
                                                                    [
                                                                      "كم",
                                                                      getImageWord(
                                                                          "كم")
                                                                    ],
                                                                    [
                                                                      "متى",
                                                                      getImageWord(
                                                                          "متى")
                                                                    ],
                                                                    [
                                                                      "أين",
                                                                      getImageWord(
                                                                          "أين")
                                                                    ],
                                                                    [
                                                                      "بكم",
                                                                      getImageWord(
                                                                          "بكم")
                                                                    ],
                                                                    [
                                                                      "هذا",
                                                                      getImageWord(
                                                                          "هذا")
                                                                    ],
                                                                    [
                                                                      "أبغى",
                                                                      getImageWord(
                                                                          "أبغى")
                                                                    ],
                                                                    [
                                                                      "كيف",
                                                                      getImageWord(
                                                                          "كيف")
                                                                    ],
                                                                    [
                                                                      "طيب",
                                                                      getImageWord(
                                                                          "طيب")
                                                                    ],
                                                                    [
                                                                      "عندي",
                                                                      getImageWord(
                                                                          "عندي")
                                                                    ],
                                                                    [
                                                                      "شكرا",
                                                                      getImageWord(
                                                                          "شكرا")
                                                                    ],
                                                                    [
                                                                      "السلام",
                                                                      getImageWord(
                                                                          "السلام")
                                                                    ],
                                                                    [
                                                                      "لكن",
                                                                      getImageWord(
                                                                          "لكن")
                                                                    ],
                                                                    [
                                                                      "ممكن",
                                                                      getImageWord(
                                                                          "ممكن")
                                                                    ],
                                                                    [
                                                                      "لو",
                                                                      getImageWord(
                                                                          "لو")
                                                                    ],
                                                                  ];
                                                                });
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            7),
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      size == 0
                                                                          ? 125
                                                                          : 120,
                                                                  decoration: BoxDecoration(
                                                                      color: const Color(
                                                                          0xffC06FB9),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              30)),
                                                                  child:
                                                                      const Center(
                                                                    child: Text(
                                                                      "كلمات مفتاحية",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              28),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )),
                                                        Container(
                                                          height: 7,
                                                        ),
                                                        !isLess && size != 0
                                                            ? Expanded(
                                                                child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  predictionWords
                                                                              .length >=
                                                                          6
                                                                      ? box(5)
                                                                      : const SizedBox(
                                                                          height:
                                                                              140,
                                                                          width:
                                                                              140,
                                                                        ),
                                                                  predictionWords
                                                                              .length >=
                                                                          7
                                                                      ? box(6)
                                                                      : const SizedBox(
                                                                          height:
                                                                              140,
                                                                          width:
                                                                              140,
                                                                        ),
                                                                  predictionWords
                                                                              .length >=
                                                                          8
                                                                      ? box(7)
                                                                      : const SizedBox(
                                                                          height:
                                                                              140,
                                                                          width:
                                                                              140,
                                                                        ),
                                                                  predictionWords
                                                                              .length >=
                                                                          9
                                                                      ? box(8)
                                                                      : const SizedBox(
                                                                          height:
                                                                              140,
                                                                          width:
                                                                              140,
                                                                        ),
                                                                  predictionWords
                                                                              .length >=
                                                                          10
                                                                      ? box(9)
                                                                      : const SizedBox(
                                                                          height:
                                                                              140,
                                                                          width:
                                                                              140,
                                                                        ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        predictionWords =
                                                                            [
                                                                          [
                                                                            "من",
                                                                            getImageWord("من")
                                                                          ],
                                                                          [
                                                                            "إلى",
                                                                            getImageWord("إلى")
                                                                          ],
                                                                          [
                                                                            "عن",
                                                                            getImageWord("عن")
                                                                          ],
                                                                          [
                                                                            "على",
                                                                            getImageWord("على")
                                                                          ],
                                                                          [
                                                                            "في",
                                                                            getImageWord("في")
                                                                          ],
                                                                          [
                                                                            "على",
                                                                            getImageWord("على")
                                                                          ],
                                                                          [
                                                                            "لم",
                                                                            getImageWord("لم")
                                                                          ],
                                                                          [
                                                                            "لا",
                                                                            getImageWord("لا")
                                                                          ],
                                                                          [
                                                                            "قد",
                                                                            getImageWord("قد")
                                                                          ],
                                                                          [
                                                                            "إلا",
                                                                            getImageWord("إلا")
                                                                          ],
                                                                          [
                                                                            "بلى",
                                                                            getImageWord("بلى")
                                                                          ],
                                                                          [
                                                                            "حتى",
                                                                            getImageWord("حتى")
                                                                          ],
                                                                          [
                                                                            "لن",
                                                                            getImageWord("لن")
                                                                          ],
                                                                          [
                                                                            "لما",
                                                                            getImageWord("لما")
                                                                          ],
                                                                          [
                                                                            "ما",
                                                                            getImageWord("ما")
                                                                          ],
                                                                          [
                                                                            "ثم",
                                                                            getImageWord("ثم")
                                                                          ],
                                                                          [
                                                                            "و",
                                                                            getImageWord("و")
                                                                          ],
                                                                        ];
                                                                      });
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              7),
                                                                      child:
                                                                          Container(
                                                                        width: size ==
                                                                                0
                                                                            ? 125
                                                                            : 120,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                const Color(0xffE9E467),
                                                                            borderRadius: BorderRadius.circular(30)),
                                                                        child:
                                                                            const Center(
                                                                          child:
                                                                              Text(
                                                                            "حروف",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                                fontSize: 30),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        predictionWords =
                                                                            [
                                                                          [
                                                                            "أستطيع",
                                                                            getImageWord("أستطيع")
                                                                          ],
                                                                          [
                                                                            "أشتري",
                                                                            getImageWord("أشتري")
                                                                          ],
                                                                          [
                                                                            "أريد",
                                                                            getImageWord("أريد")
                                                                          ],
                                                                          [
                                                                            "أحب",
                                                                            getImageWord("أحب")
                                                                          ],
                                                                          [
                                                                            "أشعر",
                                                                            getImageWord("أشعر")
                                                                          ],
                                                                          [
                                                                            "أعمل",
                                                                            getImageWord("أعمل")
                                                                          ],
                                                                          [
                                                                            "أرى",
                                                                            getImageWord("أرى")
                                                                          ],
                                                                          [
                                                                            "أروح",
                                                                            getImageWord("أروح")
                                                                          ],
                                                                          [
                                                                            "أدرس",
                                                                            getImageWord("أدرس")
                                                                          ],
                                                                          [
                                                                            "ألعب",
                                                                            getImageWord("ألعب")
                                                                          ],
                                                                          [
                                                                            "أعطني",
                                                                            getImageWord("أعطني")
                                                                          ],
                                                                          [
                                                                            "ألبس",
                                                                            getImageWord("ألبس")
                                                                          ],
                                                                          [
                                                                            "أنام",
                                                                            getImageWord("أنام")
                                                                          ],
                                                                          [
                                                                            "اتألم",
                                                                            getImageWord("اتألم")
                                                                          ],
                                                                          [
                                                                            "أتحرك",
                                                                            getImageWord("أتحرك")
                                                                          ],
                                                                          [
                                                                            "أمشي",
                                                                            getImageWord("أمشي")
                                                                          ],
                                                                        ];
                                                                      });
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              7),
                                                                      child:
                                                                          Container(
                                                                        width: size ==
                                                                                0
                                                                            ? 125
                                                                            : 120,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                const Color(0xffA7CB89),
                                                                            borderRadius: BorderRadius.circular(30)),
                                                                        child:
                                                                            const Center(
                                                                          child:
                                                                              Text(
                                                                            "أفعال",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.black,
                                                                                fontSize: 30),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ))
                                                            : Container(),
                                                      ],
                                                    )
                                                  : Column(
                                                      children: [
                                                        Container(
                                                          height:
                                                              size == 0 ? 0 : 5,
                                                        ),
                                                        Expanded(
                                                            child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            predictionWords
                                                                    .isNotEmpty
                                                                ? box(0)
                                                                : const SizedBox(
                                                                    height: 110,
                                                                    width: 110,
                                                                  ),
                                                            predictionWords
                                                                        .length >=
                                                                    2
                                                                ? box(1)
                                                                : const SizedBox(
                                                                    height: 140,
                                                                    width: 140,
                                                                  ),
                                                            predictionWords
                                                                        .length >=
                                                                    3
                                                                ? box(2)
                                                                : const SizedBox(
                                                                    height: 140,
                                                                    width: 140,
                                                                  ),
                                                            predictionWords
                                                                        .length >=
                                                                    4
                                                                ? box(3)
                                                                : const SizedBox(
                                                                    height: 140,
                                                                    width: 140,
                                                                  ),
                                                            InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  predictionWords =
                                                                      [
                                                                    [
                                                                      "أنا",
                                                                      getImageWord(
                                                                          "أنا")
                                                                    ],
                                                                    [
                                                                      "هل",
                                                                      getImageWord(
                                                                          "هل")
                                                                    ],
                                                                    [
                                                                      "كم",
                                                                      getImageWord(
                                                                          "كم")
                                                                    ],
                                                                    [
                                                                      "متى",
                                                                      getImageWord(
                                                                          "متى")
                                                                    ],
                                                                    [
                                                                      "أين",
                                                                      getImageWord(
                                                                          "أين")
                                                                    ],
                                                                    [
                                                                      "بكم",
                                                                      getImageWord(
                                                                          "بكم")
                                                                    ],
                                                                    [
                                                                      "هذا",
                                                                      getImageWord(
                                                                          "هذا")
                                                                    ],
                                                                    [
                                                                      "أبغى",
                                                                      getImageWord(
                                                                          "أبغى")
                                                                    ],
                                                                    [
                                                                      "كيف",
                                                                      getImageWord(
                                                                          "كيف")
                                                                    ],
                                                                    [
                                                                      "طيب",
                                                                      getImageWord(
                                                                          "طيب")
                                                                    ],
                                                                    [
                                                                      "عندي",
                                                                      getImageWord(
                                                                          "عندي")
                                                                    ],
                                                                    [
                                                                      "شكرا",
                                                                      getImageWord(
                                                                          "شكرا")
                                                                    ],
                                                                    [
                                                                      "السلام",
                                                                      getImageWord(
                                                                          "السلام")
                                                                    ],
                                                                    [
                                                                      "لكن",
                                                                      getImageWord(
                                                                          "لكن")
                                                                    ],
                                                                    [
                                                                      "ممكن",
                                                                      getImageWord(
                                                                          "ممكن")
                                                                    ],
                                                                    [
                                                                      "لو",
                                                                      getImageWord(
                                                                          "لو")
                                                                    ],
                                                                  ];
                                                                });
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            7),
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      size == 0
                                                                          ? 133
                                                                          : 120,
                                                                  decoration: BoxDecoration(
                                                                      color: const Color(
                                                                          0xffC06FB9),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              30)),
                                                                  child:
                                                                      const Center(
                                                                    child: Text(
                                                                      "كلمات مفتاحية",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              28),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )),
                                                        Container(
                                                          height: 7,
                                                        ),
                                                        Expanded(
                                                            child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            predictionWords
                                                                        .length >=
                                                                    5
                                                                ? box(4)
                                                                : const SizedBox(
                                                                    height: 140,
                                                                    width: 140,
                                                                  ),
                                                            predictionWords
                                                                        .length >=
                                                                    6
                                                                ? box(5)
                                                                : const SizedBox(
                                                                    height: 140,
                                                                    width: 140,
                                                                  ),
                                                            predictionWords
                                                                        .length >=
                                                                    7
                                                                ? box(6)
                                                                : const SizedBox(
                                                                    height: 140,
                                                                    width: 140,
                                                                  ),
                                                            predictionWords
                                                                        .length >=
                                                                    8
                                                                ? box(7)
                                                                : const SizedBox(
                                                                    height: 140,
                                                                    width: 140,
                                                                  ),
                                                            InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  predictionWords =
                                                                      [
                                                                    [
                                                                      "أستطيع",
                                                                      getImageWord(
                                                                          "أستطيع")
                                                                    ],
                                                                    [
                                                                      "أشتري",
                                                                      getImageWord(
                                                                          "أشتري")
                                                                    ],
                                                                    [
                                                                      "أريد",
                                                                      getImageWord(
                                                                          "أريد")
                                                                    ],
                                                                    [
                                                                      "أحب",
                                                                      getImageWord(
                                                                          "أحب")
                                                                    ],
                                                                    [
                                                                      "أشعر",
                                                                      getImageWord(
                                                                          "أشعر")
                                                                    ],
                                                                    [
                                                                      "أعمل",
                                                                      getImageWord(
                                                                          "أعمل")
                                                                    ],
                                                                    [
                                                                      "أرى",
                                                                      getImageWord(
                                                                          "أرى")
                                                                    ],
                                                                    [
                                                                      "أروح",
                                                                      getImageWord(
                                                                          "أروح")
                                                                    ],
                                                                    [
                                                                      "أدرس",
                                                                      getImageWord(
                                                                          "أدرس")
                                                                    ],
                                                                    [
                                                                      "ألعب",
                                                                      getImageWord(
                                                                          "ألعب")
                                                                    ],
                                                                    [
                                                                      "أعطني",
                                                                      getImageWord(
                                                                          "أعطني")
                                                                    ],
                                                                    [
                                                                      "ألبس",
                                                                      getImageWord(
                                                                          "ألبس")
                                                                    ],
                                                                    [
                                                                      "أنام",
                                                                      getImageWord(
                                                                          "أنام")
                                                                    ],
                                                                    [
                                                                      "اتألم",
                                                                      getImageWord(
                                                                          "اتألم")
                                                                    ],
                                                                    [
                                                                      "أتحرك",
                                                                      getImageWord(
                                                                          "أتحرك")
                                                                    ],
                                                                    [
                                                                      "أمشي",
                                                                      getImageWord(
                                                                          "أمشي")
                                                                    ],
                                                                  ];
                                                                });
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            7),
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      size == 0
                                                                          ? 133
                                                                          : 120,
                                                                  decoration: BoxDecoration(
                                                                      color: const Color(
                                                                          0xffA7CB89),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              30)),
                                                                  child:
                                                                      const Center(
                                                                    child: Text(
                                                                      "أفعال",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              30),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )),
                                                        Container(
                                                          height: 7,
                                                        ),
                                                        Expanded(
                                                            child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            predictionWords
                                                                        .length >=
                                                                    9
                                                                ? box(8)
                                                                : const SizedBox(
                                                                    height: 140,
                                                                    width: 140,
                                                                  ),
                                                            predictionWords
                                                                        .length >=
                                                                    10
                                                                ? box(9)
                                                                : const SizedBox(
                                                                    height: 140,
                                                                    width: 140,
                                                                  ),
                                                            predictionWords
                                                                        .length >=
                                                                    11
                                                                ? box(10)
                                                                : const SizedBox(
                                                                    height: 140,
                                                                    width: 140,
                                                                  ),
                                                            predictionWords
                                                                        .length >=
                                                                    12
                                                                ? box(11)
                                                                : const SizedBox(
                                                                    height: 140,
                                                                    width: 140,
                                                                  ),
                                                            InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  predictionWords =
                                                                      [
                                                                    [
                                                                      "من",
                                                                      getImageWord(
                                                                          "من")
                                                                    ],
                                                                    [
                                                                      "إلى",
                                                                      getImageWord(
                                                                          "إلى")
                                                                    ],
                                                                    [
                                                                      "عن",
                                                                      getImageWord(
                                                                          "عن")
                                                                    ],
                                                                    [
                                                                      "على",
                                                                      getImageWord(
                                                                          "على")
                                                                    ],
                                                                    [
                                                                      "في",
                                                                      getImageWord(
                                                                          "في")
                                                                    ],
                                                                    [
                                                                      "على",
                                                                      getImageWord(
                                                                          "على")
                                                                    ],
                                                                    [
                                                                      "لم",
                                                                      getImageWord(
                                                                          "لم")
                                                                    ],
                                                                    [
                                                                      "لا",
                                                                      getImageWord(
                                                                          "لا")
                                                                    ],
                                                                    [
                                                                      "قد",
                                                                      getImageWord(
                                                                          "قد")
                                                                    ],
                                                                    [
                                                                      "إلا",
                                                                      getImageWord(
                                                                          "إلا")
                                                                    ],
                                                                    [
                                                                      "بلى",
                                                                      getImageWord(
                                                                          "بلى")
                                                                    ],
                                                                    [
                                                                      "حتى",
                                                                      getImageWord(
                                                                          "حتى")
                                                                    ],
                                                                    [
                                                                      "لن",
                                                                      getImageWord(
                                                                          "لن")
                                                                    ],
                                                                    [
                                                                      "لما",
                                                                      getImageWord(
                                                                          "لما")
                                                                    ],
                                                                    [
                                                                      "ما",
                                                                      getImageWord(
                                                                          "ما")
                                                                    ],
                                                                    [
                                                                      "ثم",
                                                                      getImageWord(
                                                                          "ثم")
                                                                    ],
                                                                    [
                                                                      "و",
                                                                      getImageWord(
                                                                          "و")
                                                                    ],
                                                                  ];
                                                                });
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            7),
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      size == 0
                                                                          ? 133
                                                                          : 120,
                                                                  decoration: BoxDecoration(
                                                                      color: const Color(
                                                                          0xffE9E467),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              30)),
                                                                  child:
                                                                      const Center(
                                                                    child: Text(
                                                                      "حروف",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              30),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )),
                                                        Container(
                                                          height: 7,
                                                        ),
                                                        size != 0 && !isLess
                                                            ? Expanded(
                                                                child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  predictionWords
                                                                              .length >=
                                                                          13
                                                                      ? box(12)
                                                                      : const SizedBox(
                                                                          height:
                                                                              140,
                                                                          width:
                                                                              140,
                                                                        ),
                                                                  predictionWords
                                                                              .length >=
                                                                          14
                                                                      ? box(13)
                                                                      : const SizedBox(
                                                                          height:
                                                                              140,
                                                                          width:
                                                                              140,
                                                                        ),
                                                                  predictionWords
                                                                              .length >=
                                                                          15
                                                                      ? box(14)
                                                                      : const SizedBox(
                                                                          height:
                                                                              140,
                                                                          width:
                                                                              140,
                                                                        ),
                                                                  predictionWords
                                                                              .length >=
                                                                          16
                                                                      ? box(15)
                                                                      : const SizedBox(
                                                                          height:
                                                                              140,
                                                                          width:
                                                                              140,
                                                                        ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        predictionWords =
                                                                            [
                                                                          [
                                                                            "سعيد",
                                                                            getImageWord("سعيد")
                                                                          ],
                                                                          [
                                                                            "حزين",
                                                                            getImageWord("حزين")
                                                                          ],
                                                                          [
                                                                            "جوعان",
                                                                            getImageWord("جوعان")
                                                                          ],
                                                                          [
                                                                            "عطشان",
                                                                            getImageWord("عطشان")
                                                                          ],
                                                                          [
                                                                            "خائف",
                                                                            getImageWord("خائف")
                                                                          ],
                                                                          [
                                                                            "رائع",
                                                                            getImageWord("رائع")
                                                                          ],
                                                                          [
                                                                            "جميل",
                                                                            getImageWord("جميل")
                                                                          ],
                                                                          [
                                                                            "سهل",
                                                                            getImageWord("سهل")
                                                                          ],
                                                                          [
                                                                            "صعب",
                                                                            getImageWord("صعب")
                                                                          ],
                                                                          [
                                                                            "سريع",
                                                                            getImageWord("سريع")
                                                                          ],
                                                                          [
                                                                            "بطيء",
                                                                            getImageWord("بطيء")
                                                                          ],
                                                                          [
                                                                            "تعبان",
                                                                            getImageWord("تعبان")
                                                                          ],
                                                                          [
                                                                            "طويل",
                                                                            getImageWord("طويل")
                                                                          ],
                                                                          [
                                                                            "قصير",
                                                                            getImageWord("قصير")
                                                                          ],
                                                                          [
                                                                            "جيد",
                                                                            getImageWord("جيد")
                                                                          ],
                                                                          [
                                                                            "سيء",
                                                                            getImageWord("سيء")
                                                                          ],
                                                                        ];
                                                                      });
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              7),
                                                                      child:
                                                                          Container(
                                                                        width: size ==
                                                                                0
                                                                            ? 133
                                                                            : 120,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                const Color(0xff1367A2).withOpacity(.6),
                                                                            borderRadius: BorderRadius.circular(30)),
                                                                        child:
                                                                            const Center(
                                                                          child:
                                                                              Text(
                                                                            "صفات",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                                fontSize: 30),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ))
                                                            : Container()
                                                      ],
                                                    ),
                                        )),
                                  ),
                                  MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? InkWell(
                                          onTap: () {
                                            setState(() {
                                              isLess = !isLess;
                                            });
                                          },
                                          child: Container(
                                            height: 27,
                                            width: 55,
                                            decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Image.asset(
                                              isLess
                                                  ? "assets/uiImages/down.png"
                                                  : "assets/uiImages/upArrow.png",
                                              height: 45,
                                              color: const Color.fromARGB(
                                                  255, 204, 204, 204),
                                              matchTextDirection: false,
                                            ),
                                          ),
                                        )
                                      : Container()
                                ],
                              ),
                            )),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 15, left: 15),
                              child: Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        if (currentOffsetScroll - 100 > 0) {
                                          setState(() {
                                            currentOffsetScroll -= 100;
                                            controllerList.animateTo(
                                                currentOffsetScroll,
                                                duration:
                                                    const Duration(seconds: 1),
                                                curve: Curves.easeOut);
                                          });
                                        } else {
                                          setState(() {
                                            currentOffsetScroll = 0;

                                            controllerList.jumpTo(0);
                                          });
                                        }
                                      },
                                      child: Image.asset(
                                        "assets/uiImages/arrow.png",
                                        height: 40,
                                        color: Colors.grey,
                                      )),
                                  Expanded(
                                    child: SizedBox(
                                      height: 80,
                                      child: ListView(
                                        controller: controllerList,
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          for (int i = 0;
                                              i < libraryListChild.length;
                                              i++)
                                            box2(i)
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        if (currentOffsetScroll + 100 <
                                            70 * libraryListChild.length) {
                                          setState(() {
                                            currentOffsetScroll += 70;
                                            controllerList.animateTo(
                                                currentOffsetScroll,
                                                duration:
                                                    const Duration(seconds: 1),
                                                curve: Curves.easeOut);
                                          });
                                        } else {
                                          setState(() {
                                            currentOffsetScroll =
                                                70.0 * libraryListChild.length;
                                            controllerList.animateTo(
                                                70.0 * libraryListChild.length,
                                                duration:
                                                    const Duration(seconds: 1),
                                                curve: Curves.easeOut);
                                          });
                                        }
                                      },
                                      child: Image.asset(
                                        "assets/uiImages/arrow.png",
                                        height: 40,
                                        matchTextDirection: true,
                                        color: Colors.grey,
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              height: isLess
                                  ? 270
                                  : size == 0
                                      ? 170
                                      : 135,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 206, 213, 218),
                                  borderRadius: BorderRadius.circular(7)),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  for (int i = 0;
                                      i < contentWord.length;
                                      isLess ? i = i + 2 : i++)
                                    Column(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onLongPress: () {
                                              howtospeak(
                                                  contentWord[i].name, context);
                                            },
                                            onDoubleTap: () {
                                              howtospeak(
                                                  contentWord[i].name, context);
                                            },
                                            onTap: () {
                                              if (speakingWordByWord) {
                                                howtospeak(contentWord[i].name,
                                                    context);
                                              }
                                              setState(() {
                                                fieldContent.add(
                                                  contentWord[i],
                                                );
                                              });
                                              String text = "";
                                              for (var element
                                                  in fieldContent) {
                                                text += "${element.name} ";
                                              }
                                              if (fav.contains(text.trim())) {
                                                setState(() {
                                                  isFav = true;
                                                });
                                              } else {
                                                setState(() {
                                                  isFav = false;
                                                });
                                              }
                                              contentWordController.animateTo(
                                                  contentWordController
                                                      .position.maxScrollExtent,
                                                  duration: const Duration(
                                                      milliseconds: 750),
                                                  curve: Curves.easeOut);
                                              predict(text
                                                  .replaceAll("أ", "ا")
                                                  .replaceAll("إ", "ا")
                                                  .replaceAll("ة", "ه")
                                                  .trim());
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5,
                                                  left: 2,
                                                  top: 5,
                                                  bottom: 5),
                                              child: Container(
                                                width: size == 0 ? 170 : 150,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(27)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.3),
                                                        spreadRadius: 3,
                                                        blurRadius: 5,
                                                        offset:
                                                            const Offset(0, 3)),
                                                  ],
                                                  border: Border.all(
                                                    width: size == 0 ? 3 : 2,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      SizedBox(
                                                        height: 60,
                                                        width: 60,
                                                        child: getImage(
                                                            contentWord[i]
                                                                .imgurl),
                                                      ),
                                                      Text(
                                                        noMoreText(
                                                            contentWord[i]
                                                                .name),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: size == 0
                                                                ? 22
                                                                : 20,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            color: pinkColor),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          ),
                                        ),
                                        isLess
                                            ? Expanded(
                                                child: i + 1 !=
                                                        contentWord.length
                                                    ? InkWell(
                                                        onLongPress: () {
                                                          howtospeak(
                                                              contentWord[i + 1]
                                                                  .name,
                                                              context);
                                                        },
                                                        onDoubleTap: () {
                                                          howtospeak(
                                                              contentWord[i + 1]
                                                                  .name,
                                                              context);
                                                        },
                                                        onTap: () {
                                                          if (speakingWordByWord) {
                                                            howtospeak(
                                                                contentWord[
                                                                        i + 1]
                                                                    .name,
                                                                context);
                                                          }
                                                          setState(() {
                                                            fieldContent.add(
                                                              contentWord[
                                                                  i + 1],
                                                            );
                                                          });
                                                          String text = "";
                                                          for (var element
                                                              in fieldContent) {
                                                            text +=
                                                                "${element.name} ";
                                                          }
                                                          if (fav.contains(
                                                              text.trim())) {
                                                            setState(() {
                                                              isFav = true;
                                                            });
                                                          } else {
                                                            setState(() {
                                                              isFav = false;
                                                            });
                                                          }
                                                          contentWordController.animateTo(
                                                              contentWordController
                                                                  .position
                                                                  .maxScrollExtent,
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          750),
                                                              curve: Curves
                                                                  .easeOut);
                                                          predict(text
                                                              .replaceAll(
                                                                  "أ", "ا")
                                                              .replaceAll(
                                                                  "إ", "ا")
                                                              .replaceAll(
                                                                  "ة", "ه")
                                                              .trim());
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          child: Container(
                                                            width: size == 0
                                                                ? 165
                                                                : 150,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          27)),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.3),
                                                                    spreadRadius:
                                                                        3,
                                                                    blurRadius:
                                                                        5,
                                                                    offset:
                                                                        const Offset(
                                                                            0,
                                                                            3)),
                                                              ],
                                                              border:
                                                                  Border.all(
                                                                width: size == 0
                                                                    ? 3
                                                                    : 2,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                            child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  SizedBox(
                                                                    height: 60,
                                                                    width: 60,
                                                                    child: getImage(
                                                                        contentWord[i +
                                                                                1]
                                                                            .imgurl),
                                                                  ),
                                                                  Text(
                                                                    noMoreText(
                                                                        contentWord[i +
                                                                                1]
                                                                            .name),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        fontSize: size ==
                                                                                0
                                                                            ? 22
                                                                            : 20,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                        color:
                                                                            pinkColor),
                                                                  ),
                                                                ]),
                                                          ),
                                                        ),
                                                      )
                                                    : Container(),
                                              )
                                            : Container()
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                    ),
                  ],
                )),
    );
  }

  String noMoreText(String text) {
    List textList = text.trim().split(" ");
    if (textList.length > 4) {
      String a = textList[0] +
          " " +
          textList[1] +
          " " +
          textList[2] +
          " " +
          textList[3] +
          "..";
      return a;
    } else {
      return text;
    }
  }

  autoComplete(String v) async {
    v = v.replaceAll("أ", "ا");
    v = v.replaceAll("إ", "ا");
    v = v.replaceAll("ة", "ه");
    bool isautoComplete = true;
    if (v.trim().length > 1) {
      if (v[v.length - 1] == " ") {
        isautoComplete = false;
        if (speakingWordByWord) {
          howtospeak(controller.text, context);
        }
        setState(() {
          fieldContent
              .add(Content(controller.text.trim(), "", "yes", "", "", "yes"));
        });
        String text = "";
        for (var element in fieldContent) {
          text += "${element.name} ";
        }
        predict(text
            .replaceAll("أ", "ا")
            .replaceAll("إ", "ا")
            .replaceAll("ة", "ه"));
        controller.clear();
      }
    }
    if (isautoComplete) {
      v = v.trim();
      if (v.isNotEmpty) {
        predictionWords = [];
        int leng = v.length;
        for (String element in LocalDB) {
          List<String> Sentence = element.trim().split(" ");

          for (var w in Sentence) {
            if (w.length >= leng) {
              if (w
                      .substring(0, leng)
                      .replaceAll("أ", "ا")
                      .replaceAll("إ", "ا")
                      .replaceAll("ة", "ه") ==
                  v) {
                if (!search_in_predictionWords(w)) {
                  predictionWords.removeWhere((element) => element[0] == w);
                  predictionWords.add([w, getImageWord(w)]);
                }
              }
            }
          }
          if (predictionWords.length >= 16) break;
        }
        if (predictionWords.length < 16) {
          String path1 = await rootBundle.loadString("assets/oneWord.txt");
          List<String> result = path1.split('\n');
          for (int i = 0; i < result.length; i++) {
            result[i] = result[i].replaceAll("\"", "").trim();
            int searchLenght = v.trim().length;
            String word = result[i];
            if (word.length >= v.trim().length) {
              if (word.substring(0, searchLenght) == v.trim()) {
                if (!search_in_predictionWords(word)) {
                  predictionWords.add([word, getImageWord(word)]);
                }
              }
            }
            if (predictionWords.length >= 16) break;
          }
        }
        setState(() {
          predictionWords;
        });
      }
    }
  }

  box(int index) {
    return InkWell(
      onTap: () {
        controller.clear();
        if (speakingWordByWord) {
          howtospeak(harakatPrediction(predictionWords[index][0]), context);
        }

        setState(() {
          fieldContent.add(
            Content(predictionWords[index][0], predictionWords[index][1], "yes",
                "", "", "yes"),
          );
        });

        String text = "";
        for (var element in fieldContent) {
          text += "${element.name} ";
        }
        predict(text
            .replaceAll("أ", "ا")
            .replaceAll("إ", "ا")
            .replaceAll("ة", "ه"));
        if (fav.contains(text.trim())) {
          setState(() {
            isFav = true;
          });
        } else {
          setState(() {
            isFav = false;
          });
        }
        if (fieldContent.length >= 7) {
          contentWordController.animateTo(
              contentWordController.position.maxScrollExtent - 180,
              duration: const Duration(milliseconds: 750),
              curve: Curves.easeOut);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Container(
          width: MediaQuery.of(context).orientation == Orientation.portrait
              ? size == 0
                  ? 133
                  : 120
              : size == 0
                  ? 130
                  : 115,
          decoration: BoxDecoration(
              // color: getWordColor(predictionWords[index][0]).withOpacity(.4),
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              border: Border.all(
                  color: getWordColor(predictionWords[index][0]), width: 5)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: FittedBox(
              child: Column(children: [
                SizedBox(
                  height: size == 0 ? 85 : 90,
                  width: size == 0 ? 85 : 90,
                  child: getImage(predictionWords[index][1]),
                ),
                Text(
                  predictionWords[index][0],
                  style: TextStyle(
                      fontSize: size == 0 ? 40 : 45,
                      fontWeight: FontWeight.w900,
                      color: pinkColor),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

  box2(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          coloredOpenLibraryindex = index;

          contentWord = libraryListChild[index].contenlist;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: index == coloredOpenLibraryindex
            ? Column(
                children: [
                  Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 206, 213, 218),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(27),
                          topRight: Radius.circular(27),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: const Offset(0, 3)),
                        ],
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: Text(
                                  libraryListChild[index].name,
                                  style: TextStyle(
                                      fontSize: size == 0 ? 33 : 25,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ])),
                ],
              )
            : Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          border: Border.all(
                            width: size == 0 ? 4 : 3,
                            color: Colors.grey,
                          ),
                        ),
                        child: Center(
                          child: FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                libraryListChild[index].name,
                                style: TextStyle(
                                    fontSize: size == 0 ? 35 : 30,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
      ),
    );
  }

  search_in_predictionWords(String word) {
    for (int i = 0; i < predictionWords.length; i++) {
      if (predictionWords[i][0]
              .replaceAll("أ", "ا")
              .replaceAll("إ", "ا")
              .replaceAll("ة", "ه")
              .trim() ==
          word
              .replaceAll("أ", "ا")
              .replaceAll("إ", "ا")
              .replaceAll("ة", "ه")
              .trim()) {
        return true;
      }
    }
    return false;
  }

  predict(String word) {
    List<String> sentence = word
        .replaceAll("  ", " ")
        .replaceAll("أ", "ا")
        .replaceAll("ة", "ه")
        //  Afnan
        .replaceAll("إ", "ا")

        ///
        .trim()
        .split(' ');
    if (sentence.length == 1) {
      predictionWords.clear();
      second_word_Local(sentence[0], 0);
    } else if (sentence.length == 2) {
      predictionWords.clear();
      third_word_Local(sentence, 0);
    } else {
      predictionWords.clear();
      List sent = sentence.sublist(sentence.length - 3, sentence.length);

      fourth_word_Local(sent, 0);
    }
  }

  fourth_word_Local(List text, int counter) async {
    List<String> result = LocalDB;
    for (String r in result) {
      if (counter < 16) {
        List<String> s = r
            .replaceAll("أ", "ا")
            .replaceAll("إ", "ا")
            .replaceAll("ة", "ه")
            .split(" ");
        List<String> sf = r.split(" ");
        for (int i = 0; i < s.length; i++) {
          if (s[i] == text[1]) {
            if (s.length - i >= 3 &&
                s[i + 1] == text[2] &&
                fieldContent[fieldContent.length - 1].name.trim() != s[i + 2] &&
                !search_in_predictionWords(s[i + 2])) {
              counter++;
              predictionWords.add([sf[i + 2], getImageWord(sf[i + 2])]);
            }
          }
        }
      } else {
        break;
      }
    }
    setState(() {});
    if (counter < 16) {
      fourth_word_child(text, counter);
    } else {
      return counter;
    }
  }

  fourth_word_child(List text, int counter) async {
    String path = await rootBundle.loadString("assets/fourgram.txt");
    List<String> result = path.split('\n');
    for (String r in result) {
      r = r.replaceAll("\"", "");

      if (counter < 16) {
        List<String> s = r
            .replaceAll("أ", "ا")
            .replaceAll("إ", "ا")
            .replaceAll("ة", "ه")
            .split(" ");
        List<String> sf = r.split(" ");
        if (s[1].compareTo(text[1]) == 0 &&
            s[2].compareTo(text[2]) == 0 &&
            s[3] != fieldContent[fieldContent.length - 1].name.trim() &&
            !search_in_predictionWords(s[3])) {
          counter++;
          predictionWords.add([sf[3], getImageWord(sf[3])]);
        }
      } else {
        break;
      }
    }
    setState(() {});

    if (counter < 16) {
      third_word_Local(text.sublist(1, text.length), counter);
    } else {
      return counter;
    }
  }

  third_word_Local(List text, int counter) async {
    for (String r in LocalDB) {
      if (counter < 16) {
        List<String> s = r
            .replaceAll("أ", "ا")
            .replaceAll("إ", "ا")
            .replaceAll("ة", "ه")
            .split(" ");
        List<String> sf = r.split(" ");
        for (int i = 0; i < s.length; i++) {
          if (s[i] == text[0]) {
            if (s.length - i >= 3 &&
                s[i + 1].trim() == text[1].trim() &&
                s[i + 2].trim() !=
                    fieldContent[fieldContent.length - 1].name.trim() &&
                !search_in_predictionWords(s[i + 2])) {
              counter++;
              predictionWords.add([sf[i + 2], getImageWord(sf[i + 2])]);
            }
          }
        }
      } else {
        break;
      }
    }
    setState(() {});
    if (counter < 16) {
      return third_word_child(text, counter);
    }
    return counter;
  }

  third_word_child(List text, int counter) async {
    String path = await rootBundle.loadString("assets/trigram.txt");
    List<String> result = path.split('\n');
    for (String r in result) {
      r = r.replaceAll("\"", "");
      if (counter < 16) {
        List<String> s = r
            .replaceAll("أ", "ا")
            .replaceAll("إ", "ا")
            .replaceAll("ة", "ه")
            .split(" ");
        List<String> sf = r.split(" ");
        if (s[0] == text[0] &&
            s[1] == text[1] &&
            s[2] != fieldContent[fieldContent.length - 1].name.trim() &&
            !search_in_predictionWords(s[2])) {
          counter++;
          predictionWords.add([sf[2], getImageWord(sf[2])]);
        }
      } else {
        break;
      }
    }
    setState(() {});
    if (counter < 16) {
      for (String r in result) {
        r = r.replaceAll("\"", "");
        if (counter < 16) {
          List<String> s = r
              .replaceAll("أ", "ا")
              .replaceAll("إ", "ا")
              .replaceAll("ة", "ه")
              .split(" ");
          List<String> sf = r.split(" ");
          if (s[1] == text[1] &&
              fieldContent[fieldContent.length - 1].name.trim() != s[2] &&
              !search_in_predictionWords(s[2])) {
            counter++;
            predictionWords.add([sf[2], getImageWord(sf[2])]);
          }
        } else {
          break;
        }
      }
      setState(() {});
    }

    if (counter < 16) {
      second_word_Local(text[1], counter);
    } else {
      return counter;
    }
  }

  second_word_Local(String text, int counter) async {
    List<String> result = LocalDB;
    for (String r in result) {
      if (counter < 16) {
        List<String> s = r
            .replaceAll("أ", "ا")
            .replaceAll("إ", "ا")
            .replaceAll("ة", "ه")
            .split(" ");
        List<String> sf = r.split(" ");

        for (int i = 0; i < s.length; i++) {
          if (s[i] == text) {
            if (s.length - i >= 2 && !search_in_predictionWords(sf[i + 1])) {
              counter++;

              predictionWords.add([sf[i + 1], getImageWord(sf[i + 1].trim())]);
            }
          }
        }
      } else {
        break;
      }
    }
    setState(() {});
    if (counter < 16) {
      return second_word_child(text, counter);
    }
  }

  second_word_child(String text, int counter) async {
    String path = await rootBundle.loadString("assets/bigram.txt");
    List<String> result = path.split('\n');

    for (String r in result) {
      r = r.replaceAll("\"", "");

      if (counter < 16) {
        List<String> s = r
            .replaceAll("أ", "ا")
            .replaceAll("إ", "ا")
            .replaceAll("ة", "ه")
            .split(" ");
        List<String> sf = r.split(" ");

        if (s[0] == text &&
            s[1] != fieldContent[fieldContent.length - 1].name.trim() &&
            !search_in_predictionWords(s[1])) {
          counter++;
          predictionWords.add([sf[1], getImageWord(sf[1].trim())]);
        }
      } else {
        break;
      }
    }
    setState(() {});
    if (counter < 16) {
      return one_word_child(counter);
    }
    return counter;
  }

  one_word_child(int counter) async {
    List wordsP = [
      "طيب",
      "تمام",
      "لا",
      "شكرا",
      "أنا",
      "هل",
      "كم",
      "هذا",
      "نعم",
      "أبغى",
      "كيف",
      "ممكن",
      "السلام",
      "اهلا",
      "مرحبا",
      "متى",
      "هذا",
      "مرحبا",
    ];
    for (int i = 0; i < wordsP.length; i++) {
      if (predictionWords.length < 16 &&
          !search_in_predictionWords(wordsP[i])) {
        predictionWords.add([wordsP[i], getImageWord(wordsP[i])]);
      }
    }

    setState(() {});
  }
}

String noMoreText(String text) {
  List textList = text.trim().split(" ");
  if (textList.length > 4) {
    String a = textList[0] +
        " " +
        textList[1] +
        " " +
        textList[2] +
        " " +
        textList[3] +
        ".....";
    return a;
  } else {
    return text;
  }
}

String getImageWord(String word) {
  String imurl = "";
  for (int j = 0; j < dataImage.length; j++) {
    dataImage[j][0].forEach((element) {
      if (element[0].replaceAll("أ", "ا") == word.replaceAll("أ", "ا")) {
        imurl = dataImage[j][1];
      }
      if (element[0].replaceAll("إ", "ا") == word.replaceAll("إ", "ا")) {
        imurl = dataImage[j][1];
      }
    });

    if (imurl != "") {
      break;
    }
  }
  return imurl;
}

Color getWordColor(String word) {
  word = word.trim();
  Color wordColor = Colors.grey;
  /*
  if (word == "أنا" ||
      word == "انا" ||
      word == "هل" ||
      word == "كم" ||
      word == "متى" ||
      word == "أين" ||
      word == "اين" ||
      word == "بكم" ||
      word == "هذا" ||
      word == "أبغى" ||
      word == "كيف" ||
      word == "طيب" ||
      word == "عندي" ||
      word == "شكرا" ||
      word == "السلام" ||
      word == "لكن" ||
      word == "ممكن" ||
      word == "لو") {
    wordColor = const Color(0xffC06FB9);
  } else {*/
  for (int j = 0; j < dataImage.length; j++) {
    dataImage[j][0].forEach((element) {
      if (element[0].replaceAll("أ", "ا") == word.replaceAll("أ", "ا")) {
        if (element[1] == "n") {
          wordColor = const Color.fromARGB(255, 214, 129, 1);
        } else if (element[1] == "v") {
          wordColor = Colors.green;
        } else if (element[1] == "a") {
          wordColor = Colors.blue;
        } else if (element[1] == "l") {
          wordColor = Colors.yellow;
        }
      }
      if (element[0].replaceAll("إ", "ا") == word.replaceAll("إ", "ا")) {
        if (element[1] == "n") {
          wordColor = const Color.fromARGB(255, 214, 129, 1);
        } else if (element[1] == "v") {
          wordColor = Colors.green;
        } else if (element[1] == "a") {
          wordColor = Colors.blue;
        } else if (element[1] == "l") {
          wordColor = Colors.yellow;
        }
      }
    });
    if (wordColor != Colors.grey) {
      break;
    }
  }

  return wordColor;
}
