import 'dart:convert';
import 'dart:math';

import '/childpage/child/speakingchildtablet.dart';
import '/childpage/constant.dart';
import '/controller/images.dart';
import '/controller/speak.dart';
import '/controller/uploaddataChild.dart';
import '/controller/var.dart';
import '/model/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/erroralert.dart';
import '../../controller/realtime.dart';
import '../../model/content.dart';

class SpeakingChildPhone extends StatefulWidget {
  const SpeakingChildPhone({super.key});

  @override
  State<SpeakingChildPhone> createState() => _SpeakingChildPhoneState();
}

class _SpeakingChildPhoneState extends State<SpeakingChildPhone> {
  int folderIndex = 0;
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
      ["يمكنني", getImageWord("يمكنني")],
      ["أريد", getImageWord("أريد")],
      ["أحب", getImageWord("أحب")],
      ["أشعر", getImageWord("أشعر")],
      ["أحس", getImageWord("أحس")],
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
      ["عن", getImageWord("عن")],
      ["على", getImageWord("على")],
      ["في", getImageWord("في")],
      ["على", getImageWord("على")],
      ["لم", getImageWord("لم")],
      ["لا", getImageWord("لا")],
      ["قد", getImageWord("قد")],
      ["إلا", getImageWord("إلا")],
      ["بلى", getImageWord("بلى")],
      ["حتى", getImageWord("حتى")],
      ["لن", getImageWord("لن")],
      ["لما", getImageWord("لما")],
      ["ما", getImageWord("ما")],
      ["ثم", getImageWord("ثم")],
      ["و", getImageWord("و")],
    ],
    [
      ["سعيد", getImageWord("سعيد")],
      ["حزين", getImageWord("حزين")],
      ["جوعان", getImageWord("جوعان")],
      ["عطشان", getImageWord("عطشان")],
      ["خائف", getImageWord("خائف")],
      ["رائع", getImageWord("رائع")],
      ["جيد", getImageWord("جيد")],
      ["سهل", getImageWord("سهل")],
      ["صعب", getImageWord("صعب")],
      ["سريع", getImageWord("سريع")],
      ["بطيء", getImageWord("بطيء")],
      ["تعبان", getImageWord("تعبان")],
      ["طويل", getImageWord("طويل")],
      ["قصير", getImageWord("قصير")],
      ["جميل", getImageWord("جميل")],
      ["سيء", getImageWord("سيء")],
    ],
  ];

  late List<List<String>> predictionWords;
  List<Content> fieldContent = [];
  List<Content> constentWord = [];
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
    predictionWords = [
      ["انا", "assets/accept.png"],
      ["هل", "assets/accept.png"],
      ["متى", "assets/accept.png"],
      ["اين", "assets/accept.png"],
      ["كيف", "assets/accept.png"],
      ["كم", "assets/accept.png"],
      ["افتح", "assets/accept.png"],
      ["ممكن", "assets/accept.png"],
      ["طيب", "assets/accept.png"],
      ["السلام", "assets/accept.png"],
      ["أريد", "assets/accept.png"],
      ["لماذا", "assets/accept.png"],
      ["قال", "assets/accept.png"],
      ["نعم", "assets/accept.png"],
      ["مع", "assets/accept.png"],
      ["لكن", "assets/accept.png"],
      ["هو", "assets/accept.png"],
      ["اليوم", "assets/accept.png"],
      ["لقد", "assets/accept.png"],
      ["اشعر", "assets/accept.png"],
      ["انت", "assets/accept.png"],
    ];
    getFavData();
    getLocalDB();
    getdata().then((v) {
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
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .9 -
                              AppBar().preferredSize.height -
                              10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 100,
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        //speak
                                        String a = "";
                                        fieldContent.forEach((element) {
                                          a += element.name + " ";
                                        });

                                        howtospeak(a);

                                        store_In_local(a);
                                        tryUploadToRealTimeForChild(a);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        child: Container(
                                          width: 50,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: maincolor, width: 3),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: FittedBox(
                                            child: Column(children: [
                                              Icon(
                                                Icons.volume_up,
                                                color: maincolor,
                                              ),
                                              Text(
                                                "نطق",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    color: maincolor),
                                              )
                                            ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 3, color: maincolor),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Row(
                                              children: [
                                                FittedBox(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 2, left: 5),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            // clear
                                                            if (fieldContent
                                                                .isNotEmpty) {
                                                              if (fieldContent
                                                                      .length ==
                                                                  1) {
                                                                setState(() {
                                                                  fieldContent =
                                                                      [];
                                                                  isFav = false;
                                                                  predictionWords =
                                                                      [
                                                                    [
                                                                      "انا",
                                                                      "assets/accept.png"
                                                                    ],
                                                                    [
                                                                      "هل",
                                                                      "assets/accept.png"
                                                                    ],
                                                                    [
                                                                      "متى",
                                                                      "assets/accept.png"
                                                                    ],
                                                                    [
                                                                      "اين",
                                                                      "assets/accept.png"
                                                                    ],
                                                                    [
                                                                      "كيف",
                                                                      "assets/accept.png"
                                                                    ],
                                                                    [
                                                                      "بكم",
                                                                      "assets/accept.png"
                                                                    ],
                                                                    [
                                                                      "افتح",
                                                                      "assets/accept.png"
                                                                    ],
                                                                    [
                                                                      "ممكن",
                                                                      "assets/accept.png"
                                                                    ],
                                                                    [
                                                                      "طيب",
                                                                      "assets/accept.png"
                                                                    ],
                                                                    [
                                                                      "السلام",
                                                                      "assets/accept.png"
                                                                    ],
                                                                    [
                                                                      "اعطني",
                                                                      "assets/accept.png"
                                                                    ],
                                                                    [
                                                                      "لماذا",
                                                                      "assets/accept.png"
                                                                    ],
                                                                    [
                                                                      "قال",
                                                                      "assets/accept.png"
                                                                    ],
                                                                    [
                                                                      "نعم",
                                                                      "assets/accept.png"
                                                                    ],
                                                                    [
                                                                      "مع",
                                                                      "assets/accept.png"
                                                                    ],
                                                                    [
                                                                      "لكن",
                                                                      "assets/accept.png"
                                                                    ],
                                                                    [
                                                                      "هو",
                                                                      "assets/accept.png"
                                                                    ],
                                                                    [
                                                                      "اليوم",
                                                                      "assets/accept.png"
                                                                    ],
                                                                    [
                                                                      "لقد",
                                                                      "assets/accept.png"
                                                                    ],
                                                                    [
                                                                      "اشعر",
                                                                      "assets/accept.png"
                                                                    ],
                                                                    [
                                                                      "انت",
                                                                      "assets/accept.png"
                                                                    ],
                                                                  ];
                                                                });
                                                              } else {
                                                                setState(() {
                                                                  fieldContent
                                                                      .removeAt(
                                                                          fieldContent.length -
                                                                              1);
                                                                });
                                                                String text =
                                                                    "";
                                                                fieldContent
                                                                    .forEach(
                                                                        (element) {
                                                                  text += element
                                                                          .name +
                                                                      " ";
                                                                });
                                                                predict(text);
                                                                if (fav.contains(
                                                                    text.trim())) {
                                                                  setState(() {
                                                                    isFav =
                                                                        true;
                                                                  });
                                                                } else {
                                                                  setState(() {
                                                                    isFav =
                                                                        false;
                                                                  });
                                                                }
                                                              }
                                                            }
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 8),
                                                            child: Icon(
                                                              Icons
                                                                  .backspace_outlined,
                                                              color: maincolor,
                                                              size: 30,
                                                            ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            if (fieldContent
                                                                .isNotEmpty) {
                                                              String text = "";
                                                              fieldContent
                                                                  .forEach(
                                                                      (element) {
                                                                text += element
                                                                        .name +
                                                                    " ";
                                                              });
                                                              SharedPreferences
                                                                  favlist =
                                                                  await SharedPreferences
                                                                      .getInstance();
                                                              if (!fav.contains(
                                                                  text.trim())) {
                                                                setState(() {
                                                                  fav.add(text
                                                                      .trim());
                                                                  isFav = true;
                                                                });

                                                                String newFav =
                                                                    "";
                                                                for (int y = 0;
                                                                    y <
                                                                        fieldContent
                                                                            .length;
                                                                    y++) {
                                                                  String input =
                                                                      fieldContent[
                                                                              y]
                                                                          .name;
                                                                  String imurl =
                                                                      fieldContent[
                                                                              y]
                                                                          .imgurl;
                                                                  String
                                                                      isimup =
                                                                      fieldContent[
                                                                              y]
                                                                          .isImageUpload;
                                                                  String
                                                                      voiceurl =
                                                                      fieldContent[
                                                                              y]
                                                                          .opvoice;
                                                                  String
                                                                      voiceCache =
                                                                      fieldContent[
                                                                              y]
                                                                          .cacheVoicePath;
                                                                  String
                                                                      isvoiceUp =
                                                                      fieldContent[
                                                                              y]
                                                                          .isVoiceUpload;

                                                                  if (y ==
                                                                      fieldContent
                                                                              .length -
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
                                                                var temp = favlist
                                                                    .getStringList(
                                                                        "favlistChild");
                                                                if (temp ==
                                                                    null) {
                                                                  favChildList =
                                                                      [newFav];
                                                                } else {
                                                                  favChildList =
                                                                      temp;
                                                                  favChildList
                                                                      .add(
                                                                          newFav);
                                                                }
                                                                favlist.setStringList(
                                                                    "favlistChild",
                                                                    favChildList);
                                                              } else {
                                                                fav.remove(text
                                                                    .trim());
                                                                setState(() {
                                                                  isFav = false;
                                                                });
                                                                List<String> v =
                                                                    favlist.getStringList(
                                                                            "favlistChild") ??
                                                                        [];
                                                                List favChild =
                                                                    [];
                                                                v.forEach(
                                                                    (element) {
                                                                  favChild.add(
                                                                      json.decode(
                                                                          element));
                                                                });

                                                                favChild
                                                                    .removeWhere(
                                                                        (element) {
                                                                  if (element
                                                                          .length !=
                                                                      fieldContent
                                                                          .length) {
                                                                    return false;
                                                                  } else {
                                                                    bool sam =
                                                                        true;
                                                                    for (int o =
                                                                            0;
                                                                        o < element.length;
                                                                        o++) {
                                                                      if (element[o]
                                                                              [
                                                                              0] !=
                                                                          fieldContent[o]
                                                                              .name) {
                                                                        sam =
                                                                            false;
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
                                                          child: isFav
                                                              ? Icon(
                                                                  Icons.star,
                                                                  color:
                                                                      maincolor,
                                                                  size: 30,
                                                                )
                                                              : Icon(
                                                                  Icons
                                                                      .star_outline_rounded,
                                                                  size: 30,
                                                                  color:
                                                                      maincolor),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: ListView(
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
                                                            ? Container(
                                                                child:
                                                                    FittedBox(
                                                                  child: Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              50,
                                                                          width:
                                                                              50,
                                                                        ),
                                                                        Text(
                                                                          fieldContent[i]
                                                                              .name,
                                                                          style: TextStyle(
                                                                              fontSize: 25,
                                                                              fontWeight: FontWeight.w900,
                                                                              color: maincolor),
                                                                        )
                                                                      ]),
                                                                ),
                                                              )
                                                            : Container(
                                                                child:
                                                                    FittedBox(
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5),
                                                                    child: Column(
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                50,
                                                                            width:
                                                                                50,
                                                                            child:
                                                                                getImage(fieldContent[i].imgurl),
                                                                          ),
                                                                          Text(
                                                                            fieldContent[i].name,
                                                                            style: TextStyle(
                                                                                fontSize: 20,
                                                                                fontWeight: FontWeight.w900,
                                                                                color: maincolor),
                                                                          )
                                                                        ]),
                                                                  ),
                                                                ),
                                                              ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 10),
                                                        child: SizedBox(
                                                          width: 300,
                                                          child: Center(
                                                            child: TextField(
                                                              controller:
                                                                  controller,
                                                              cursorColor:
                                                                  maincolor,
                                                              onTap: () {
                                                                controller
                                                                        .selection =
                                                                    TextSelection.fromPosition(TextPosition(
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
                                                                } else if (fieldContent
                                                                    .isEmpty) {
                                                                  setState(() {
                                                                    predictionWords =
                                                                        [
                                                                      [
                                                                        "انا",
                                                                        "assets/accept.png"
                                                                      ],
                                                                      [
                                                                        "هل",
                                                                        "assets/accept.png"
                                                                      ],
                                                                      [
                                                                        "متى",
                                                                        "assets/accept.png"
                                                                      ],
                                                                      [
                                                                        "اين",
                                                                        "assets/accept.png"
                                                                      ],
                                                                      [
                                                                        "كيف",
                                                                        "assets/accept.png"
                                                                      ],
                                                                      [
                                                                        "بكم",
                                                                        "assets/accept.png"
                                                                      ],
                                                                      [
                                                                        "افتح",
                                                                        "assets/accept.png"
                                                                      ],
                                                                      [
                                                                        "ممكن",
                                                                        "assets/accept.png"
                                                                      ],
                                                                      [
                                                                        "طيب",
                                                                        "assets/accept.png"
                                                                      ],
                                                                      [
                                                                        "السلام",
                                                                        "assets/accept.png"
                                                                      ],
                                                                      [
                                                                        "اعطني",
                                                                        "assets/accept.png"
                                                                      ],
                                                                      [
                                                                        "لماذا",
                                                                        "assets/accept.png"
                                                                      ],
                                                                      [
                                                                        "قال",
                                                                        "assets/accept.png"
                                                                      ],
                                                                      [
                                                                        "نعم",
                                                                        "assets/accept.png"
                                                                      ],
                                                                      [
                                                                        "مع",
                                                                        "assets/accept.png"
                                                                      ],
                                                                      [
                                                                        "لكن",
                                                                        "assets/accept.png"
                                                                      ],
                                                                      [
                                                                        "هو",
                                                                        "assets/accept.png"
                                                                      ],
                                                                      [
                                                                        "اليوم",
                                                                        "assets/accept.png"
                                                                      ],
                                                                      [
                                                                        "لقد",
                                                                        "assets/accept.png"
                                                                      ],
                                                                      [
                                                                        "اشعر",
                                                                        "assets/accept.png"
                                                                      ],
                                                                      [
                                                                        "انت",
                                                                        "assets/accept.png"
                                                                      ],
                                                                    ];
                                                                  });
                                                                }
                                                              },
                                                              cursorWidth: 4,
                                                              style: TextStyle(
                                                                  fontSize: 35,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900),
                                                              decoration:
                                                                  InputDecoration(
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
                                              ],
                                            ))),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          fieldContent = [];
                                          predictionWords = [
                                            ["انا", "assets/accept.png"],
                                            ["هل", "assets/accept.png"],
                                            ["متى", "assets/accept.png"],
                                            ["اين", "assets/accept.png"],
                                            ["كيف", "assets/accept.png"],
                                            ["كم", "assets/accept.png"],
                                            ["افتح", "assets/accept.png"],
                                            ["ممكن", "assets/accept.png"],
                                            ["طيب", "assets/accept.png"],
                                            ["السلام", "assets/accept.png"],
                                            ["أريد", "assets/accept.png"],
                                            ["لماذا", "assets/accept.png"],
                                            ["قال", "assets/accept.png"],
                                            ["نعم", "assets/accept.png"],
                                            ["مع", "assets/accept.png"],
                                            ["لكن", "assets/accept.png"],
                                            ["هو", "assets/accept.png"],
                                            ["اليوم", "assets/accept.png"],
                                            ["لقد", "assets/accept.png"],
                                            ["اشعر", "assets/accept.png"],
                                            ["انت", "assets/accept.png"],
                                          ];
                                        });

                                        controller.clear();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        child: Container(
                                          width: 50,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: maincolor, width: 3),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: FittedBox(
                                            child: Column(children: [
                                              Icon(
                                                Icons.delete,
                                                color: maincolor,
                                              ),
                                              Text(
                                                "حذف",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    color: maincolor),
                                              )
                                            ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 10,
                              ),
                              Container(
                                child: FittedBox(
                                  child: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
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
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            predictionWords.length >= 1
                                                ? box(0)
                                                : Container(
                                                    height: 120,
                                                    width: 120,
                                                  ),
                                            predictionWords.length >= 2
                                                ? box(1)
                                                : Container(
                                                    height: 120,
                                                    width: 120,
                                                  ),
                                            predictionWords.length >= 3
                                                ? box(2)
                                                : Container(
                                                    height: 120,
                                                    width: 120,
                                                  ),
                                            predictionWords.length >= 4
                                                ? box(3)
                                                : Container(
                                                    height: 120,
                                                    width: 120,
                                                  ),
                                            predictionWords.length >= 5
                                                ? box(4)
                                                : Container(
                                                    height: 120,
                                                    width: 120,
                                                  ),
                                            predictionWords.length >= 6
                                                ? box(5)
                                                : Container(
                                                    height: 120,
                                                    width: 120,
                                                  ),
                                            predictionWords.length >= 7
                                                ? box(6)
                                                : Container(
                                                    height: 120,
                                                    width: 120,
                                                  )
                                          ],
                                        ),
                                ),
                              ),
                              Container(
                                height: 10,
                              ),
                              Container(
                                child: FittedBox(
                                  child: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
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
                                            ])
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            predictionWords.length >= 8
                                                ? box(7)
                                                : Container(
                                                    height: 100,
                                                    width: 100,
                                                  ),
                                            predictionWords.length >= 9
                                                ? box(8)
                                                : Container(
                                                    height: 100,
                                                    width: 100,
                                                  ),
                                            predictionWords.length >= 10
                                                ? box(9)
                                                : Container(
                                                    height: 100,
                                                    width: 100,
                                                  ),
                                            predictionWords.length >= 11
                                                ? box(10)
                                                : Container(
                                                    height: 100,
                                                    width: 100,
                                                  ),
                                            predictionWords.length >= 12
                                                ? box(11)
                                                : Container(
                                                    height: 100,
                                                    width: 100,
                                                  ),
                                            predictionWords.length >= 13
                                                ? box(12)
                                                : Container(
                                                    height: 100,
                                                    width: 100,
                                                  ),
                                            predictionWords.length >= 14
                                                ? box(13)
                                                : Container(
                                                    height: 100,
                                                    width: 100,
                                                  ),
                                          ],
                                        ),
                                ),
                              ),
                              MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? Container(
                                      height: 10,
                                    )
                                  : Container(),
                              MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? Container(
                                      child: FittedBox(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            predictionWords.length >= 9
                                                ? box(8)
                                                : Container(
                                                    height: 100,
                                                    width: 100,
                                                  ),
                                            predictionWords.length >= 10
                                                ? box(9)
                                                : Container(
                                                    height: 100,
                                                    width: 100,
                                                  ),
                                            predictionWords.length >= 11
                                                ? box(10)
                                                : Container(
                                                    height: 100,
                                                    width: 100,
                                                  ),
                                            predictionWords.length >= 12
                                                ? box(11)
                                                : Container(
                                                    height: 100,
                                                    width: 100,
                                                  ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                              constentWord.isNotEmpty
                                  ? Container(
                                      height: 150,
                                      child: Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              for (int i = 0;
                                                  i < constentWord.length;
                                                  i++)
                                                InkWell(
                                                  onTap: () {
                                                    if (speakingWordByWord) {
                                                      howtospeak(
                                                          constentWord[i].name);
                                                    }
                                                    setState(() {
                                                      fieldContent.add(
                                                        constentWord[i],
                                                      );
                                                    });
                                                    String text = "";
                                                    fieldContent
                                                        .forEach((element) {
                                                      text +=
                                                          element.name + " ";
                                                    });
                                                    predict(text.trim());
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      width: 140,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: maincolor,
                                                              width: 3),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Column(children: [
                                                        Expanded(
                                                          flex: 3,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              width: 150,
                                                              child: getImage(
                                                                  constentWord[
                                                                          i]
                                                                      .imgurl),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            constentWord[i]
                                                                .name,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                color:
                                                                    maincolor),
                                                          ),
                                                        ),
                                                      ]),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                constentWord = [];
                                              });
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: Colors.grey),
                                              child: Icon(
                                                Icons.close,
                                                size: 40,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        Container(
                                          height: 10,
                                        ),
                                        Container(
                                          child: FittedBox(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                boxConstant(0),
                                                boxConstant(1),
                                                boxConstant(2),
                                                boxConstant(3),
                                                //boxConstant(4),
                                                MediaQuery.of(context)
                                                            .orientation !=
                                                        Orientation.portrait
                                                    ? boxConstant(5)
                                                    : Container(),
                                                MediaQuery.of(context)
                                                            .orientation !=
                                                        Orientation.portrait
                                                    ? boxConstant(6)
                                                    : Container(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              constentWord.isNotEmpty
                                  ? Container()
                                  : Container(
                                      height: 15,
                                    ),
                              Container(
                                height: 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                      child: Container(
                                        height: 40,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 3, color: maincolor),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(40)),
                                        child: Center(
                                            child: Icon(
                                          Icons.arrow_back,
                                          size: 35,
                                          color: maincolor,
                                        )),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .8,
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

                                            controllerList.jumpTo((130.0 *
                                                libraryListChild.length));
                                          });
                                        }
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: maincolor, width: 3),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(40)),
                                        child: Center(
                                            child: Icon(
                                          Icons.arrow_forward,
                                          size: 35,
                                          color: maincolor,
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }

  autoComplete(String v) async {
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
        predict(text);
        controller.clear();
      }
    }
    if (isautoComplete) {
      v = v.trim();
      if (v.length != 0) {
        predictionWords = [];
        int leng = v.length;
        for (String element in LocalDB) {
          element = element.replaceAll("  ", " ");
          List<String> Sentence = element.trim().split(" ");

          Sentence.forEach((w) {
            if (w.length > leng) {
              if (w.substring(0, leng) == v) {
                if (!search_in_predictionWords(w)) {
                  predictionWords.removeWhere((element) => element[0] == w);
                  predictionWords.add([w, "assets/accept.png"]);
                }
              }
            }
          });
          if (predictionWords.length >= 14) break;
        }
        if (predictionWords.length < 14) {
          String path1 = await rootBundle.loadString("assets/oneWord.txt");
          List<String> result = path1.split('\n');
          for (int i = 0; i < result.length; i++) {
            result[i] = result[i].replaceAll("\"", "").trim();
            int searchLenght = v.trim().length;
            String word = result[i];
            if (word.length > v.trim().length) {
              if (word.substring(0, searchLenght) == v.trim()) {
                if (!search_in_predictionWords(word)) {
                  predictionWords.add([word, "assets/accept.png"]);
                }
              }
            }
            if (predictionWords.length >= 14) break;
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
        predict(text);
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
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Container(
          width: MediaQuery.of(context).orientation == Orientation.portrait
              ? 140
              : 120,
          height: MediaQuery.of(context).orientation == Orientation.portrait
              ? 140
              : 120,
          decoration: BoxDecoration(
              border: Border.all(color: maincolor, width: 3),
              borderRadius: BorderRadius.circular(20)),
          child: FittedBox(
            child: Column(children: [
              Container(
                height: 140,
                width: 140,
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
      if (predictionWords[i][0] == word) {
        return true;
      }
    }
    return false;
  }

  search_in_constant(String word) {
    int a = MediaQuery.of(context).orientation != Orientation.portrait ? 5 : 7;
    for (int i = 0; i < a; i++) {
      if (constant[i][0] == word) {
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

    if (counter < 14) {
      for (int i = text.length - 1; i > 0; i--) {
        list = [text[i - 1], text[i]];

        counter = await third_word_child(list, counter, true);
      }
    }
    if (counter < 14) {
      for (int i = text.length - 1; i > -1; i--) {
        counter = await second_word_child(text[i], counter, true);
      }
    }
    if (counter < 14) {
      one_word_child(text[text.length - 1], counter);
    }
  }

  fifth_word(List text, int counter, bool back) async {
    List<String> list = [text[1], text[2], text[3]];
    if (counter < 14) {
      counter = await fourth_word_Local(list, counter, true);
    }
    if (counter < 14) {
      counter = await fourth_word_child(list, counter, true);
    }
    if (counter < 14) {
      list = [text[0], text[1], text[2]];
      counter = await fourth_word_child(list, counter, true);
    }
    if (counter < 14) {
      if (back) {
        return counter;
      } else {
        list = [text[2], text[3]];
        counter = await third_word_Local(list, counter, true);
        if (counter < 14) {
          counter = await third_word_child(list, counter, true);
        }
        if (counter < 14) {
          list = [text[1], text[2]];
          counter = await third_word_child(list, counter, true);
        }
        if (counter < 14) {
          list = [text[0], text[1]];
          counter = await third_word_child(list, counter, true);
        }
        if (counter < 14) {
          counter = await second_word_child(text[3], counter, true);
        }
        if (counter < 14) {
          counter = await second_word_child(text[2], counter, true);
        }
        if (counter < 14) {
          counter = await second_word(text[1], counter, true);
        }
        if (counter < 14) {
          second_word(text[0], counter, false);
        }
      }
    }
    return counter;
  }

  fourth_word_Local(List text, int counter, bool back) async {
    List<String> result = LocalDB;
    for (String r in result) {
      if (counter < 14) {
        List<String> s = r.split(" ");
        for (int i = 0; i < s.length; i++) {
          if (s[i] == text[0]) {
            if (s.length - i >= 4 &&
                s[i] == text[0] &&
                s[i + 1] == text[1] &&
                s[i + 2] == text[2] &&
                fieldContent[fieldContent.length - 1].name.trim() != s[i + 3] &&
                !search_in_constant(s[i + 3]) &&
                !search_in_predictionWords(s[i + 3])) {
              counter++;
              predictionWords.add([s[i + 3], "assets/accept.png"]);
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
    if (counter < 14) {
      for (String r in result) {
        if (counter < 14) {
          List<String> s = r.split(" ");
          for (int i = 0; i < s.length; i++) {
            if (s[i] == text[0]) {
              if (s.length - i >= 4 &&
                  s[i] == text[0] &&
                  s[i + 1] == text[1] &&
                  fieldContent[fieldContent.length - 1].name.trim() !=
                      s[i + 3] &&
                  !search_in_constant(s[i + 3]) &&
                  !search_in_predictionWords(s[i + 3])) {
                counter++;
                predictionWords.add([s[i + 3], "assets/accept.png"]);
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
    String path = await rootBundle.loadString("assets/fourgram_new.txt");
    List<String> result = path.split('\n');

    for (String r in result) {
      r = r.replaceAll("\"", "");
      if (counter < 14) {
        List<String> s = r.split(" ");
        if (s[0].compareTo(text[0]) == 0 &&
            s[1].compareTo(text[1]) == 0 &&
            s[2].compareTo(text[2]) == 0 &&
            s[3].compareTo(fieldContent[fieldContent.length - 1].name.trim()) !=
                0 &&
            !search_in_predictionWords(s[3]) &&
            !search_in_constant(s[3])) {
          counter++;
          predictionWords.add([s[3], "assets/accept.png"]);
        }
      } else
        break;
    }
    setState(() {});
    if (counter < 14) {
      for (String r in result) {
        r = r.replaceAll("\"", "");
        if (counter < 14) {
          List<String> s = r.split(" ");
          if (s[1].compareTo(text[1]) == 0 &&
              s[2].compareTo(text[2]) == 0 &&
              s[3].compareTo(
                      fieldContent[fieldContent.length - 1].name.trim()) !=
                  0 &&
              !search_in_predictionWords(s[3]) &&
              !search_in_constant(s[3])) {
            counter++;
            predictionWords.add([s[3], "assets/accept.png"]);
          }
        } else
          break;
      }
      setState(() {});
    }
    if (counter < 14) {
      for (String r in result) {
        r = r.replaceAll("\"", "");
        if (counter < 14) {
          List<String> s = r.split(" ");
          if (s[0].compareTo(text[0]) == 0 &&
              s[1].compareTo(text[1]) == 0 &&
              s[3].compareTo(
                      fieldContent[fieldContent.length - 1].name.trim()) !=
                  0 &&
              !search_in_predictionWords(s[3]) &&
              !search_in_constant(s[3])) {
            counter++;
            String word = s[3];
            predictionWords.add(['$word', "assets/accept.png"]);
          }
        } else
          break;
      }
      setState(() {});
    }
    if (counter < 14) {
      for (String r in result) {
        r = r.replaceAll("\"", "");
        if (counter < 14) {
          List<String> s = r.split(" ");
          if (s[0].compareTo(text[0]) == 0 &&
              s[1].compareTo(text[2]) == 0 &&
              s[3].compareTo(
                      fieldContent[fieldContent.length - 1].name.trim()) !=
                  0 &&
              !search_in_predictionWords(s[3]) &&
              !search_in_constant(s[3])) {
            counter++;
            predictionWords.add([s[3], "assets/accept.png"]);
          }
        } else
          break;
      }
      setState(() {});
    }
    if (counter < 14) {
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

      if (counter < 14) {
        List<String> s = r.split(" ");
        if (s[0] == text[0] &&
            s[1] == text[1] &&
            s[2] == text[2] &&
            fieldContent[fieldContent.length - 1].name.trim() != s[3] &&
            !search_in_predictionWords(s[3]) &&
            !search_in_constant(s[3])) {
          counter++;
          String word = s[3];
          predictionWords.add(['fourth1: $word', "assets/accept.png"]);
        }
      } else
        break;
    }
    setState(() {});
    if (counter < 14) {
      for (String r in result) {
        r = r.replaceAll("\"", "");

        if (counter < 14) {
          List<String> s = r.split(" ");
          if (s[1] == text[1] &&
              s[2] == text[2] &&
              fieldContent[fieldContent.length - 1].name.trim() != s[3] &&
              !search_in_predictionWords(s[3]) &&
              !search_in_constant(s[3])) {
            counter++;
            String word = s[3];
            predictionWords.add(['fourth2: $word', "assets/accept.png"]);
          }
        } else
          break;
      }
      setState(() {});
    }
    if (counter < 14) {
      for (String r in result) {
        r = r.replaceAll("\"", "");
        if (counter < 14) {
          List<String> s = r.split(" ");
          if (s[0] == text[0] &&
              s[1] == text[1] &&
              fieldContent[fieldContent.length - 1].name.trim() != s[3] &&
              !search_in_predictionWords(s[3]) &&
              !search_in_constant(s[3])) {
            counter++;
            String word = s[3];
            predictionWords.add(['fourth3: $word', "assets/accept.png"]);
          }
        } else
          break;
      }
      setState(() {});
    }
    if (counter < 14) {
      for (String r in result) {
        r = r.replaceAll("\"", "");

        if (counter < 14) {
          List<String> s = r.split(" ");
          if (s[0] == text[0] &&
              s[1] == text[2] &&
              fieldContent[fieldContent.length - 1].name.trim() != s[3] &&
              !search_in_predictionWords(s[3]) &&
              !search_in_constant(s[3])) {
            counter++;
            String word = s[3];
            predictionWords.add(['fourth4: $word', "assets/accept.png"]);
          }
        } else
          break;
      }
      setState(() {});
    }
    if (counter < 14) {
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
      if (counter < 14) {
        List<String> s = r.split(" ");
        for (int i = 0; i < s.length; i++) {
          if (s[i] == text[0]) {
            if (s.length - i >= 3 &&
                s[i + 1] == text[1] &&
                s[i + 2] != fieldContent[fieldContent.length - 1].name.trim() &&
                !search_in_constant(s[i + 2]) &&
                !search_in_predictionWords(s[i + 2])) {
              counter++;
              predictionWords.add([s[i + 2], "assets/accept.png"]);
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
    String path = await rootBundle.loadString("assets/trigram_new.txt");
    List<String> result = path.split('\n');
    for (String r in result) {
      r = r.replaceAll("\"", "");
      if (counter < 14) {
        List<String> s = r.split(" ");
        if (s[0] == text[0] &&
            s[1] == text[1] &&
            s[2] != fieldContent[fieldContent.length - 1].name.trim() &&
            !search_in_predictionWords(s[2]) &&
            !search_in_constant(s[2])) {
          counter++;
          predictionWords.add([s[2], "assets/accept.png"]);
        }
      } else
        break;
    }
    setState(() {});
    if (counter < 14) {
      for (String r in result) {
        r = r.replaceAll("\"", "");
        if (counter < 14) {
          List<String> s = r.split(" ");
          if (s[1] == text[1] &&
              fieldContent[fieldContent.length - 1].name.trim() != s[2] &&
              !search_in_predictionWords(s[2]) &&
              !search_in_constant(s[2])) {
            counter++;
            predictionWords.add([s[2], "assets/accept.png"]);
          }
        } else
          break;
      }
      setState(() {});
    }
    if (counter < 14) {
      for (String r in result) {
        r = r.replaceAll("\"", "");
        if (counter < 14) {
          List<String> s = r.split(" ");
          if (s[0] == text[0] &&
              fieldContent[fieldContent.length - 1].name.trim() != s[2] &&
              !search_in_predictionWords(s[2]) &&
              !search_in_constant(s[2])) {
            counter++;
            predictionWords.add([s[2], "assets/accept.png"]);
          }
        } else
          break;
      }
      setState(() {});
    }
    if (counter < 14) {
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
      if (counter < 14) {
        List<String> s = r.split(" ");
        if (s[0] == text[0] &&
            s[1] == text[1] &&
            fieldContent[fieldContent.length - 1].name.trim() != s[2] &&
            !search_in_predictionWords(s[2]) &&
            !search_in_constant(s[2])) {
          counter++;
          predictionWords.add([s[2], "assets/accept.png"]);
        }
      } else
        break;
    }
    setState(() {});
    if (counter < 14) {
      for (String r in result) {
        r = r.replaceAll("\"", "");
        if (counter < 14) {
          List<String> s = r.split(" ");
          if (s[1] == text[1] &&
              fieldContent[fieldContent.length - 1].name.trim() != s[2] &&
              !search_in_predictionWords(s[2]) &&
              !search_in_constant(s[2])) {
            counter++;
            predictionWords.add([s[2], "assets/accept.png"]);
          }
        } else
          break;
      }
      setState(() {});
    }
    if (counter < 14) {
      for (String r in result) {
        r = r.replaceAll("\"", "");
        if (counter < 14) {
          List<String> s = r.split(" ");
          if (s[1] == text[1] &&
              fieldContent[fieldContent.length - 1].name.trim() != s[2] &&
              !search_in_predictionWords(s[2]) &&
              !search_in_constant(s[2])) {
            counter++;
            predictionWords.add([s[2], "assets/accept.png"]);
          }
        } else
          break;
      }
      setState(() {});
    }

    if (counter < 14) {
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
      if (counter < 14) {
        List<String> s = r.split(" ");
        if (s.length >= 2 &&
            s[0] == text &&
            fieldContent[fieldContent.length - 1].name.trim() != s[1] &&
            !search_in_constant(text) &&
            !search_in_predictionWords(s[1])) {
          counter++;

          predictionWords.add([s[1], "assets/accept.png"]);
        }
      } else
        break;
    }
    setState(() {});
    if (counter < 14) {
      return second_word_child(text, counter, false);
    }
  }

  second_word_child(String text, int counter, bool back) async {
    String path = await rootBundle.loadString("assets/bigram_new.txt");
    List<String> result = path.split('\n');

    for (String r in result) {
      r = r.replaceAll("\"", "");

      if (counter < 14) {
        List<String> s = r.split(" ");
        if (s[0] == text &&
            s[1] != fieldContent[fieldContent.length - 1].name.trim() &&
            !search_in_predictionWords(s[1]) &&
            !search_in_constant(s[1])) {
          counter++;
          predictionWords.add([s[1], "assets/accept.png"]);
        }
      } else
        break;
    }
    setState(() {});
    if (counter < 14) {
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
      if (counter < 14) {
        List<String> s = r.split(" ");
        if (s[0] == text &&
            text == s[1] &&
            !search_in_predictionWords(s[1]) &&
            !search_in_constant(s[1])) {
          counter++;
          predictionWords.add([s[1], "assets/accept.png"]);
        }
      } else
        break;
    }
    setState(() {});
    if (counter < 14) {
      if (back) {
        return counter;
      } else {
        return one_word_child(text, counter);
      }
    }
    return counter;
  }

  one_word_child(String text, int counter) async {
    String path = await rootBundle.loadString("assets/unigram_new.txt");
    List<String> result = path.split('\n');
    for (int i = 0; i < 100; i++) {
      Random random = Random();
      int randomIndex = 0 + random.nextInt(6091 - 0);
      String word = result[randomIndex].replaceAll("\"", "");
      if (counter < 14 &&
          text != word &&
          !search_in_predictionWords(word) &&
          !search_in_constant(word)) {
        predictionWords.add([word, "assets/accept.png"]);
        counter++;
      }

      if (counter >= 14) {
        break;
      }
    }
    setState(() {});
  }

  boxConstant(int index) {
    return InkWell(
      onTap: () {
        if (speakingWordByWord) {
          howtospeak(constant[folderIndex][index][0]);
        }

        setState(() {
          fieldContent.add(
            Content(constant[folderIndex][index][0],
                constant[folderIndex][index][1], "yes", "", "", "yes"),
          );
        });

        String text = "";
        fieldContent.forEach((element) {
          text += element.name + " ";
        });
        predict(text);
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
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Container(
          width: MediaQuery.of(context).orientation == Orientation.portrait
              ? 140
              : 120,
          height: MediaQuery.of(context).orientation == Orientation.portrait
              ? 140
              : 120,
          decoration: BoxDecoration(
              border: Border.all(color: maincolor, width: 3),
              borderRadius: BorderRadius.circular(20)),
          child: FittedBox(
            child: Column(children: [
              Container(
                height: 140,
                width: 140,
                child: getImage(constant[folderIndex][index][1]),
              ),
              Text(
                constant[folderIndex][index][0],
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: maincolor),
              )
            ]),
          ),
        ),
      ),
    );
  }

  box2(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          constentWord = libraryListChild[index].contenlist;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            width: 100,
            decoration: BoxDecoration(
                color: maincolor,
                border: Border.all(color: maincolor, width: 3),
                borderRadius: BorderRadius.only(topRight: Radius.circular(30))),
            child: Center(
              child: FittedBox(
                child: Text(
                  libraryListChild[index].name,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
              ),
            )),
      ),
    );
  }
}
