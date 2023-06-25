import 'dart:convert';
import 'package:arabic_speaker_child/childpage/parent/addContentChild.dart';
import 'package:arabic_speaker_child/childpage/parent/rearrangeContentChild.dart';
import 'package:arabic_speaker_child/childpage/parent/rearrangeLib.dart';

import '../../view/export_and_import/import.dart';
import '../../controller/constantLibraryChild.dart';

import 'package:arabic_speaker_child/childpage/parent/mainparent.dart';
import 'package:arabic_speaker_child/controller/editWordLibrary.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/allUploadedDone.dart';
import '../../controller/checkinternet.dart';
import '../../controller/erroralert.dart';
import '../../controller/images.dart';
import '../../controller/istablet.dart';
import '../../controller/libtostring.dart';
import '../../controller/my_provider.dart';
import '../../controller/uploaddataChild.dart';
import '../../controller/var.dart';
import '../../icon/iconsgroup.dart';
import '../../model/content.dart';
import '../../model/filesContent.dart';
import '../../model/library.dart';
import '../child/speakingchildtablet.dart';
import 'addlibraryChild.dart';
import 'deleteLibrary.dart';
import 'export.dart';

class settingLibrary_tablet extends StatefulWidget {
  const settingLibrary_tablet({super.key});

  @override
  State<settingLibrary_tablet> createState() => _settingLibrary_tablet();
}

bool isloading = true;

List<Content> contentWord = [];

final controllerList = ScrollController();
double currentOffsetScroll = 0;
List isSelected = [];
int libraryOpen = 0;
final contentWordController = ScrollController();
late List<List<String>> predictionWords;

int isSelectedIndex = -1;
bool isLess = false;

bool selectedAvaiabel = true;

bool isSelectedForDelete = true;
final controllerList2 = ScrollController();

TextEditingController controller = TextEditingController();
int coloredOpenLibraryindex = 0;

class _settingLibrary_tablet extends State<settingLibrary_tablet> {
  @override
  @override
  void initState() {
    contentWord =
        libraryListChild.isNotEmpty ? libraryListChild[0].contenlist : [];

    getdata().then((v) {
      setState(() {
        coloredOpenLibraryindex = 0;
        isloading = false;
      });
      getworddata().then((v) {
        setState(() {
          isloading = false;
        });
      });
    });

    super.initState();
  }

