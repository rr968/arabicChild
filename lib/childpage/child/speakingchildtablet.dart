import 'dart:convert';
import 'dart:math';
import 'package:tab_container/tab_container.dart';

import '/childpage/constant.dart';
import '/controller/images.dart';
import '/controller/speak.dart';
import '/controller/uploaddataChild.dart';
import '/controller/var.dart';
import '/dataImage.dart';
import '/model/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/erroralert.dart';
import '../../controller/realtime.dart';
import '../../model/content.dart';

class SpeakingChildTablet extends StatefulWidget {
  const SpeakingChildTablet({super.key});

  @override
  State<SpeakingChildTablet> createState() => _SpeakingChildTabletState();
}

class _SpeakingChildTabletState extends State<SpeakingChildTablet> {
  int folderIndex = 0;
  int coloredOpenLibraryindex = 0;
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
      ["مِن", getImageWord("مِن")],
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
  double currentOffsetScroll = 0;
  bool isLoading = true;
  bool isFav = false;
  late bool speakingWordByWord;

  @override
  void initState() {
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
        test.forEach((element2) {
          a += element2[0] + " ";
        });
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
    SharedPreferences LocalChild = await SharedPreferences.getInstance();
    if (!LocalDB.contains(Text)) {
      LocalDB.add(Text);
      LocalChild.setStringList("LocalChild", LocalDB);
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
                    Container(
                      height: MediaQuery.of(context).orientation !=
                              Orientation.portrait
                          ? MediaQuery.of(context).size.height -
                              40 -
                              MediaQuery.of(context).size.height * .07
                          : MediaQuery.of(context).size.height -
                              40 -
                              MediaQuery.of(context).size.height * .09,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                          child: Padding(
                        padding: EdgeInsets.only(top: 10, right: 15, left: 15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () async {
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

                                          controller.clear();
                                        }
                                        //speak
                                        String a = "";
                                        fieldContent.forEach((element) {
                                          a += element.name + " ";
                                        });

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
                                              .replaceAll("ة", "ه"));
                                        }
                                        howtospeak(a);
                                        store_In_local(a);
                                        tryUploadToRealTimeForChild(a);
                                      },
                                      child: Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
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
                                          padding: const EdgeInsets.all(7),
                                          child: Image.asset(
                                            "assets/uiImages/volume.png",
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 7,
                                    ),
                                    InkWell(
                                      onTap: () async {
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

                                          controller.clear();
                                        }
                                        if (fieldContent.isNotEmpty) {
                                          //speak
                                          String text = "";
                                          fieldContent.forEach((element) {
                                            text += element.name + " ";
                                          });
                                          if (controller.text
                                              .trim()
                                              .isNotEmpty) {
                                            predict(text
                                                .replaceAll("أ", "ا")
                                                .replaceAll("ة", "ه"));
                                          }

                                          SharedPreferences favlist =
                                              await SharedPreferences
                                                  .getInstance();
                                          if (!fav.contains(text.trim())) {
                                            setState(() {
                                              fav.add(text.trim());
                                              isFav = true;
                                            });

                                            String newFav = "";
                                            for (int y = 0;
                                                y < fieldContent.length;
                                                y++) {
                                              String input =
                                                  fieldContent[y].name;
                                              String imurl =
                                                  fieldContent[y].imgurl;
                                              String isimup =
                                                  fieldContent[y].isImageUpload;
                                              String voiceurl =
                                                  fieldContent[y].opvoice;
                                              String voiceCache =
                                                  fieldContent[y]
                                                      .cacheVoicePath;
                                              String isvoiceUp =
                                                  fieldContent[y].isVoiceUpload;

                                              if (y ==
                                                  fieldContent.length - 1) {
                                                newFav +=
                                                    """["$input","$imurl","$isimup","$voiceurl","$voiceCache","$isvoiceUp"]""";
                                              } else {
                                                newFav +=
                                                    """["$input","$imurl","$isimup","$voiceurl","$voiceCache","$isvoiceUp"],""";
                                              }
                                            }
                                            newFav = "[$newFav]";
                                            List<String> favChildList = [];
                                            var temp = favlist
                                                .getStringList("favlistChild");
                                            if (temp == null) {
                                              favChildList = [newFav];
                                            } else {
                                              favChildList = temp;
                                              favChildList.add(newFav);
                                            }
                                            favlist.setStringList(
                                                "favlistChild", favChildList);
                                          } else {
                                            fav.remove(text.trim());
                                            setState(() {
                                              isFav = false;
                                            });
                                            List<String> v =
                                                favlist.getStringList(
                                                        "favlistChild") ??
                                                    [];
                                            List favChild = [];
                                            v.forEach((element) {
                                              favChild
                                                  .add(json.decode(element));
                                            });
                                            favChild.removeWhere((element) {
                                              if (element.length !=
                                                  fieldContent.length) {
                                                return false;
                                              } else {
                                                bool sam = true;
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

                                            List<String> favString =
                                                convertFvaChildrenToString(
                                                    favChild);
                                            favlist.setStringList(
                                                "favlistChild", favString);
                                          }
                                        } else {
                                          erroralert(context,
                                              "يرجى ملئ الحقل للاضافة الى المفضلة");
                                        }
                                      },
                                      child: Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
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
                                          padding: const EdgeInsets.all(7),
                                          child: isFav
                                              ? Image.asset(
                                                  "assets/uiImages/star2.png",
                                                  color: maincolor,
                                                  height: 33,
                                                )
                                              : Image.asset(
                                                  "assets/uiImages/star.png",
                                                  height: 33,
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 7,
                                ),
                                Expanded(
                                    child: Container(
                                  height: 140,
                                  decoration: BoxDecoration(
                                    color: Color(0xffe9edf3),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(27)),
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
                                    padding: const EdgeInsets.all(7),
                                    child: Row(
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: InkWell(
                                            onTap: () {
                                              // clear
                                              if (fieldContent.isNotEmpty) {
                                                if (fieldContent.length == 1) {
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
                                                        "متى",
                                                        getImageWord("متى")
                                                      ],
                                                      [
                                                        "اين",
                                                        getImageWord("اين")
                                                      ],
                                                      [
                                                        "كيف",
                                                        getImageWord("كيف")
                                                      ],
                                                      [
                                                        "كم",
                                                        getImageWord("كم")
                                                      ],
                                                      [
                                                        "افتح",
                                                        getImageWord("افتح")
                                                      ],
                                                      [
                                                        "ممكن",
                                                        getImageWord("ممكن")
                                                      ],
                                                      [
                                                        "طيب",
                                                        getImageWord("طيب")
                                                      ],
                                                      [
                                                        "السلام",
                                                        getImageWord("السلام")
                                                      ],
                                                      [
                                                        "أريد",
                                                        getImageWord("أريد")
                                                      ],
                                                      [
                                                        "لماذا",
                                                        getImageWord("لماذا")
                                                      ],
                                                      [
                                                        "قال",
                                                        getImageWord("قال")
                                                      ],
                                                      [
                                                        "نعم",
                                                        getImageWord("نعم")
                                                      ],
                                                      [
                                                        "مع",
                                                        getImageWord("مع")
                                                      ],
                                                      [
                                                        "لكن",
                                                        getImageWord("لكن")
                                                      ],
                                                    ];
                                                    ;
                                                  });
                                                } else {
                                                  setState(() {
                                                    fieldContent.removeAt(
                                                        fieldContent.length -
                                                            1);
                                                  });
                                                  String text = "";
                                                  fieldContent
                                                      .forEach((element) {
                                                    text += element.name + " ";
                                                  });
                                                  predict(text
                                                      .replaceAll("أ", "ا")
                                                      .replaceAll("ة", "ه"));
                                                  if (fav
                                                      .contains(text.trim())) {
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
                                                height: 40,
                                                matchTextDirection: true,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              for (int i = 0;
                                                  i < fieldContent.length;
                                                  i++)
                                                fieldContent[i].imgurl.isEmpty
                                                    ? Container(
                                                        child: FittedBox(
                                                          child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  height: 110,
                                                                  width: 110,
                                                                ),
                                                                Text(
                                                                  fieldContent[
                                                                          i]
                                                                      .name,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          40,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                      color:
                                                                          maincolor),
                                                                )
                                                              ]),
                                                        ),
                                                      )
                                                    : Container(
                                                        child: FittedBox(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12),
                                                            child: Column(
                                                                children: [
                                                                  Container(
                                                                    height: 110,
                                                                    width: 110,
                                                                    child: getImage(
                                                                        fieldContent[i]
                                                                            .imgurl),
                                                                  ),
                                                                  Text(
                                                                    fieldContent[
                                                                            i]
                                                                        .name,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            40,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w900,
                                                                        color:
                                                                            maincolor),
                                                                  )
                                                                ]),
                                                          ),
                                                        ),
                                                      ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15),
                                                child: SizedBox(
                                                  height: 140,
                                                  width: 300,
                                                  child: Center(
                                                    child: TextField(
                                                      controller: controller,
                                                      cursorColor: maincolor,
                                                      onTap: () {
                                                        controller.selection =
                                                            TextSelection.fromPosition(
                                                                TextPosition(
                                                                    offset: controller
                                                                        .text
                                                                        .trim()
                                                                        .length));
                                                      },
                                                      onChanged: (v) async {
                                                        if (v
                                                            .trim()
                                                            .isNotEmpty) {
                                                          autoComplete(v);
                                                        } else if (v
                                                                .trim()
                                                                .isEmpty &&
                                                            fieldContent
                                                                .isNotEmpty) {
                                                          predict(fieldContent[
                                                                  fieldContent
                                                                          .length -
                                                                      1]
                                                              .name);
                                                        } else if (fieldContent
                                                                .isEmpty &&
                                                            v.trim().isEmpty) {
                                                          setState(() {
                                                            predictionWords = [
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
                                                                "كيف",
                                                                getImageWord(
                                                                    "كيف")
                                                              ],
                                                              [
                                                                "كم",
                                                                getImageWord(
                                                                    "كم")
                                                              ],
                                                              [
                                                                "افتح",
                                                                getImageWord(
                                                                    "افتح")
                                                              ],
                                                              [
                                                                "ممكن",
                                                                getImageWord(
                                                                    "ممكن")
                                                              ],
                                                              [
                                                                "طيب",
                                                                getImageWord(
                                                                    "طيب")
                                                              ],
                                                              [
                                                                "السلام",
                                                                getImageWord(
                                                                    "السلام")
                                                              ],
                                                              [
                                                                "أريد",
                                                                getImageWord(
                                                                    "أريد")
                                                              ],
                                                              [
                                                                "لماذا",
                                                                getImageWord(
                                                                    "لماذا")
                                                              ],
                                                              [
                                                                "قال",
                                                                getImageWord(
                                                                    "قال")
                                                              ],
                                                              [
                                                                "نعم",
                                                                getImageWord(
                                                                    "نعم")
                                                              ],
                                                              [
                                                                "مع",
                                                                getImageWord(
                                                                    "مع")
                                                              ],
                                                              [
                                                                "لكن",
                                                                getImageWord(
                                                                    "لكن")
                                                              ],
                                                            ];
                                                          });
                                                        }
                                                      },
                                                      cursorWidth: 4,
                                                      style: TextStyle(
                                                          fontSize: 35,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                                Container(
                                  width: 7,
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          isFav = false;
                                          fieldContent = [];
                                          predictionWords = [
                                            ["انا", getImageWord("انا")],
                                            ["هل", getImageWord("هل")],
                                            ["متى", getImageWord("متى")],
                                            ["اين", getImageWord("اين")],
                                            ["كيف", getImageWord("كيف")],
                                            ["كم", getImageWord("كم")],
                                            ["افتح", getImageWord("افتح")],
                                            ["ممكن", getImageWord("ممكن")],
                                            ["طيب", getImageWord("طيب")],
                                            ["السلام", getImageWord("السلام")],
                                            ["أريد", getImageWord("أريد")],
                                            ["لماذا", getImageWord("لماذا")],
                                            ["قال", getImageWord("قال")],
                                            ["نعم", getImageWord("نعم")],
                                            ["مع", getImageWord("مع")],
                                            ["لكن", getImageWord("لكن")],
                                          ];
                                        });
                                        controller.clear();
                                      },
                                      child: Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
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
                                          padding: const EdgeInsets.all(7),
                                          child: Image.asset(
                                            "assets/uiImages/trash.png",
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 7,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        String text = "";
                                        fieldContent.forEach((element) {
                                          text += element.name + " ";
                                        });
                                        if (text.trim().isNotEmpty) {
                                          Share.share(text);
                                        }
                                      },
                                      child: Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
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
                                            padding: const EdgeInsets.all(9),
                                            child: Image.asset(
                                              "assets/uiImages/paper-plane.png",
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Expanded(
                                child: MediaQuery.of(context).orientation !=
                                        Orientation.portrait
                                    ? Column(
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                        .orientation !=
                                                    Orientation.portrait
                                                ? 5
                                                : 10,
                                          ),
                                          Expanded(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              predictionWords.length >= 1
                                                  ? box(0)
                                                  : Container(
                                                      height: 140,
                                                      width: 140,
                                                    ),
                                              predictionWords.length >= 2
                                                  ? box(1)
                                                  : Container(
                                                      height: 140,
                                                      width: 140,
                                                    ),
                                              predictionWords.length >= 3
                                                  ? box(2)
                                                  : Container(
                                                      height: 140,
                                                      width: 140,
                                                    ),
                                              predictionWords.length >= 4
                                                  ? box(3)
                                                  : Container(
                                                      height: 140,
                                                      width: 140,
                                                    ),
                                              predictionWords.length >= 5
                                                  ? box(4)
                                                  : Container(
                                                      height: 140,
                                                      width: 140,
                                                    ),
                                              predictionWords.length >= 6
                                                  ? box(5)
                                                  : Container(
                                                      height: 140,
                                                      width: 140,
                                                    ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    predictionWords = [
                                                      [
                                                        "أنا",
                                                        getImageWord("أنا")
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
                                                        "أين",
                                                        getImageWord("أين")
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
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 7),
                                                  child: Container(
                                                    width: 120,
                                                    decoration: BoxDecoration(
                                                        color: maincolor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                    child: Center(
                                                      child: Text(
                                                        "كلمات مفتاحية",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                            fontSize: 28),
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
                                                MainAxisAlignment.center,
                                            children: [
                                              predictionWords.length >= 7
                                                  ? box(6)
                                                  : Container(
                                                      height: 140,
                                                      width: 140,
                                                    ),
                                              predictionWords.length >= 8
                                                  ? box(7)
                                                  : Container(
                                                      height: 140,
                                                      width: 140,
                                                    ),
                                              predictionWords.length >= 9
                                                  ? box(8)
                                                  : Container(
                                                      height: 140,
                                                      width: 140,
                                                    ),
                                              predictionWords.length >= 10
                                                  ? box(9)
                                                  : Container(
                                                      height: 140,
                                                      width: 140,
                                                    ),
                                              predictionWords.length >= 11
                                                  ? box(10)
                                                  : Container(
                                                      height: 140,
                                                      width: 140,
                                                    ),
                                              predictionWords.length >= 12
                                                  ? box(11)
                                                  : Container(
                                                      height: 140,
                                                      width: 140,
                                                    ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    predictionWords = [
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
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 7),
                                                  child: Container(
                                                    width: 120,
                                                    decoration: BoxDecoration(
                                                        color: yellowColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                    child: Center(
                                                      child: Text(
                                                        "أفعال",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize: 30),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          Container(
                                            height: 10,
                                          ),
                                          Expanded(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              predictionWords.length >= 1
                                                  ? box(0)
                                                  : Container(
                                                      height: 110,
                                                      width: 110,
                                                    ),
                                              predictionWords.length >= 2
                                                  ? box(1)
                                                  : Container(
                                                      height: 140,
                                                      width: 140,
                                                    ),
                                              predictionWords.length >= 3
                                                  ? box(2)
                                                  : Container(
                                                      height: 140,
                                                      width: 140,
                                                    ),
                                              predictionWords.length >= 4
                                                  ? box(3)
                                                  : Container(
                                                      height: 140,
                                                      width: 140,
                                                    ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    predictionWords = [
                                                      [
                                                        "أنا",
                                                        getImageWord("أنا")
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
                                                        "أين",
                                                        getImageWord("أين")
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
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 7),
                                                  child: Container(
                                                    width: 120,
                                                    decoration: BoxDecoration(
                                                        color: maincolor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                    child: Center(
                                                      child: Text(
                                                        "كلمات مفتاحية",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                            fontSize: 28),
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
                                                MainAxisAlignment.center,
                                            children: [
                                              predictionWords.length >= 5
                                                  ? box(4)
                                                  : Container(
                                                      height: 140,
                                                      width: 140,
                                                    ),
                                              predictionWords.length >= 6
                                                  ? box(5)
                                                  : Container(
                                                      height: 140,
                                                      width: 140,
                                                    ),
                                              predictionWords.length >= 7
                                                  ? box(6)
                                                  : Container(
                                                      height: 140,
                                                      width: 140,
                                                    ),
                                              predictionWords.length >= 8
                                                  ? box(7)
                                                  : Container(
                                                      height: 140,
                                                      width: 140,
                                                    ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    predictionWords = [
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
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 7),
                                                  child: Container(
                                                    width: 120,
                                                    decoration: BoxDecoration(
                                                        color: yellowColor
                                                            .withOpacity(.9),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                    child: Center(
                                                      child: Text(
                                                        "أفعال",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                            fontSize: 30),
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
                                                MainAxisAlignment.center,
                                            children: [
                                              predictionWords.length >= 9
                                                  ? box(8)
                                                  : Container(
                                                      height: 140,
                                                      width: 140,
                                                    ),
                                              predictionWords.length >= 10
                                                  ? box(9)
                                                  : Container(
                                                      height: 140,
                                                      width: 140,
                                                    ),
                                              predictionWords.length >= 11
                                                  ? box(10)
                                                  : Container(
                                                      height: 140,
                                                      width: 140,
                                                    ),
                                              predictionWords.length >= 12
                                                  ? box(11)
                                                  : Container(
                                                      height: 140,
                                                      width: 140,
                                                    ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    predictionWords = [
                                                      [
                                                        "مِن",
                                                        getImageWord("مِن")
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
                                                      ["و", getImageWord("و")],
                                                    ];
                                                  });
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 7),
                                                  child: Container(
                                                    width: 120,
                                                    decoration: BoxDecoration(
                                                        color: pinkColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                    child: Center(
                                                      child: Text(
                                                        "حروف",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                            fontSize: 30),
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
                                                MainAxisAlignment.center,
                                            children: [
                                              predictionWords.length >= 13
                                                  ? box(12)
                                                  : Container(
                                                      height: 140,
                                                      width: 140,
                                                    ),
                                              predictionWords.length >= 14
                                                  ? box(13)
                                                  : Container(
                                                      height: 140,
                                                      width: 140,
                                                    ),
                                              predictionWords.length >= 15
                                                  ? box(14)
                                                  : Container(
                                                      height: 140,
                                                      width: 140,
                                                    ),
                                              predictionWords.length >= 16
                                                  ? box(15)
                                                  : Container(
                                                      height: 140,
                                                      width: 140,
                                                    ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    predictionWords = [
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
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 7),
                                                  child: Container(
                                                    width: 120,
                                                    decoration: BoxDecoration(
                                                        color: greyColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                    child: Center(
                                                      child: Text(
                                                        "صفات",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                            fontSize: 30),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )),
                                        ],
                                      )),
                            Container(
                              height: 170,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  for (int i = 0; i < contentWord.length; i++)
                                    InkWell(
                                      onTap: () {
                                        if (speakingWordByWord) {
                                          howtospeak(contentWord[i].name);
                                        }
                                        setState(() {
                                          fieldContent.add(
                                            contentWord[i],
                                          );
                                        });
                                        String text = "";
                                        fieldContent.forEach((element) {
                                          text += element.name + " ";
                                        });
                                        if (fav.contains(text.trim())) {
                                          setState(() {
                                            isFav = true;
                                          });
                                        } else {
                                          setState(() {
                                            isFav = false;
                                          });
                                        }
                                        predict(text
                                            .replaceAll("أ", "ا")
                                            .replaceAll("ة", "ه")
                                            .trim());
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Container(
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(27)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  spreadRadius: 3,
                                                  blurRadius: 5,
                                                  offset: Offset(0, 3)),
                                            ],
                                            border: Border.all(
                                              width: 2,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  height: 60,
                                                  width: 60,
                                                  child: getImage(
                                                      contentWord[i].imgurl),
                                                ),
                                                Text(
                                                  contentWord[i].name,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: maincolor),
                                                ),
                                              ]),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (currentOffsetScroll - 90 > 0) {
                                      setState(() {
                                        currentOffsetScroll -= 90;
                                        controllerList
                                            .jumpTo(currentOffsetScroll);
                                      });
                                    } else {
                                      setState(() {
                                        currentOffsetScroll = 0;

                                        controllerList.jumpTo(0);
                                      });
                                    }
                                  },
                                  child: Image.asset(
                                    "assets/uiImages/left-arrow.png",
                                    height: 70,
                                  ),
                                ),
                                Container(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).orientation ==
                                                Orientation.portrait
                                            ? 130
                                            : 110,
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
                                Container(
                                  width: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (currentOffsetScroll + 130 <
                                        130 * libraryListChild.length) {
                                      setState(() {
                                        currentOffsetScroll += 130;
                                        controllerList
                                            .jumpTo(currentOffsetScroll);
                                      });
                                    } else {
                                      setState(() {
                                        currentOffsetScroll =
                                            130.0 * libraryListChild.length;

                                        controllerList.jumpTo(
                                            (130.0 * libraryListChild.length));
                                      });
                                    }
                                  },
                                  child: Image.asset(
                                    "assets/uiImages/left-arrow.png",
                                    matchTextDirection: true,
                                    height: 70,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                    ),
                  ],
                )),
    );
  }

  autoComplete(String v) async {
    v = v.replaceAll("أ", "ا");
    v = v.replaceAll("ة", "ه");
    bool isautoComplete = true;
    if (v.trim().length > 1) {
      if (v[v.length - 1] == " ") {
        isautoComplete = false;
        if (speakingWordByWord) {
          howtospeak(controller.text);
        }
        setState(() {
          fieldContent
              .add(Content(controller.text.trim(), "", "yes", "", "", "yes"));
        });
        String text = "";
        fieldContent.forEach((element) {
          text += element.name + " ";
        });
        predict(text.replaceAll("أ", "ا").replaceAll("ة", "ه"));
        controller.clear();
      }
    }
    if (isautoComplete) {
      v = v.trim();
      if (v.length != 0) {
        predictionWords = [];
        int leng = v.length;
        for (String element in LocalDB) {
          List<String> Sentence = element.trim().split(" ");

          Sentence.forEach((w) {
            if (w.length >= leng) {
              if (w
                      .substring(0, leng)
                      .replaceAll("أ", "ا")
                      .replaceAll("ة", "ه") ==
                  v) {
                if (!search_in_predictionWords(w)) {
                  predictionWords.removeWhere((element) => element[0] == w);
                  predictionWords.add([w, getImageWord(w)]);
                }
              }
            }
          });
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
          howtospeak(predictionWords[index][0]);
        }

        setState(() {
          fieldContent.add(
            Content(predictionWords[index][0], predictionWords[index][1], "yes",
                "", "", "yes"),
          );
        });

        String text = "";
        fieldContent.forEach((element) {
          text += element.name + " ";
        });
        predict(text.replaceAll("أ", "ا").replaceAll("ة", "ه"));
        if (fav.contains(text.trim())) {
          setState(() {
            isFav = true;
          });
        } else {
          setState(() {
            isFav = false;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Container(
          width: MediaQuery.of(context).orientation == Orientation.portrait
              ? 120
              : 110,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(27)),
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
            padding: const EdgeInsets.only(bottom: 3),
            child: FittedBox(
              child: Column(children: [
                Container(
                  height: 90,
                  width: 90,
                  child: getImage(predictionWords[index][1]),
                ),
                Text(
                  predictionWords[index][0],
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: maincolor),
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
          folderIndex = -1;
          contentWord = libraryListChild[index].contenlist;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            width: MediaQuery.of(context).orientation == Orientation.portrait
                ? 120
                : 110,
            decoration: BoxDecoration(
              color: index == coloredOpenLibraryindex
                  ? Colors.orange
                  : Color(0xffe9edf3),
              borderRadius: BorderRadius.all(Radius.circular(27)),
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
            child: Center(
              child: FittedBox(
                child: Text(
                  libraryListChild[index].name,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.black),
                ),
              ),
            )),
      ),
    );
  }

  predict(String word) {
    List<String> sentence = word.replaceAll("  ", " ").trim().split(' ');
    if (sentence.length == 1) {
      predictionWords.clear();
      second_word_Local(sentence[0], 0, false);
    } else if (sentence.length == 2) {
      predictionWords.clear();
      third_word_Local(sentence, 0, false);
    } else if (sentence.length == 3) {
      predictionWords.clear();
      fourth_word_Local(sentence, 0, false);
    } else if (sentence.length == 4) {
      predictionWords.clear();
      fifth_word(sentence, 0, false);
    } else if (sentence.length > 4) {
      predictionWords.clear();
      more_words(sentence, 0);
    }
  }

  search_in_predictionWords(String word) {
    for (int i = 0; i < predictionWords.length; i++) {
      if (predictionWords[i][0].trim() == word.trim()) {
        return true;
      }
    }
    return false;
  }

  more_words(List text, int counter) async {
    List<String> list = [];
    for (int i = text.length - 1; i > 2; i--) {
      list = [text[i - 3], text[i - 2], text[i - 1], text[i]];

      counter = await fifth_word(list, counter, true);
    }

    if (counter < 16) {
      for (int i = text.length - 1; i > 0; i--) {
        list = [text[i - 1], text[i]];

        counter = await third_word_child(list, counter, true);
      }
    }
    if (counter < 16) {
      for (int i = text.length - 1; i > -1; i--) {
        counter = await second_word_child(text[i], counter, true);
      }
    }
    if (counter < 16) {
      one_word_child(text[text.length - 1], counter);
    }
  }

  fifth_word(List text, int counter, bool back) async {
    List<String> list = [text[1], text[2], text[3]];
    if (counter < 16) {
      counter = await fourth_word_Local(list, counter, true);
    }
    if (counter < 16) {
      counter = await fourth_word_child(list, counter, true);
    }
    if (counter < 16) {
      list = [text[0], text[1], text[2]];
      counter = await fourth_word_child(list, counter, true);
    }
    if (counter < 16) {
      if (back) {
        return counter;
      } else {
        list = [text[2], text[3]];
        counter = await third_word_Local(list, counter, true);
        if (counter < 16) {
          counter = await third_word_child(list, counter, true);
        }
        if (counter < 16) {
          list = [text[1], text[2]];
          counter = await third_word_child(list, counter, true);
        }
        if (counter < 16) {
          list = [text[0], text[1]];
          counter = await third_word_child(list, counter, true);
        }
        if (counter < 16) {
          counter = await second_word_child(text[3], counter, true);
        }
        if (counter < 16) {
          counter = await second_word_child(text[2], counter, true);
        }
        if (counter < 16) {
          counter = await second_word(text[1], counter, true);
        }
        if (counter < 16) {
          second_word(text[0], counter, false);
        }
      }
    }
    return counter;
  }

  fourth_word_Local(List text, int counter, bool back) async {
    List<String> result = LocalDB;
    for (String r in result) {
      if (counter < 16) {
        List<String> s = r.split(" ");
        for (int i = 0; i < s.length; i++) {
          if (s[i] == text[0]) {
            if (s.length - i >= 4 &&
                s[i] == text[0] &&
                s[i + 1] == text[1] &&
                s[i + 2] == text[2] &&
                fieldContent[fieldContent.length - 1].name.trim() != s[i + 3] &&
                !search_in_predictionWords(s[i + 3])) {
              counter++;
              predictionWords.add([s[i + 3], getImageWord(s[i + 3])]);
            }
          }
        }
        // if (s.length >= 4 &&
        //     s[0] == text[0] &&
        //     s[1] == text[1] &&
        //     s[2] == text[2] &&
        //     fieldContent[fieldContent.length - 1].name.trim() != s[3] &&
        //     !search_in_constant(s[3]) &&
        //     !search_in_predictionWords(s[3])) {

      } else
        break;
    }
    setState(() {});
    if (counter < 16) {
      for (String r in result) {
        if (counter < 16) {
          List<String> s = r.split(" ");
          for (int i = 0; i < s.length; i++) {
            if (s[i] == text[0]) {
              if (s.length - i >= 4 &&
                  s[i] == text[0] &&
                  s[i + 1] == text[1] &&
                  fieldContent[fieldContent.length - 1].name.trim() !=
                      s[i + 3] &&
                  !search_in_predictionWords(s[i + 3])) {
                counter++;
                predictionWords.add([s[i + 3], getImageWord(s[i + 3])]);
              }
            }
          }
        } else
          break;
      }
      setState(() {});
    }
    if (back) return counter;
    return fourth_word_child(text, counter, false);
  }

  fourth_word_child(List text, int counter, bool back) async {
    String path = await rootBundle.loadString("assets/fourgram.txt");
    List<String> result = path.split('\n');

    for (String r in result) {
      r = r.replaceAll("\"", "");
      if (counter < 16) {
        List<String> s = r.split(" ");
        if (s[0].compareTo(text[0]) == 0 &&
            s[1].compareTo(text[1]) == 0 &&
            s[2].compareTo(text[2]) == 0 &&
            s[3].compareTo(fieldContent[fieldContent.length - 1].name.trim()) !=
                0 &&
            !search_in_predictionWords(s[3])) {
          counter++;
          predictionWords.add([s[3], getImageWord(s[3])]);
        }
      } else
        break;
    }
    setState(() {});
    if (counter < 16) {
      for (String r in result) {
        r = r.replaceAll("\"", "");
        if (counter < 16) {
          List<String> s = r.split(" ");
          if (s[1].compareTo(text[1]) == 0 &&
              s[2].compareTo(text[2]) == 0 &&
              s[3].compareTo(
                      fieldContent[fieldContent.length - 1].name.trim()) !=
                  0 &&
              !search_in_predictionWords(s[3])) {
            counter++;
            predictionWords.add([s[3], getImageWord(s[3])]);
          }
        } else
          break;
      }
      setState(() {});
    }
    if (counter < 16) {
      for (String r in result) {
        r = r.replaceAll("\"", "");
        if (counter < 16) {
          List<String> s = r.split(" ");
          if (s[0].compareTo(text[0]) == 0 &&
              s[1].compareTo(text[1]) == 0 &&
              s[3].compareTo(
                      fieldContent[fieldContent.length - 1].name.trim()) !=
                  0 &&
              !search_in_predictionWords(s[3])) {
            counter++;
            String word = s[3];
            predictionWords.add([word, getImageWord(word)]);
          }
        } else
          break;
      }
      setState(() {});
    }
    if (counter < 16) {
      for (String r in result) {
        r = r.replaceAll("\"", "");
        if (counter < 16) {
          List<String> s = r.split(" ");
          if (s[0].compareTo(text[0]) == 0 &&
              s[1].compareTo(text[2]) == 0 &&
              s[3].compareTo(
                      fieldContent[fieldContent.length - 1].name.trim()) !=
                  0 &&
              !search_in_predictionWords(s[3])) {
            counter++;
            predictionWords.add([s[3], getImageWord(s[3])]);
          }
        } else
          break;
      }
      setState(() {});
    }
    if (counter < 16) {
      if (back) {
        return counter;
      } else {
        return third_word_Local(
            [text[text.length - 2], text[text.length - 1]], counter, false);
      }
    }

    return counter;
  }

// Old DB
  fourth_word(List text, int counter, bool back) async {
    String path = await rootBundle.loadString("assets/4gram.txt");
    List<String> result = path.split('\n');
    for (String r in result) {
      r = r.replaceAll("\"", "");

      if (counter < 16) {
        List<String> s = r.split(" ");
        if (s[0] == text[0] &&
            s[1] == text[1] &&
            s[2] == text[2] &&
            fieldContent[fieldContent.length - 1].name.trim() != s[3] &&
            !search_in_predictionWords(s[3])) {
          counter++;
          String word = s[3];
          predictionWords.add([word, getImageWord(word)]);
        }
      } else
        break;
    }
    setState(() {});
    if (counter < 16) {
      for (String r in result) {
        r = r.replaceAll("\"", "");

        if (counter < 16) {
          List<String> s = r.split(" ");
          if (s[1] == text[1] &&
              s[2] == text[2] &&
              fieldContent[fieldContent.length - 1].name.trim() != s[3] &&
              !search_in_predictionWords(s[3])) {
            counter++;
            String word = s[3];
            predictionWords.add([word, getImageWord(word)]);
          }
        } else
          break;
      }
      setState(() {});
    }
    if (counter < 16) {
      for (String r in result) {
        r = r.replaceAll("\"", "");
        if (counter < 16) {
          List<String> s = r.split(" ");
          if (s[0] == text[0] &&
              s[1] == text[1] &&
              fieldContent[fieldContent.length - 1].name.trim() != s[3] &&
              !search_in_predictionWords(s[3])) {
            counter++;
            String word = s[3];
            predictionWords.add([word, getImageWord(word)]);
          }
        } else
          break;
      }
      setState(() {});
    }
    if (counter < 16) {
      for (String r in result) {
        r = r.replaceAll("\"", "");

        if (counter < 16) {
          List<String> s = r.split(" ");
          if (s[0] == text[0] &&
              s[1] == text[2] &&
              fieldContent[fieldContent.length - 1].name.trim() != s[3] &&
              !search_in_predictionWords(s[3])) {
            counter++;
            String word = s[3];
            predictionWords.add([word, getImageWord(word)]);
          }
        } else
          break;
      }
      setState(() {});
    }
    if (counter < 16) {
      if (back) {
        return counter;
      } else {
        return third_word([text[1], text[2]], counter, false);
      }
    }

    return counter;
  }

  third_word_Local(List text, int counter, bool back) async {
    for (String r in LocalDB) {
      if (counter < 16) {
        List<String> s = r.split(" ");
        for (int i = 0; i < s.length; i++) {
          if (s[i] == text[0]) {
            if (s.length - i >= 3 &&
                s[i + 1].trim() == text[1].trim() &&
                s[i + 2].trim() !=
                    fieldContent[fieldContent.length - 1].name.trim() &&
                !search_in_predictionWords(s[i + 2])) {
              counter++;
              predictionWords.add([s[i + 2], getImageWord(s[i + 2])]);
            }
          }
        }
      } else
        break;
    }
    setState(() {});
    if (back) return counter;

    return third_word_child(text, counter, false);
  }

  third_word_child(List text, int counter, bool back) async {
    String path = await rootBundle.loadString("assets/trigram.txt");
    List<String> result = path.split('\n');
    for (String r in result) {
      r = r.replaceAll("\"", "");
      if (counter < 16) {
        List<String> s = r.split(" ");
        if (s[0] == text[0] &&
            s[1] == text[1] &&
            s[2] != fieldContent[fieldContent.length - 1].name.trim() &&
            !search_in_predictionWords(s[2])) {
          counter++;
          predictionWords.add([s[2], getImageWord(s[2])]);
        }
      } else
        break;
    }
    setState(() {});
    if (counter < 16) {
      for (String r in result) {
        r = r.replaceAll("\"", "");
        if (counter < 16) {
          List<String> s = r.split(" ");
          if (s[1] == text[1] &&
              fieldContent[fieldContent.length - 1].name.trim() != s[2] &&
              !search_in_predictionWords(s[2])) {
            counter++;
            predictionWords.add([s[2], getImageWord(s[2])]);
          }
        } else
          break;
      }
      setState(() {});
    }
    if (counter < 16) {
      for (String r in result) {
        r = r.replaceAll("\"", "");
        if (counter < 16) {
          List<String> s = r.split(" ");
          if (s[0] == text[0] &&
              fieldContent[fieldContent.length - 1].name.trim() != s[2] &&
              !search_in_predictionWords(s[2])) {
            counter++;
            predictionWords.add([s[2], getImageWord(s[2])]);
          }
        } else
          break;
      }
      setState(() {});
    }
    if (counter < 16) {
      if (back) {
        return counter;
      } else {
        return second_word_child(text[1], counter, false);
      }
    }
    // setState(() {});
    return counter;
  }

// old DB
  third_word(List text, int counter, bool back) async {
    String path = await rootBundle.loadString("assets/trigramData.txt");
    List<String> result = path.split('\n');
    for (String r in result) {
      r = r.replaceAll("\"", "");
      if (counter < 16) {
        List<String> s = r.split(" ");
        if (s[0] == text[0] &&
            s[1] == text[1] &&
            fieldContent[fieldContent.length - 1].name.trim() != s[2] &&
            !search_in_predictionWords(s[2])) {
          counter++;
          predictionWords.add([s[2], getImageWord(s[2])]);
        }
      } else
        break;
    }
    setState(() {});
    if (counter < 16) {
      for (String r in result) {
        r = r.replaceAll("\"", "");
        if (counter < 16) {
          List<String> s = r.split(" ");
          if (s[1] == text[1] &&
              fieldContent[fieldContent.length - 1].name.trim() != s[2] &&
              !search_in_predictionWords(s[2])) {
            counter++;
            predictionWords.add([s[2], getImageWord(s[2])]);
          }
        } else
          break;
      }
      setState(() {});
    }
    if (counter < 16) {
      for (String r in result) {
        r = r.replaceAll("\"", "");
        if (counter < 16) {
          List<String> s = r.split(" ");
          if (s[1] == text[1] &&
              fieldContent[fieldContent.length - 1].name.trim() != s[2] &&
              !search_in_predictionWords(s[2])) {
            counter++;
            predictionWords.add([s[2], getImageWord(s[2])]);
          }
        } else
          break;
      }
      setState(() {});
    }

    if (counter < 16) {
      if (back) {
        return counter;
      } else {
        return second_word_child(text[1], counter, false);
      }
    }

    return counter;
  }

  second_word_Local(String text, int counter, bool back) async {
    List<String> result = LocalDB;
    for (String r in result) {
      if (counter < 16) {
        List<String> s = r.split(" ");
        if (s.length >= 2 &&
            s[0] == text &&
            fieldContent[fieldContent.length - 1].name.trim() != s[1] &&
            !search_in_predictionWords(s[1])) {
          counter++;

          predictionWords.add([s[1], getImageWord(s[1].trim())]);
        }
      } else
        break;
    }
    setState(() {});
    if (counter < 16) {
      return second_word_child(text, counter, false);
    }
  }

  second_word_child(String text, int counter, bool back) async {
    String path = await rootBundle.loadString("assets/bigram.txt");
    List<String> result = path.split('\n');

    for (String r in result) {
      r = r.replaceAll("\"", "");

      if (counter < 16) {
        List<String> s = r.split(" ");
        if (s[0] == text &&
            s[1] != fieldContent[fieldContent.length - 1].name.trim() &&
            !search_in_predictionWords(s[1])) {
          counter++;
          predictionWords.add([s[1], getImageWord(s[1].trim())]);
        }
      } else
        break;
    }
    setState(() {});
    if (counter < 16) {
      if (back) {
        return counter;
      } else {
        return one_word_child(text, counter);
      }
    }
    return counter;
  }

  second_word(String text, int counter, bool back) async {
    String path = await rootBundle.loadString("assets/bigramData.txt");
    List<String> result = path.split('\n');

    for (String r in result) {
      r = r.replaceAll("\"", "");

      if (counter < 16) {
        List<String> s = r.split(" ");
        if (s[0] == text && text == s[1] && !search_in_predictionWords(s[1])) {
          counter++;
          predictionWords.add([s[1], getImageWord(s[1].trim())]);
        }
      } else
        break;
    }
    setState(() {});
    if (counter < 16) {
      if (back) {
        return counter;
      } else {
        return one_word_child(text, counter);
      }
    }
    return counter;
  }

  one_word_child(String text, int counter) async {
    String path = await rootBundle.loadString("assets/unigram.txt");
    List<String> result = path.split('\n');
    for (int i = 0; i < 100; i++) {
      Random random = Random();
      int randomIndex = 0 + random.nextInt(20 - 0);
      String word = result[randomIndex].replaceAll("\"", "");
      if (counter < 16 && text != word && !search_in_predictionWords(word)) {
        predictionWords.add([word, getImageWord(word)]);
        counter++;
      }

      if (counter > 16) {
        break;
      }
    }
    setState(() {});
  }
}

String getImageWord(String word) {
  String imurl = "";
  for (int j = 0; j < dataImage.length; j++) {
    dataImage[j][0].forEach((element) {
      if (element.replaceAll("أ", "ا") == word.replaceAll("أ", "ا")) {
        imurl = dataImage[j][1];
      }
    });
    if (imurl != "") {
      break;
    }
  }
  return imurl;
}
