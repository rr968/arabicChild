// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:convert';

import '/childpage/parent/addlibraryChild.dart';

import '/childpage/parent/constantLibraryChild.dart';
import '/childpage/parent/mainparent.dart';
import '/childpage/parent/rearrangeLib.dart';

import '/controller/images.dart';
import '/controller/istablet.dart';
import '/controller/my_provider.dart';
import '/controller/var.dart';
import '/model/library.dart';
import '/view/drawer/drawer.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/libtostring.dart';
import '../../model/content.dart';

bool iscontent = false;

class MainParentSettings extends StatefulWidget {
  const MainParentSettings({super.key});

  @override
  State<MainParentSettings> createState() => _MainParentSettingsState();
}

class _MainParentSettingsState extends State<MainParentSettings> {
  bool isloading = true;
  List isSelected = [];
  bool selectedAvaiabel = false;
  final controllerList = ScrollController();
  double currentOffsetScroll = 0;

  @override
  void initState() {
    getdata().then((v) {
      setState(() {
        isloading = false;
      });
    });

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      drawer: const Drawerc(),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: 17, bottom: 50, top: 50),
                  child: !selectedAvaiabel
                      ? Text(
                          "المكتبات",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: purcolor,
                              fontSize: DeviceUtil.isTablet ? 45 : 26,
                              fontWeight: FontWeight.bold),
                        )
                      : Text(
                          "حـذف مكتبة",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: purcolor,
                              fontSize: DeviceUtil.isTablet ? 45 : 26,
                              fontWeight: FontWeight.w900),
                        ),
                ),
                selectedAvaiabel
                    ? Container(
                        height: 40,
                      )
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ReArrangeLibraryChild()),
                                    (route) => false);
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: purcolor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.low_priority,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                        Container(
                                          width: 7,
                                        ),
                                        const Text(
                                          "إعادة ترتيب",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 23),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            InkWell(
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
                                              height: 40,
                                              child: Stack(children: [
                                                Center(
                                                  child: Text(
                                                    "  إختر المكتبات الجاهزة التالية",
                                                    style: TextStyle(
                                                        color: maincolor,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        fontSize:
                                                            DeviceUtil.isTablet
                                                                ? 28
                                                                : 18),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: InkWell(
                                                      onTap: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child: const Icon(
                                                        Icons.cancel_outlined,
                                                        size: 40,
                                                      )),
                                                )
                                              ]),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                color: const Color.fromARGB(
                                                        255, 255, 255, 255)
                                                    .withOpacity(0.8),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(27)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      spreadRadius: 0,
                                                      blurRadius: 5,
                                                      offset:
                                                          const Offset(0, 3)),
                                                ],
                                              ),
                                              child: Column(
                                                children: [
                                                  FittedBox(
                                                    child: Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            Provider.of<MyProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .addOrRemove(0);
                                                          },
                                                          child: Stack(
                                                            alignment: Alignment
                                                                .center,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(10),
                                                                child:
                                                                    Container(
                                                                  height: 140,
                                                                  width: 140,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: const Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255)
                                                                        .withOpacity(
                                                                            0.8),
                                                                    borderRadius: const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            27)),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                          color: Colors.grey.withOpacity(
                                                                              0.3),
                                                                          spreadRadius:
                                                                              0,
                                                                          blurRadius:
                                                                              5,
                                                                          offset: const Offset(
                                                                              0,
                                                                              3)),
                                                                    ],
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(5),
                                                                    child: Column(
                                                                        children: [
                                                                          Expanded(
                                                                              flex: 3,
                                                                              child: getImage(constantLib[0].imgurl)),
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(top: 5),
                                                                              child: FittedBox(
                                                                                child: Text(
                                                                                  constantLib[0].name,
                                                                                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                                                                ),
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
                                                                      .contains(
                                                                          0)
                                                                  ? Container()
                                                                  : Icon(
                                                                      Icons
                                                                          .done,
                                                                      color:
                                                                          purcolor,
                                                                      size: 120,
                                                                    ),
                                                            ],
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            Provider.of<MyProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .addOrRemove(1);
                                                          },
                                                          child: Stack(
                                                            alignment: Alignment
                                                                .center,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                child:
                                                                    Container(
                                                                  height: 140,
                                                                  width: 140,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: const Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255)
                                                                        .withOpacity(
                                                                            0.8),
                                                                    borderRadius: const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            27)),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                          color: Colors.grey.withOpacity(
                                                                              0.3),
                                                                          spreadRadius:
                                                                              0,
                                                                          blurRadius:
                                                                              5,
                                                                          offset: const Offset(
                                                                              0,
                                                                              3)),
                                                                    ],
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            10),
                                                                    child: Column(
                                                                        children: [
                                                                          Expanded(
                                                                              flex: 3,
                                                                              child: getImage(constantLib[1].imgurl)),
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(top: 5),
                                                                              child: FittedBox(
                                                                                child: Text(
                                                                                  constantLib[1].name,
                                                                                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                                                                ),
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
                                                                      .contains(
                                                                          1)
                                                                  ? Container()
                                                                  : Icon(
                                                                      Icons
                                                                          .done,
                                                                      color:
                                                                          purcolor,
                                                                      size: 120,
                                                                    ),
                                                            ],
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            Provider.of<MyProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .addOrRemove(2);
                                                          },
                                                          child: Stack(
                                                            alignment: Alignment
                                                                .center,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                child:
                                                                    Container(
                                                                  height: 140,
                                                                  width: 140,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: const Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255)
                                                                        .withOpacity(
                                                                            0.8),
                                                                    borderRadius: const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            27)),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                          color: Colors.grey.withOpacity(
                                                                              0.3),
                                                                          spreadRadius:
                                                                              0,
                                                                          blurRadius:
                                                                              5,
                                                                          offset: const Offset(
                                                                              0,
                                                                              3)),
                                                                    ],
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            10),
                                                                    child: Column(
                                                                        children: [
                                                                          Expanded(
                                                                              flex: 3,
                                                                              child: getImage(constantLib[2].imgurl)),
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(top: 5),
                                                                              child: FittedBox(
                                                                                child: Text(
                                                                                  constantLib[2].name,
                                                                                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                                                                ),
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
                                                                      .contains(
                                                                          2)
                                                                  ? Container()
                                                                  : Icon(
                                                                      Icons
                                                                          .done,
                                                                      color:
                                                                          purcolor,
                                                                      size: 120,
                                                                    ),
                                                            ],
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            Provider.of<MyProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .addOrRemove(3);
                                                          },
                                                          child: Stack(
                                                            alignment: Alignment
                                                                .center,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                child:
                                                                    Container(
                                                                  height: 140,
                                                                  width: 140,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: const Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255)
                                                                        .withOpacity(
                                                                            0.8),
                                                                    borderRadius: const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            27)),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                          color: Colors.grey.withOpacity(
                                                                              0.3),
                                                                          spreadRadius:
                                                                              0,
                                                                          blurRadius:
                                                                              5,
                                                                          offset: const Offset(
                                                                              0,
                                                                              3)),
                                                                    ],
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(5),
                                                                    child: Column(
                                                                        children: [
                                                                          Expanded(
                                                                              flex: 3,
                                                                              child: getImage(constantLib[3].imgurl)),
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(top: 5),
                                                                              child: FittedBox(
                                                                                child: Text(
                                                                                  constantLib[3].name,
                                                                                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                                                                ),
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
                                                                      .contains(
                                                                          3)
                                                                  ? Container()
                                                                  : Icon(
                                                                      Icons
                                                                          .done,
                                                                      color:
                                                                          purcolor,
                                                                      size: 120,
                                                                    ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Provider.of<MyProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .addOrRemove(4);
                                                        },
                                                        child: Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
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
                                                                  borderRadius: const BorderRadius
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
                                                                            0,
                                                                        blurRadius:
                                                                            5,
                                                                        offset: const Offset(
                                                                            0,
                                                                            3)),
                                                                  ],
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(5),
                                                                  child: Column(
                                                                      children: [
                                                                        Expanded(
                                                                            flex:
                                                                                3,
                                                                            child:
                                                                                getImage(constantLib[4].imgurl)),
                                                                        Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(top: 5),
                                                                            child:
                                                                                FittedBox(
                                                                                  child: Text(
                                                                              constantLib[4].name,
                                                                              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                                                            ),
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
                                                                    .contains(4)
                                                                ? Container()
                                                                : Icon(
                                                                    Icons.done,
                                                                    color:
                                                                        purcolor,
                                                                    size: 120,
                                                                  ),
                                                          ],
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Provider.of<MyProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .addOrRemove(5);
                                                        },
                                                        child: Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
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
                                                                  borderRadius: const BorderRadius
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
                                                                            0,
                                                                        blurRadius:
                                                                            5,
                                                                        offset: const Offset(
                                                                            0,
                                                                            3)),
                                                                  ],
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(5),
                                                                  child: Column(
                                                                      children: [
                                                                        Expanded(
                                                                            flex:
                                                                                3,
                                                                            child:
                                                                                getImage(constantLib[5].imgurl)),
                                                                        Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(top: 5),
                                                                            child:
                                                                                FittedBox(
                                                                                  child: Text(
                                                                              constantLib[5].name,
                                                                              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                                                            ),
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
                                                                    .contains(5)
                                                                ? Container()
                                                                : Icon(
                                                                    Icons.done,
                                                                    color:
                                                                        purcolor,
                                                                    size: 120,
                                                                  ),
                                                          ],
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Provider.of<MyProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .addOrRemove(6);
                                                        },
                                                        child: Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
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
                                                                  borderRadius: const BorderRadius
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
                                                                            0,
                                                                        blurRadius:
                                                                            5,
                                                                        offset: const Offset(
                                                                            0,
                                                                            3)),
                                                                  ],
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(5),
                                                                  child: Column(
                                                                      children: [
                                                                        Expanded(
                                                                            flex:
                                                                                3,
                                                                            child:
                                                                                getImage(constantLib[6].imgurl)),
                                                                        Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(top: 5),
                                                                            child:
                                                                                FittedBox(
                                                                                  child: Text(
                                                                              constantLib[6].name,
                                                                              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                                                            ),
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
                                                                    .contains(6)
                                                                ? Container()
                                                                : Icon(
                                                                    Icons.done,
                                                                    color:
                                                                        purcolor,
                                                                    size: 120,
                                                                  ),
                                                          ],
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Provider.of<MyProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .addOrRemove(7);
                                                        },
                                                        child: Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
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
                                                                  borderRadius: const BorderRadius
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
                                                                            0,
                                                                        blurRadius:
                                                                            5,
                                                                        offset: const Offset(
                                                                            0,
                                                                            3)),
                                                                  ],
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(5),
                                                                  child: Column(
                                                                      children: [
                                                                        Expanded(
                                                                            flex:
                                                                                3,
                                                                            child:
                                                                                getImage(constantLib[7].imgurl)),
                                                                        Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(top: 5),
                                                                            child:
                                                                                FittedBox(
                                                                                  child: Text(
                                                                              constantLib[7].name,
                                                                              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                                                            ),
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
                                                                    .contains(7)
                                                                ? Container()
                                                                : Icon(
                                                                    Icons.done,
                                                                    color:
                                                                        purcolor,
                                                                    size: 120,
                                                                  ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  InkWell(
                                                    onTap: () async {
                                                      List<int> selectedList =
                                                          Provider.of<MyProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .isSelectedInAlert;
                                                      SharedPreferences
                                                          liblistChild =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      List<String> library =
                                                          liblistChild.getStringList(
                                                                  "liblistChild") ??
                                                              [];
                                                      for (var element
                                                          in selectedList) {
                                                        library.add(
                                                            convertLibString(
                                                                constantLib[
                                                                    element]));
                                                      }
                                                      liblistChild
                                                          .setStringList(
                                                              "liblistChild",
                                                              library);
                                                      Navigator.pushAndRemoveUntil(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const MainParentPage(
                                                                      index:
                                                                          0)),
                                                          (route) => false);
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 170,
                                                      decoration: BoxDecoration(
                                                          color: greenColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Center(
                                                          child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Text(
                                                            "اختيار",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Container(
                                                            width: DeviceUtil
                                                                    .isTablet
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
                                                    child: Container(
                                                      height: 40,
                                                      width: 170,
                                                      decoration: BoxDecoration(
                                                          color: pinkColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Center(
                                                          child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            DeviceUtil.isTablet
                                                                ? "تنزيل مكتبة"
                                                                : "تنزيل",
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Container(
                                                            width: DeviceUtil
                                                                    .isTablet
                                                                ? 10
                                                                : 5,
                                                          ),
                                                          const Icon(
                                                            Icons
                                                                .cloud_download,
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
                                                      height: 40,
                                                      width: 170,
                                                      decoration: BoxDecoration(
                                                          color: purcolor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Center(
                                                          child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            DeviceUtil.isTablet
                                                                ? "إنشاء مكتبة"
                                                                : "إنشاء",
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Container(
                                                            width: DeviceUtil
                                                                    .isTablet
                                                                ? 10
                                                                : 5,
                                                          ),
                                                          const Icon(
                                                            Icons
                                                                .add_circle_outline,
                                                            color: Colors.white,
                                                            size: 35,
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
                              child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: greenColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
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
                                  )),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isSelected = [];
                                  selectedAvaiabel = true;
                                });
                              },
                              child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: pinkColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.delete_outlined,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                        Container(
                                          width: 7,
                                        ),
                                        Text(
                                          "حذف مكتبة",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: DeviceUtil.isTablet
                                                  ? 25
                                                  : 17),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                Container(
                  width: MediaQuery.of(context).size.width - 70,
                  height: MediaQuery.of(context).size.height * .44,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 202, 202, 202)),
                    color: const Color.fromARGB(255, 255, 255, 255)
                        .withOpacity(0.3),
                    borderRadius: const BorderRadius.all(Radius.circular(27)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 217, 216, 216)
                            .withOpacity(0.4),
                        spreadRadius: 3,
                        blurRadius: 7,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                            controller: controllerList,
                            scrollDirection: Axis.vertical,
                            itemCount: libraryListChild.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? 5
                                      : 7,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  if (selectedAvaiabel) {
                                    if (isSelected.contains(index)) {
                                      setState(() {
                                        isSelected.remove(index);
                                      });
                                    } else {
                                      setState(() {
                                        isSelected.add(index);
                                      });
                                    }
                                  } else {
                                    Provider.of<MyProvider>(context,
                                            listen: false)
                                        .setIscontentOfLibrary(index);
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: greyColor),
                                      color: const Color.fromARGB(
                                              255, 255, 255, 255)
                                          .withOpacity(0.5),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(27)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.7),
                                          spreadRadius: 0,
                                          blurRadius: 7,
                                          //offset: Offset(0, 3)),
                                        )
                                      ],
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Column(children: [
                                            Expanded(
                                                child: getImage(
                                                    libraryListChild[index]
                                                        .imgurl)),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: FittedBox(
                                                child: Text(
                                                  libraryListChild[index].name,
                                                  style: const TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ),
                                        !selectedAvaiabel
                                            ? Container()
                                            : isSelected.contains(index)
                                                ? Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Container(
                                                      height:
                                                          DeviceUtil.isTablet
                                                              ? 34
                                                              : 25,
                                                      width: DeviceUtil.isTablet
                                                          ? 34
                                                          : 25,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white
                                                            .withOpacity(0.3),
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    27)),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 3,
                                                            blurRadius: 7,
                                                            //offset: Offset(0, 3)),
                                                          )
                                                        ],
                                                      ),
                                                      child: Icon(
                                                        Icons.circle,
                                                        color: Colors.red,
                                                        size:
                                                            DeviceUtil.isTablet
                                                                ? 25
                                                                : 18,
                                                      ),
                                                    ),
                                                  )
                                                : Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Container(
                                                      height:
                                                          DeviceUtil.isTablet
                                                              ? 34
                                                              : 25,
                                                      width: DeviceUtil.isTablet
                                                          ? 34
                                                          : 25,
                                                      decoration: BoxDecoration(
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              224, 223, 223),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                          border: Border.all(
                                                              color: Colors.red,
                                                              width: 3)),
                                                    ),
                                                  ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
                !selectedAvaiabel
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                showAlertDialog(context);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 200,
                                decoration: BoxDecoration(
                                    color: greenColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Text(
                                  "حذف",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedAvaiabel = false;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 200,
                                decoration: BoxDecoration(
                                    color: pinkColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Text(
                                  "إلغاء",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
    );
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      title: const Icon(
        Icons.warning,
        size: 100,
        color: Colors.red,
      ),
      content: const Text(
        "هل أنت متأكد أنك تريد حذف هذه المكتبات؟ ",
        textDirection: TextDirection.rtl,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
                    selectedAvaiabel = false;
                  });
                },
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                      color: purcolor, borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                      child: Text(
                    "إلغاء",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
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
                    libraryListChild.removeAt(element);
                  }

                  SharedPreferences liblist =
                      await SharedPreferences.getInstance();
                  List<String> v = [];
                  for (lib l in libraryListChild) {
                    String s = convertLibString(l);
                    v.add(s);
                  }
                  liblist.setStringList("liblistChild", v);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainParentPage(index: 0)),
                      (route) => false);
                },
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                      color: purcolor, borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                      child: Text(
                    "نعم، متأكد",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
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