  getdata() async {
    List<List<String>> p = [];
    for (var element in librarywordChild[0].contenlist) {
      p.add([element.name, element.imgurl]);
    }
    predictionWords = p;
    //////////
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

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Text(
                  "تعديل المكتبات",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: purcolor,
                      fontSize: DeviceUtil.isTablet ? 45 : 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 40,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 8),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(width: 2, color: greyColor)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 8, right: 8, bottom: 15),
                          child: MediaQuery.of(context).orientation !=
                                  Orientation.portrait
                              ? Column(
                                  children: [
                                    Expanded(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        predictionWords.isNotEmpty
                                            ? box(0)
                                            : const SizedBox(
                                                height: 140,
                                                width: 140,
                                              ),
                                        predictionWords.length >= 2
                                            ? box(1)
                                            : const SizedBox(
                                                height: 140,
                                                width: 140,
                                              ),
                                        predictionWords.length >= 3
                                            ? box(2)
                                            : const SizedBox(
                                                height: 140,
                                                width: 140,
                                              ),
                                        predictionWords.length >= 4
                                            ? box(3)
                                            : const SizedBox(
                                                height: 140,
                                                width: 140,
                                              ),
                                        predictionWords.length >= 5
                                            ? box(4)
                                            : const SizedBox(
                                                height: 140,
                                                width: 140,
                                              ),
                                        InkWell(
                                          onTap: () {
                                            List<List<String>> con = [];
                                            for (var element
                                                in librarywordChild[3]
                                                    .contenlist) {
                                              con.add([
                                                element.name,
                                                element.imgurl
                                              ]);
                                            }
                                            setState(() {
                                              predictionWords = con;
                                            });
                                          },
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 7),
                                            child: Container(
                                              width: size == 0 ? 125 : 120,
                                              decoration: BoxDecoration(
                                                  color: const Color(0xff1367A2)
                                                      .withOpacity(.6),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: const Center(
                                                child: Text(
                                                  "صفات",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 30),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            List<List<String>> main = [];
                                            for (var element
                                                in librarywordChild[0]
                                                    .contenlist) {
                                              main.add([
                                                element.name,
                                                element.imgurl
                                              ]);
                                            }
                                            setState(() {
                                              predictionWords = main;
                                            });
                                          },
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 7),
                                            child: Container(
                                              width: size == 0 ? 125 : 120,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffC06FB9),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: const Center(
                                                child: Text(
                                                  "الرئيسية",
                                                  textAlign: TextAlign.center,
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
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        predictionWords.length >= 6
                                            ? box(5)
                                            : const SizedBox(
                                                height: 140,
                                                width: 140,
                                              ),
                                        predictionWords.length >= 7
                                            ? box(6)
                                            : const SizedBox(
                                                height: 140,
                                                width: 140,
                                              ),
                                        predictionWords.length >= 8
                                            ? box(7)
                                            : const SizedBox(
                                                height: 140,
                                                width: 140,
                                              ),
                                        predictionWords.length >= 9
                                            ? box(8)
                                            : const SizedBox(
                                                height: 140,
                                                width: 140,
                                              ),
                                        predictionWords.length >= 10
                                            ? box(9)
                                            : const SizedBox(
                                                height: 140,
                                                width: 140,
                                              ),
                                        InkWell(
                                          onTap: () {
                                            List<List<String>> letters = [];
                                            for (var element
                                                in librarywordChild[2]
                                                    .contenlist) {
                                              letters.add([
                                                element.name,
                                                element.imgurl
                                              ]);
                                            }
                                            setState(() {
                                              predictionWords = letters;
                                            });
                                          },
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 7),
                                            child: Container(
                                              width: size == 0 ? 125 : 120,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffE9E467),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: const Center(
                                                child: Text(
                                                  "حروف",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 30),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            List<List<String>> verbs = [];
                                            for (var element
                                                in librarywordChild[1]
                                                    .contenlist) {
                                              verbs.add([
                                                element.name,
                                                element.imgurl
                                              ]);
                                            }
                                            setState(() {
                                              predictionWords = verbs;
                                            });
                                          },
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 7),
                                            child: Container(
                                              width: size == 0 ? 125 : 120,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffA7CB89),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: const Center(
                                                child: Text(
                                                  "أفعال",
                                                  textAlign: TextAlign.center,
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
                                    ))
                                  ],
                                )

                              //هنا هنا هنا هنا هنا هنا الله يسهل
                              : Column(
                                  children: [
                                    Container(
                                      height: size == 0 ? 0 : 5,
                                    ),
                                    Expanded(
                                        //هنا الي ابيه
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        box(0),
                                        box(1),
                                        box(2),
                                        box(3),
                                        Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  List<List<String>> main = [];
                                                  for (var element
                                                      in librarywordChild[0]
                                                          .contenlist) {
                                                    main.add([
                                                      element.name,
                                                      element.imgurl
                                                    ]);
                                                  }
                                                  setState(() {
                                                    libraryOpen = 0;
                                                    predictionWords = main;
                                                  });
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 7),
                                                  child: Container(
                                                    width:
                                                        size == 0 ? 133 : 120,
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xffC06FB9),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                    child: const Center(
                                                      child: Text(
                                                        "الرئيسية",
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
                                              ),
                                            ])
                                      ],
                                    )),
                                    Container(
                                      height: 7,
                                    ),
                                    Expanded(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        box(4),
                                        box(5),
                                        box(6),
                                        box(7),

                                              InkWell(
                                                onTap: () {
                                                  List<List<String>> verbs = [];
                                                  for (var element
                                                      in librarywordChild[1]
                                                          .contenlist) {
                                                    verbs.add([
                                                      element.name,
                                                      element.imgurl
                                                    ]);
                                                  }
                                                  setState(() {
                                                    libraryOpen = 1;
                                                    predictionWords = verbs;
                                                  });
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 7),
                                                  child: Container(
                                                    width:
                                                        size == 0 ? 133 : 120,
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xffA7CB89),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                    child: const Center(
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
                                              ),

                                      ],
                                    )),
                                    Container(
                                      height: 7,
                                    ),
                                    Expanded(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        box(8),
                                        box(9),
                                        box(10),
                                        box(11),
                                        InkWell(
                                          onTap: () {
                                            List<List<String>> letters = [];
                                            for (var element
                                                in librarywordChild[2]
                                                    .contenlist) {
                                              letters.add([
                                                element.name,
                                                element.imgurl
                                              ]);
                                            }
                                            setState(() {
                                              libraryOpen = 2;
                                              predictionWords = letters;
                                            });
                                          },
                                          child: Stack(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 7),
                                              child: Container(
                                                width: size == 0 ? 133 : 120,
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffE9E467),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: const Center(
                                                  child: Text(
                                                    "حروف",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 30),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]),
                                        )
                                      ],
                                    )),
                                    Container(
                                      height: 7,
                                    ),
                                    Expanded(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        box(12),
                                        box(13),
                                        box(14),
                                        box(15),
                                        InkWell(
                                          onTap: () {
                                            List<List<String>> con = [];
                                            for (var element
                                                in librarywordChild[3]
                                                    .contenlist) {
                                              con.add([
                                                element.name,
                                                element.imgurl
                                              ]);
                                            }
                                            setState(() {
                                              libraryOpen = 3;
                                              predictionWords = con;
                                            });
                                          },
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 7),
                                            child: Container(
                                              width: size == 0 ? 133 : 120,
                                              decoration: BoxDecoration(
                                                  color: const Color(0xff1367A2)
                                                      .withOpacity(.6),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: const Center(
                                                child: Text(
                                                  "صفات",
                                                  textAlign: TextAlign.center,
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
                                    ))
                                  ],
                                ),
                        )),
                  ),
                )),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          List<String> dataToExport = [];
                          for (int i in isSelected) {
                            String s = convertLibString(libraryListChild[i]);
                            dataToExport.add(s);
                          } //here

                          showDialog(
                              context: context,
                              builder: (context) {
                                TextEditingController name =
                                TextEditingController();

                                TextEditingController publisherName =
                                TextEditingController();

                                TextEditingController explaination =
                                TextEditingController();
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                    child: SingleChildScrollView(
                                      child: AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    DeviceUtil.isTablet
                                                        ? 32
                                                        : 20))),
                                        title: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Column(
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: FittedBox(
                                                  child: Text(
                                                    "معلومات المكتبات المرغوب مشاركتها",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 25),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: DeviceUtil.isTablet
                                                    ? 35
                                                    : 15,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: DeviceUtil.isTablet
                                                      ? 20
                                                      : 8,
                                                  right: DeviceUtil.isTablet
                                                      ? 20
                                                      : 8,
                                                  //bottom: 11,
                                                ),
                                                child: TextFormField(
                                                  controller: name,
                                                  maxLength: 25,
                                                  maxLines: 1,
                                                  decoration: InputDecoration(
                                                    // hintText: "اسم التصدير",
                                                    labelText: "اسم النسخة",
                                                    hintStyle: const TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold),
                                                    labelStyle: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 22,
                                                        color: Colors.grey),
                                                    focusedBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: maincolor),
                                                      borderRadius:
                                                      const BorderRadius
                                                          .all(
                                                        Radius.circular(13.0),
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: maincolor),
                                                      borderRadius:
                                                      const BorderRadius
                                                          .all(
                                                        Radius.circular(13.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "* هذا الاسم سيظهر للمستخدمين عند تنزيل المكتبة",
                                                // textAlign: TextAlign.right,
                                                // ignore: prefer_const_constructors
                                                style: TextStyle(
                                                    fontSize:
                                                    DeviceUtil.isTablet
                                                        ? 14
                                                        : 11,
                                                    color: Colors.red,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: DeviceUtil.isTablet
                                                        ? 40
                                                        : 10,
                                                    bottom: DeviceUtil.isTablet
                                                        ? 20
                                                        : 10,
                                                    right: DeviceUtil.isTablet
                                                        ? 20
                                                        : 8,
                                                    left: DeviceUtil.isTablet
                                                        ? 20
                                                        : 8),
                                                child: TextFormField(
                                                  controller: publisherName,
                                                  maxLength: 25,
                                                  maxLines: 1,
                                                  decoration: InputDecoration(
                                                    //   hintText: "اسم الناشر",
                                                    labelText: "اسم الناشر",
                                                    hintStyle: const TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold),
                                                    labelStyle: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 22,
                                                        color: maincolor),
                                                    focusedBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: maincolor),
                                                      borderRadius:
                                                      const BorderRadius
                                                          .all(
                                                        Radius.circular(13.0),
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: maincolor),
                                                      borderRadius:
                                                      const BorderRadius
                                                          .all(
                                                        Radius.circular(13.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: DeviceUtil.isTablet
                                                        ? 20
                                                        : 8,
                                                    right: DeviceUtil.isTablet
                                                        ? 20
                                                        : 8),
                                                child: TextFormField(
                                                  controller: explaination,
                                                  maxLength: 120,
                                                  minLines: DeviceUtil.isTablet
                                                      ? 4
                                                      : 3,
                                                  maxLines: DeviceUtil.isTablet
                                                      ? 4
                                                      : 3,
                                                  decoration: InputDecoration(
                                                    labelText:
                                                    "شرح توضيحي عن المكتبات ",
                                                    hintStyle: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                    labelStyle: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize:
                                                        DeviceUtil.isTablet
                                                            ? 22
                                                            : 20,
                                                        color: maincolor),
                                                    focusedBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: maincolor),
                                                      borderRadius:
                                                      const BorderRadius
                                                          .all(
                                                        Radius.circular(13.0),
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: maincolor),
                                                      borderRadius:
                                                      const BorderRadius
                                                          .all(
                                                        Radius.circular(13.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceAround,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        top: 20),
                                                    child: InkWell(
                                                      onTap: () {
                                                        if (name.text.isEmpty ||
                                                            publisherName
                                                                .text.isEmpty ||
                                                            explaination
                                                                .text.isEmpty) {
                                                          erroralert(context,
                                                              "يجب ملىء جميع الحقول");
                                                        } else {
                                                          internetConnection()
                                                              .then((value) {
                                                            if (value == true) {
                                                              Provider.of<MyProvider>(
                                                                  context,
                                                                  listen:
                                                                  false)
                                                                  .isLoading(
                                                                  true);
                                                              tryUploadDataChild()
                                                                  .then((v) {
                                                                allUploadedDataChildDone()
                                                                    .then(
                                                                        (value2) {
                                                                      if (value2 ==
                                                                          true) {
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                            "Shared")
                                                                            .doc()
                                                                            .set({
                                                                          "data":
                                                                          dataToExport,
                                                                          "name": name
                                                                              .text,
                                                                          "publisherName":
                                                                          publisherName
                                                                              .text,
                                                                          "explaination":
                                                                          explaination
                                                                              .text,
                                                                          "approval":
                                                                          "no"
                                                                        }).then((value) {
                                                                          Navigator.pushAndRemoveUntil(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => const MainParentPage(index: 1)),
                                                                                  (route) => false);
                                                                          acceptalert(
                                                                            context,
                                                                            "سيتم نشر مكتبتك بعد مراجعتها يمكنك الوصول للمكتبات من خلال اعدادات -> تنزيل المكتبات",
                                                                          );
                                                                        });
                                                                      } else {
                                                                        Navigator.pushAndRemoveUntil(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (context) => const MainParentPage(
                                                                                    index:
                                                                                    1)),
                                                                                (route) =>
                                                                            false);
                                                                        erroralert(
                                                                            context,
                                                                            "حاول مرة اخرى");
                                                                      }
                                                                      Provider.of<MyProvider>(
                                                                          context,
                                                                          listen:
                                                                          false)
                                                                          .isLoading(
                                                                          false);
                                                                    });
                                                              });
                                                            } else {
                                                              erroralert(
                                                                  context,
                                                                  "يرجى الاتصال بالانترنت");
                                                            }
                                                          });
                                                        }
                                                      },
                                                      child: Container(
                                                        height:
                                                        DeviceUtil.isTablet
                                                            ? 50
                                                            : 44,
                                                        width:
                                                        DeviceUtil.isTablet
                                                            ? 200
                                                            : 100,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                15),
                                                            color: maincolor),
                                                        child: Center(
                                                          child: Provider.of<
                                                              MyProvider>(
                                                              context,
                                                              listen:
                                                              true)
                                                              .isloading
                                                              ? const CircularProgressIndicator()
                                                              : FittedBox(
                                                            child: Text(
                                                              "رفع",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: DeviceUtil.isTablet
                                                                      ? 25
                                                                      : 20),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  ////////////////////////////////// الغاء
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                      // left: 65,
                                                      // right: 65,
                                                        top: 20),
                                                    child: InkWell(
                                                      onTap: (() {
                                                        Navigator.pop(context);
                                                      }),
                                                      child: Container(
                                                        height:
                                                        DeviceUtil.isTablet
                                                            ? 50
                                                            : 44,
                                                        width:
                                                        DeviceUtil.isTablet
                                                            ? 200
                                                            : 100,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                15),
                                                            color: maincolor),
                                                        child: Center(
                                                          child: FittedBox(
                                                            child: Text(
                                                              "إلغاء",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                  DeviceUtil
                                                                      .isTablet
                                                                      ? 25
                                                                      : 20),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: DeviceUtil.isTablet
                                                    ? 35
                                                    : 15,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5, left: 5),
                          child: Container(
                              height: DeviceUtil.isTablet ? 50 : 40,
                              width: MediaQuery.of(context).size.width / 4.4,
                              decoration: BoxDecoration(
                                  color: greenColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                  child: InkWell(
                                    onTap: () {
                                      Provider.of<MyProvider>(context, listen: false)
                                          .clearSelectedInAlert();
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              insetPadding: EdgeInsets.zero,
                                              title: Column(
                                                children: [
                                                  SizedBox(
                                                    height: DeviceUtil.isTablet ? 40 : 25,
                                                    child: Stack(children: [
                                                      Center(
                                                        child: Text(
                                                          "  إختر المكتبات الجاهزة التالية",
                                                          style: TextStyle(
                                                              color: maincolor,
                                                              fontWeight: FontWeight.w900,
                                                              fontSize: DeviceUtil.isTablet
                                                                  ? 28
                                                                  : 18),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment.topRight,
                                                        child: InkWell(
                                                            onTap: () =>
                                                                Navigator.pop(context),
                                                            child: Icon(
                                                              Icons.cancel_outlined,
                                                              size: DeviceUtil.isTablet
                                                                  ? 40
                                                                  : 25,
                                                            )),
                                                      )
                                                    ]),
                                                  ),
                                                  Container(
                                                      height:
                                                      DeviceUtil.isTablet ? 350 : 250,
                                                      width: 600,
                                                      margin: const EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        border:
                                                        Border.all(color: Colors.grey),
                                                        color: const Color.fromARGB(
                                                            255, 255, 255, 255)
                                                            .withOpacity(0.8),
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(
                                                                DeviceUtil.isTablet
                                                                    ? 20
                                                                    : 15)),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(0.3),
                                                              spreadRadius: 0,
                                                              blurRadius: 5,
                                                              offset: const Offset(0, 3)),
                                                        ],
                                                      ),
                                                      child: GridView.builder(
                                                          shrinkWrap: true,
                                                          itemCount: constantLib.length,
                                                          gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                              childAspectRatio: 1 / 1.1,
                                                              crossAxisSpacing: 1,
                                                              mainAxisSpacing: 1,
                                                              crossAxisCount: 4),
                                                          itemBuilder: (context, index) {
                                                            return InkWell(
                                                              onTap: () {
                                                                Provider.of<MyProvider>(
                                                                    context,
                                                                    listen: false)
                                                                    .addOrRemove(index);
                                                              },
                                                              child: Stack(
                                                                alignment: Alignment.center,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                    child: Container(
                                                                      height: 140,
                                                                      width: 140,
                                                                      decoration:
                                                                      BoxDecoration(
                                                                        color: const Color
                                                                            .fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255)
                                                                            .withOpacity(
                                                                            0.8),
                                                                        borderRadius: BorderRadius.all(
                                                                            Radius.circular(
                                                                                DeviceUtil
                                                                                    .isTablet
                                                                                    ? 25
                                                                                    : 10)),
                                                                        border: Border.all(
                                                                          color: Colors.grey
                                                                              .withOpacity(
                                                                              0.3),
                                                                        ),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                              color: Colors
                                                                                  .grey
                                                                                  .withOpacity(
                                                                                  0.3),
                                                                              spreadRadius:
                                                                              0,
                                                                              blurRadius: 5,
                                                                              offset:
                                                                              const Offset(
                                                                                  0,
                                                                                  3)),
                                                                        ],
                                                                      ),
                                                                      child: Padding(
                                                                        padding:
                                                                        const EdgeInsets
                                                                            .all(3),
                                                                        child: Column(
                                                                            children: [
                                                                              Expanded(
                                                                                  flex: 3,
                                                                                  child: getImage(
                                                                                      constantLib[index]
                                                                                          .imgurl)),
                                                                              Expanded(
                                                                                flex: 2,
                                                                                child:
                                                                                Padding(
                                                                                  padding: const EdgeInsets
                                                                                      .only(
                                                                                      top:
                                                                                      5),
                                                                                  child:
                                                                                  Text(
                                                                                    constantLib[index]
                                                                                        .name,
                                                                                    style: TextStyle(
                                                                                        fontSize: DeviceUtil.isTablet
                                                                                            ? 26
                                                                                            : 15,
                                                                                        fontWeight:
                                                                                        FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            ]),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  !Provider.of<MyProvider>(
                                                                      context)
                                                                      .isSelectedInAlert
                                                                      .contains(index)
                                                                      ? Container()
                                                                      : Icon(
                                                                    Icons.done,
                                                                    color: purcolor,
                                                                    size: DeviceUtil
                                                                        .isTablet
                                                                        ? 100
                                                                        : 60,
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          })),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceAround,
                                                      children: [
                                                        InkWell(
                                                          onTap: () async {
                                                            List<int> selectedList =
                                                                Provider.of<MyProvider>(
                                                                    context,
                                                                    listen: false)
                                                                    .isSelectedInAlert;
                                                            SharedPreferences liblistChild =
                                                            await SharedPreferences
                                                                .getInstance();
                                                            List<String> library =
                                                                liblistChild.getStringList(
                                                                    "liblistChild") ??
                                                                    [];
                                                            for (var element
                                                            in selectedList) {
                                                              library.add(convertLibString(
                                                                  constantLib[element]));
                                                            }
                                                            liblistChild.setStringList(
                                                                "liblistChild", library);
                                                            Navigator.pushAndRemoveUntil(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                    const MainParentPage(
                                                                        index: 1)),
                                                                    (route) => false);
                                                          },
                                                          child: Container(
                                                            height: DeviceUtil.isTablet
                                                                ? 40
                                                                : 32,
                                                            width: DeviceUtil.isTablet
                                                                ? 170
                                                                : 90,
                                                            decoration: BoxDecoration(
                                                                color: greenColor,
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    10)),
                                                            child: Center(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment.center,
                                                                  children: [
                                                                    Text(
                                                                      "اختيار",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                          FontWeight.bold,
                                                                          fontSize: DeviceUtil
                                                                              .isTablet
                                                                              ? 21
                                                                              : 18,
                                                                          color: Colors.white),
                                                                    ),
                                                                    Container(
                                                                      width: DeviceUtil.isTablet
                                                                          ? 10
                                                                          : 5,
                                                                    ),
                                                                    const Icon(
                                                                      Icons.done,
                                                                      color: Colors.white,
                                                                    ),
                                                                  ],
                                                                )),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                    const Import()));
                                                          },
                                                          child: Container(
                                                            height: DeviceUtil.isTablet
                                                                ? 40
                                                                : 32,
                                                            width: DeviceUtil.isTablet
                                                                ? 170
                                                                : 90,
                                                            decoration: BoxDecoration(
                                                                color: pinkColor,
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    10)),
                                                            child: Center(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment.center,
                                                                  children: [
                                                                    Text(
                                                                      DeviceUtil.isTablet
                                                                          ? "تنزيل مكتبة"
                                                                          : "تنزيل",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                          FontWeight.bold,
                                                                          fontSize: DeviceUtil
                                                                              .isTablet
                                                                              ? 21
                                                                              : 18,
                                                                          color: Colors.white),
                                                                    ),
                                                                    Container(
                                                                      width: DeviceUtil.isTablet
                                                                          ? 10
                                                                          : 5,
                                                                    ),
                                                                    Icon(
                                                                      Icons.cloud_download,
                                                                      size: DeviceUtil.isTablet
                                                                          ? 24
                                                                          : 21,
                                                                      color: Colors.white,
                                                                    ),
                                                                  ],
                                                                )),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () => Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                  const AddChildLibrary())),
                                                          child: Container(
                                                            height: DeviceUtil.isTablet
                                                                ? 40
                                                                : 32,
                                                            width: DeviceUtil.isTablet
                                                                ? 170
                                                                : 90,
                                                            decoration: BoxDecoration(
                                                                color: purcolor,
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    10)),
                                                            child: Center(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment.center,
                                                                  children: [
                                                                    Text(
                                                                      DeviceUtil.isTablet
                                                                          ? "إنشاء مكتبة"
                                                                          : "إنشاء",
                                                                      style: TextStyle(
                                                                          fontSize: DeviceUtil
                                                                              .isTablet
                                                                              ? 21
                                                                              : 18,
                                                                          fontWeight:
                                                                          FontWeight.bold,
                                                                          color: Colors.white),
                                                                    ),
                                                                    Container(
                                                                      width: DeviceUtil.isTablet
                                                                          ? 10
                                                                          : 5,
                                                                    ),
                                                                    Icon(
                                                                      Icons.add_circle_outline,
                                                                      color: Colors.white,
                                                                      size: DeviceUtil.isTablet
                                                                          ? 30
                                                                          : 23,
                                                                    ),
                                                                  ],
                                                                )),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.add_circle_outline,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                        Container(
                                          width: 7,
                                        ),
                                        const Text(
                                          "إضافة مكتبة",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 23),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReArrangeLibraryChild()),
                          );
                        },
                        child: Container(
                          height: DeviceUtil.isTablet ? 50 : 40,
                          decoration: BoxDecoration(
                              color: purcolor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child:Padding(
                                padding:
                                EdgeInsets.all(DeviceUtil.isTablet ? 8.0 : 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.low_priority,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                    Container(
                                      width: DeviceUtil.isTablet ? 7 : 3,
                                    ),
                                    Text(
                                      "ترتيب المكتبات",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: DeviceUtil.isTablet ? 23 : 15),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),


                      InkWell(
                        onTap: () {
                          List<String> dataToExport = [];
                          for (int i in isSelected) {
                            String s = convertLibString(libraryListChild[i]);
                            dataToExport.add(s);
                          } //here

                          showDialog(
                              context: context,
                              builder: (context) {
                                TextEditingController name =
                                    TextEditingController();

                                TextEditingController publisherName =
                                    TextEditingController();

                                TextEditingController explaination =
                                    TextEditingController();
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                    child: SingleChildScrollView(
                                      child: AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    DeviceUtil.isTablet
                                                        ? 32
                                                        : 20))),
                                        title: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Column(
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: FittedBox(
                                                  child: Text(
                                                    "معلومات المكتبات المرغوب مشاركتها",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 25),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: DeviceUtil.isTablet
                                                    ? 35
                                                    : 15,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: DeviceUtil.isTablet
                                                      ? 20
                                                      : 8,
                                                  right: DeviceUtil.isTablet
                                                      ? 20
                                                      : 8,
                                                  //bottom: 11,
                                                ),
                                                child: TextFormField(
                                                  controller: name,
                                                  maxLength: 25,
                                                  maxLines: 1,
                                                  decoration: InputDecoration(
                                                    // hintText: "اسم التصدير",
                                                    labelText: "اسم النسخة",
                                                    hintStyle: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    labelStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 22,
                                                        color: maincolor),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: maincolor),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(13.0),
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: maincolor),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(13.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "* هذا الاسم سيظهر للمستخدمين عند تنزيل المكتبة",
                                                // textAlign: TextAlign.right,
                                                // ignore: prefer_const_constructors
                                                style: TextStyle(
                                                    fontSize:
                                                        DeviceUtil.isTablet
                                                            ? 14
                                                            : 11,
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: DeviceUtil.isTablet
                                                        ? 40
                                                        : 10,
                                                    bottom: DeviceUtil.isTablet
                                                        ? 20
                                                        : 10,
                                                    right: DeviceUtil.isTablet
                                                        ? 20
                                                        : 8,
                                                    left: DeviceUtil.isTablet
                                                        ? 20
                                                        : 8),
                                                child: TextFormField(
                                                  controller: publisherName,
                                                  maxLength: 25,
                                                  maxLines: 1,
                                                  decoration: InputDecoration(
                                                    //   hintText: "اسم الناشر",
                                                    labelText: "اسم الناشر",
                                                    hintStyle: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    labelStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 22,
                                                        color: maincolor),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: maincolor),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(13.0),
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: maincolor),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(13.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: DeviceUtil.isTablet
                                                        ? 20
                                                        : 8,
                                                    right: DeviceUtil.isTablet
                                                        ? 20
                                                        : 8),
                                                child: TextFormField(
                                                  controller: explaination,
                                                  maxLength: 120,
                                                  minLines: DeviceUtil.isTablet
                                                      ? 4
                                                      : 3,
                                                  maxLines: DeviceUtil.isTablet
                                                      ? 4
                                                      : 3,
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        "شرح توضيحي عن المكتبات ",
                                                    hintStyle: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    labelStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            DeviceUtil.isTablet
                                                                ? 22
                                                                : 20,
                                                        color: maincolor),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: maincolor),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(13.0),
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: maincolor),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(13.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20),
                                                    child: InkWell(
                                                      onTap: () {
                                                        if (name.text.isEmpty ||
                                                            publisherName
                                                                .text.isEmpty ||
                                                            explaination
                                                                .text.isEmpty) {
                                                          erroralert(context,
                                                              "يجب ملىء جميع الحقول");
                                                        } else {
                                                          internetConnection()
                                                              .then((value) {
                                                            if (value == true) {
                                                              Provider.of<MyProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .isLoading(
                                                                      true);
                                                              tryUploadDataChild()
                                                                  .then((v) {
                                                                allUploadedDataChildDone()
                                                                    .then(
                                                                        (value2) {
                                                                  if (value2 ==
                                                                      true) {
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            "Shared")
                                                                        .doc()
                                                                        .set({
                                                                      "data":
                                                                          dataToExport,
                                                                      "name": name
                                                                          .text,
                                                                      "publisherName":
                                                                          publisherName
                                                                              .text,
                                                                      "explaination":
                                                                          explaination
                                                                              .text,
                                                                      "approval":
                                                                          "no"
                                                                    }).then((value) {
                                                                      Navigator.pushAndRemoveUntil(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => const MainParentPage(index: 1)),
                                                                          (route) => false);
                                                                      acceptalert(
                                                                        context,
                                                                        "سيتم نشر مكتبتك بعد مراجعتها يمكنك الوصول للمكتبات من خلال اعدادات -> تنزيل المكتبات",
                                                                      );
                                                                    });
                                                                  } else {
                                                                    Navigator.pushAndRemoveUntil(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) => const MainParentPage(
                                                                                index:
                                                                                    1)),
                                                                        (route) =>
                                                                            false);
                                                                    erroralert(
                                                                        context,
                                                                        "حاول مرة اخرى");
                                                                  }
                                                                  Provider.of<MyProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .isLoading(
                                                                          false);
                                                                });
                                                              });
                                                            } else {
                                                              erroralert(
                                                                  context,
                                                                  "يرجى الاتصال بالانترنت");
                                                            }
                                                          });
                                                        }
                                                      },
                                                      child: Container(
                                                        height:
                                                            DeviceUtil.isTablet
                                                                ? 50
                                                                : 44,
                                                        width:
                                                            DeviceUtil.isTablet
                                                                ? 200
                                                                : 100,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            color: maincolor),
                                                        child: Center(
                                                          child: Provider.of<
                                                                          MyProvider>(
                                                                      context,
                                                                      listen:
                                                                          true)
                                                                  .isloading
                                                              ? const CircularProgressIndicator()
                                                              : FittedBox(
                                                                  child: Text(
                                                                    "رفع",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize: DeviceUtil.isTablet
                                                                            ? 25
                                                                            : 20),
                                                                  ),
                                                                ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  ////////////////////////////////// الغاء
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            // left: 65,
                                                            // right: 65,
                                                            top: 20),
                                                    child: InkWell(
                                                      onTap: (() {
                                                        Navigator.pop(context);
                                                      }),
                                                      child: Container(
                                                        height:
                                                            DeviceUtil.isTablet
                                                                ? 50
                                                                : 44,
                                                        width:
                                                            DeviceUtil.isTablet
                                                                ? 200
                                                                : 100,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            color: maincolor),
                                                        child: Center(
                                                          child: FittedBox(
                                                            child: Text(
                                                              "إلغاء",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      DeviceUtil
                                                                              .isTablet
                                                                          ? 25
                                                                          : 20),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: DeviceUtil.isTablet
                                                    ? 35
                                                    : 15,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: Container(
                              height: DeviceUtil.isTablet ? 50 : 40,
                              width: MediaQuery.of(context).size.width / 4.4,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 232, 140, 2),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Export()));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.cloud_upload,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                        Container(
                                          width: 7,
                                        ),
                                        const Text(
                                          "رفع مكتبة",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 23),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DeleteLibrary()),
                          );
                        },
                        child: Container(
                          height: DeviceUtil.isTablet ? 50 : 40,
                          decoration: BoxDecoration(
                              color: pinkColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Padding(
                            padding:
                                EdgeInsets.all(DeviceUtil.isTablet ? 8.0 : 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.delete_outlined,
                                  color: Colors.white,
                                  size: DeviceUtil.isTablet ? 35 : 30,
                                ),
                                Container(
                                  width: DeviceUtil.isTablet ? 7 : 3,
                                ),
                                Text(
                                  "حذف مكتبة",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: DeviceUtil.isTablet ? 23 : 15),
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            if (currentOffsetScroll - 100 > 0) {
                              setState(() {
                                currentOffsetScroll -= 90;
                                controllerList.animateTo(
                                    currentOffsetScroll,
                                    duration: const Duration(
                                        seconds: 1),
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
                          )
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 80,
                          child: ListView(
                            controller: controllerList,
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (int i = 0; i < libraryListChild.length; i++)
                                box3(i)

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
                                controllerList.animateTo(currentOffsetScroll,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeOut);
                              });
                            } else {
                              setState(() {
                                currentOffsetScroll =
                                    70.0 * libraryListChild.length;
                                controllerList.animateTo(
                                    70.0 * libraryListChild.length,
                                    duration: const Duration(seconds: 1),
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
                    height: 140,
                    //width: 620,
                    decoration: BoxDecoration(
                        color: Colors
                            .white, // const Color.fromARGB(255, 206, 213, 218),
                        borderRadius: BorderRadius.circular(7)),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5, left: 5),
                      child: Row(
                        children: [
                          FittedBox(
                            child: Column(
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: greenColor,
                         // Background color
                                    ),
                                    onPressed: ()
                                    {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AddContentChild(libraryindex: coloredOpenLibraryindex,)
                                          ),
                                              (route) => false);
                                    },

                                    child: const Text("إضافة جملة",style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),)
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: pinkColor
                                      , // Background color
                                    ),
                                    onPressed: () async {
                                      if(isSelected.isNotEmpty){
                                        showAlertDialog(context);

                                      }else{
                                       /* showDialog(
                                            context: context,
                                            builder: (context) {

                                              return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      const BorderRadius.all(Radius.circular(20))),
                                                  title: Container(
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10)),
                                                      child: Center(
                                                            child: Directionality(
                                                              textDirection: TextDirection.rtl,
                                                              child: Column(
                                                                children: [
                                                                  Center(
                                                                    child: const Padding(
                                                                      padding: EdgeInsets.all(8.0),
                                                                      child: FittedBox(
                                                                        child: Text(
                                                                          "الرجاء تحديد الجمل المراد حذفها",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 25),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 35,
                                                                  ),
                                                                  ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        backgroundColor:purcolor ,),

                                                                      onPressed: (){
                                                                    Navigator.pop(context);
                                                                  },
                                                                      child: Text("موافق"))


                                                                ],
                                                              ),
                                                            ),

                                                      ))
                                              );
                                            });*/
                                        erroralert(
                                            context,
                                            "الرجاء تحديد الجمل المرد حذفها");
                                      }


                                    },

                                    child: const Text("حذف جملة",style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),)
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: purcolor, // Background color
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ReArrangeContentChild(
                                                    contentIndex:
                                                        coloredOpenLibraryindex,
                                                  )));
                                    },
                                    child: const Text("إعادة ترتيب",style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                    )
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                color: const Color.fromARGB(255, 206, 213, 218),
                                child: ListView(
                                  controller: controllerList2,
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    for (int i = 0;
                                        i < contentWord.length;
                                        isLess ? i = i + 2 : i++)
                                      Column(
                                        children: [
                                          Expanded(
                                            child: Stack(children: [
                                              InkWell(
                                                onTap: () async {
                                                  if (selectedAvaiabel) {
                                                    if (isSelected
                                                        .contains(i)) {
                                                      setState(() {
                                                        isSelected.remove(i);
                                                      });
                                                    } else {
                                                      setState(() {
                                                        isSelected.add(i);
                                                      });
                                                    }
                                                  }
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5,
                                                          left: 2,
                                                          top: 5,
                                                          bottom: 5),
                                                  child: Container(
                                                    width:
                                                        size == 0 ? 170 : 150,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  27)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.3),
                                                            spreadRadius: 3,
                                                            blurRadius: 5,
                                                            offset:
                                                                const Offset(
                                                                    0, 3)),
                                                      ],
                                                      border: Border.all(
                                                        width:
                                                            size == 0 ? 3 : 2,
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
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    size == 0
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
                                              ),
                                              !selectedAvaiabel
                                                  ? Container()
                                                  : isSelected.contains(
                                                          i) //||(IsSentenceClick==true)
                                                      ? Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: Container(
                                                            height: DeviceUtil
                                                                    .isTablet
                                                                ? 34
                                                                : 25,
                                                            width: DeviceUtil
                                                                    .isTablet
                                                                ? 34
                                                                : 25,
                                                            decoration: BoxDecoration(
                                                                color: const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    224,
                                                                    223,
                                                                    223),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .red,
                                                                    width: 3)),
                                                            child: Icon(
                                                              Icons.circle,
                                                              color: Colors.red,
                                                              size: DeviceUtil
                                                                      .isTablet
                                                                  ? 25
                                                                  : 18,
                                                            ),
                                                          ),
                                                        )
                                                      : Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: Container(
                                                            height: DeviceUtil
                                                                    .isTablet
                                                                ? 34
                                                                : 25,
                                                            width: DeviceUtil
                                                                    .isTablet
                                                                ? 34
                                                                : 25,
                                                            decoration: BoxDecoration(
                                                                color: const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    224,
                                                                    223,
                                                                    223),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .red,
                                                                    width: 3)),
                                                          ),
                                                        ),
                                            ]),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  box(int index) {
    return InkWell(
      onTap: () {
       // String word="";
        showDialog(
            context: context,
            builder: (context) {
              TextEditingController word = TextEditingController();


              return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  title: Container(
                      width: 600,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: SingleChildScrollView(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Column(
                            children: [
                              Center(
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: FittedBox(
                                    child: Text(
                                      "إنشاء كلمة",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: DeviceUtil.isTablet ? 20 : 8,
                                  right: DeviceUtil.isTablet ? 20 : 8,
                                  //bottom: 11,
                                ),
                                child: TextFormField(
                                  controller: word,
                                  maxLength: 10,
                                  maxLines: 1,

                                  decoration: InputDecoration(
                                    labelText: predictionWords[index][0]
                                      ,
                                    labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: maincolor),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: maincolor),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(13.0),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: maincolor),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(13.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Provider.of<MyProvider>(context)
                                      .lastimagepath
                                      .toString()
                                      .isNotEmpty
                                  ? InkWell(
                                      onTap: () => diag(),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 31),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: greyColor, width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: const Color.fromARGB(
                                                      255,
                                                      255,
                                                      255,
                                                      255) // Color.fromARGB(255, 121, 161, 134)
                                                  .withOpacity(.4)),
                                          height:
                                              DeviceUtil.isTablet ? 100 : 80,
                                          width: DeviceUtil.isTablet ? 100 : 80,
                                          child: getImage(
                                              Provider.of<MyProvider>(context)
                                                  .lastimagepath
                                                  .toString()),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              Container(
                                width: Provider.of<MyProvider>(context)
                                        .lastimagepath
                                        .toString()
                                        .isNotEmpty
                                    ? 0
                                    : 30,
                              ),
                              Provider.of<MyProvider>(context)
                                      .lastimagepath
                                      .toString()
                                      .isEmpty
                                  ? InkWell(
                                      onTap: () => diag(),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: greyColor, width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: const Color.fromARGB(
                                                    255,
                                                    255,
                                                    255,
                                                    255) // Color.fromARGB(255, 121, 161, 134)
                                                .withOpacity(.4)),
                                        height: DeviceUtil.isTablet ? 100 : 80,
                                        width: DeviceUtil.isTablet ? 100 : 80,
                                        child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children:  [
                                            SizedBox(
                                              height:40,
                                              width:40,
                                              child:getImage(predictionWords[index][1]) //Image.asset(predictionWords[index][1]),
                                            ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              const SizedBox(
                                height: 50,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: InkWell(
                                      onTap: () {
                                        if (word.text.isEmpty) {
                                          erroralert(
                                              context, "يجب ملىء جميع الحقول");
                                        } else {
                                          editWordboxContent(
                                              context,
                                              libraryOpen,
                                              index,
                                              word.text,
                                              Provider.of<MyProvider>(context,
                                                      listen: false)
                                                  .lastimagepath
                                                  .toString());

                                          Provider.of<MyProvider>(context,
                                                  listen: false)
                                              .setPath("");
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const settingLibrary_tablet()),
                                              (route) => false);
                                        }
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 200,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: maincolor),
                                        child: Center(
                                          child: Provider.of<MyProvider>(
                                                      context,
                                                      listen: true)
                                                  .isloading
                                              ? const CircularProgressIndicator()
                                              : FittedBox(
                                                  child: Text(
                                                    "حفظ",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            DeviceUtil.isTablet
                                                                ? 25
                                                                : 20),
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 200,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(15),
                                            color: maincolor),
                                        child: Center(
                                          child:  FittedBox(
                                            child: Text(
                                              "إلغاء",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                  DeviceUtil.isTablet
                                                      ? 25
                                                      : 20),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                      )
                  )
              );
            });
      },
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Container(
            width: MediaQuery.of(context).orientation == Orientation.portrait
                ? size == 0
                    ? 133
                    : 120
                : size == 0
                    ? 130
                    : 115,
            height: 500,
            decoration: BoxDecoration(
                // color: getWordColor(predictionWords[index][0]).withOpacity(.4),
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                border: Border.all(color: Colors.grey, width: 5)),
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
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        color: pinkColor),
                  )
                ]),
              ),
            ),
          ),
        ),
        Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                color: pinkColor, borderRadius: BorderRadius.circular(30)),
            child: Icon(
              Icons.edit,
              size: 27,
              color: Colors.white,
            )),
      ]),
    );
  }

  box3(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          coloredOpenLibraryindex = index;
          if (isSelected.isNotEmpty) {
           // int contentLIndex=index;
            //here showDialog
            /*showDialog(
              context: context,
              builder: (BuildContext context) {
                return  AlertDialog(
                  actionsAlignment: MainAxisAlignment.center,
                  title: Icon(
                    Icons.warning,
                    size: DeviceUtil.isTablet ? 100 : 60,
                    color: Colors.red,
                  ),
                  content: Text(
                    "هل تريد حفظ تغيراتك؟ ",
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: DeviceUtil.isTablet ? 25 : 20),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              setState(() {
                                //selectedAvaiabel = false;
                                isSelected = [];
                              });
                            },
                            child: Container(
                              height: DeviceUtil.isTablet ? 50 : 40,
                              width: DeviceUtil.isTablet ? 150 : 90,
                              decoration: BoxDecoration(
                                  color: purcolor, borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                    "إلغاء",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: DeviceUtil.isTablet ? 25 : 19),
                                  )),
                            ),
                          ),
                          Container(
                            width: 30,
                          ),
                          InkWell(
                            onTap: () async {
                List theSelectedItem = isSelected;
                theSelectedItem.sort();
                theSelectedItem = theSelectedItem.reversed.toList();
                for (var element in theSelectedItem) {
                libraryListChild[contentLIndex
                ]
                    .contenlist
                    .removeAt(element);
                }

                SharedPreferences liblist =
                await SharedPreferences.getInstance();
                List<String> v = [];
                for (lib l in libraryListChild) {
                String s = convertLibString(l);
                v.add(s);
                }
                liblist.setStringList("liblistChild", v);
                Provider.of<MyProvider>(context, listen: false)
                    .setIscontentOfLibrary( contentLIndex);
                Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                builder: (context) => const MainParentPage(
                index: 1,
                )),
                (route) => false);
                isSelected = [];

                },
                            child: Container(
                              height: DeviceUtil.isTablet ? 50 : 40,
                              width: DeviceUtil.isTablet ? 150 : 100,
                              decoration: BoxDecoration(
                                  color: purcolor, borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                    "نعم، متأكد",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: DeviceUtil.isTablet ? 25 : 19),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );*/
            isSelected=[];
            contentWord = libraryListChild[index].contenlist;

          } else {
            coloredOpenLibraryindex = index;
            isSelected = [];
            contentWord = libraryListChild[index].contenlist;


          }

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

  /*showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      title: Icon(
        Icons.warning,
        size: DeviceUtil.isTablet ? 100 : 60,
        color: Colors.red,
      ),
      content: Text(
        "هل تريد حفظ تغيراتك؟ ",
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: DeviceUtil.isTablet ? 25 : 20),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    //selectedAvaiabel = false;
                    isSelected = [];
                  });
                },
                child: Container(
                  height: DeviceUtil.isTablet ? 50 : 40,
                  width: DeviceUtil.isTablet ? 150 : 90,
                  decoration: BoxDecoration(
                      color: purcolor, borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    "إلغاء",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: DeviceUtil.isTablet ? 25 : 19),
                  )),
                ),
              ),
              Container(
                width: 30,
              ),
              InkWell(
                onTap: () async {
                  List theSelectedItem = isSelected;
                  theSelectedItem.sort();
                  theSelectedItem = theSelectedItem.reversed.toList();
                  for (var element in theSelectedItem) {
                    libraryListChild[coloredOpenLibraryindex
                  ]
                        .contenlist
                        .removeAt(element);
                  }

                  SharedPreferences liblist =
                  await SharedPreferences.getInstance();
                  List<String> v = [];
                  for (lib l in libraryListChild) {
                    String s = convertLibString(l);
                    v.add(s);
                  }
                  liblist.setStringList("liblistChild", v);
                  Provider.of<MyProvider>(context, listen: false)
                      .setIscontentOfLibrary( coloredOpenLibraryindex);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainParentPage(
                            index: 1,
                          )),
                          (route) => false);
                  isSelected=[];

                },
                child: Container(
                  height: DeviceUtil.isTablet ? 50 : 40,
                  width: DeviceUtil.isTablet ? 150 : 100,
                  decoration: BoxDecoration(
                      color: purcolor, borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    "نعم، متأكد",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: DeviceUtil.isTablet ? 25 : 19),
                  )),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: Icon(
            Icons.warning,
            size: DeviceUtil.isTablet ? 100 : 60,
            color: Colors.red,
          ),
          content: Text(
            "هل تريد حفظ تغيراتك؟ ",
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: DeviceUtil.isTablet ? 25 : 20),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        //selectedAvaiabel = false;
                        isSelected = [];
                      });
                    },
                    child: Container(
                      height: DeviceUtil.isTablet ? 50 : 40,
                      width: DeviceUtil.isTablet ? 150 : 90,
                      decoration: BoxDecoration(
                          color: purcolor, borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                            "إلغاء",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: DeviceUtil.isTablet ? 25 : 19),
                          )),
                    ),
                  ),
                  Container(
                    width: 30,
                  ),
                  InkWell(
                    onTap: () async {
                      List theSelectedItem = isSelected;
                      theSelectedItem.sort();
                      theSelectedItem = theSelectedItem.reversed.toList();
                      for (var element in theSelectedItem) {
                        libraryListChild[coloredOpenLibraryindex
                        ]
                            .contenlist
                            .removeAt(element);
                      }

                      SharedPreferences liblist =
                      await SharedPreferences.getInstance();
                      List<String> v = [];
                      for (lib l in libraryListChild) {
                        String s = convertLibString(l);
                        v.add(s);
                      }
                      liblist.setStringList("liblistChild", v);
                      Provider.of<MyProvider>(context, listen: false)
                          .setIscontentOfLibrary( coloredOpenLibraryindex);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainParentPage(
                                index: 1,
                              )),
                              (route) => false);
                      isSelected=[];

                    },
                    child: Container(
                      height: DeviceUtil.isTablet ? 50 : 40,
                      width: DeviceUtil.isTablet ? 150 : 100,
                      decoration: BoxDecoration(
                          color: purcolor, borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                            "نعم، متأكد",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: DeviceUtil.isTablet ? 25 : 19),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );;
      },
    );
  }*/

  Future pickimage(ImageSource source) async {
    try {
      final im = await ImagePicker().pickImage(source: source);
      if (im == null) {
        return;
      } else {
        Provider.of<MyProvider>(context, listen: false).setPath(im.path);
      }
    } on PlatformException {
      ///////////edit heeeeeeeeeeeeeeeeeeeeeeeeere
      return;
    }
  }

  diag() {
    return showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                  child: const Text(
                    "الكاميرا",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    pickimage(ImageSource.camera);
                  }),
              CupertinoDialogAction(
                child: const Text(" الاستديو",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.pop(context);
                  pickimage(ImageSource.gallery);
                },
              ),
              CupertinoDialogAction(
                child: const Text("مكتبة الايقونات",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Icongroups()));
                },
              ),
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                  child: const Text('إلغاء',
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold))),
            ],
          );
        });
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      title: Icon(
        Icons.warning,
        size: DeviceUtil.isTablet ? 100 : 60,
        color: Colors.red,
      ),
      content: Text(
        "هل أنت متأكد أنك تريد حذف هذه الجمل؟ ",
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: DeviceUtil.isTablet ? 25 : 20),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    isSelected = [];
                  });
                },
                child: Container(
                  height: DeviceUtil.isTablet ? 50 : 40,
                  width: DeviceUtil.isTablet ? 150 : 90,
                  decoration: BoxDecoration(
                      color: purcolor, borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                        "إلغاء",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: DeviceUtil.isTablet ? 25 : 19),
                      )),
                ),
              ),
              Container(
                width: 30,
              ),
              InkWell(
                onTap: () async {
                  List theSelectedItem = isSelected;
                  theSelectedItem.sort();
                  theSelectedItem = theSelectedItem.reversed.toList();
                  for (var element in theSelectedItem) {
                    libraryListChild[coloredOpenLibraryindex
                    ]
                        .contenlist
                        .removeAt(element);
                  }

                  SharedPreferences liblist =
                  await SharedPreferences.getInstance();
                  List<String> v = [];
                  for (lib l in libraryListChild) {
                    String s = convertLibString(l);
                    v.add(s);
                  }
                  liblist.setStringList("liblistChild", v);
                  Provider.of<MyProvider>(context, listen: false)
                      .setIscontentOfLibrary( coloredOpenLibraryindex);
                  isSelected = [];

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainParentPage(
                            index: 1,
                          )),
                          (route) => false);
                },
                child: Container(
                  height: DeviceUtil.isTablet ? 50 : 40,
                  width: DeviceUtil.isTablet ? 150 : 100,
                  decoration: BoxDecoration(
                      color: purcolor, borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                        "نعم، متأكد",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: DeviceUtil.isTablet ? 25 : 19),
                      )),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
//3360