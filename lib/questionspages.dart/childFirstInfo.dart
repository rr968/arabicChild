// ignore_for_file: use_build_context_synchronously, file_names

import 'package:arabic_speaker_child/model/libraryToChoose.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../controller/istablet.dart';
import '../controller/libtostring.dart';
import '../model/content.dart';
import '../model/library.dart';

import '../controller/var.dart';
import '../childpage/child/mainchildPage.dart';

class Selectedlib extends StatefulWidget {
  const Selectedlib({Key? key}) : super(key: key);

  @override
  State<Selectedlib> createState() => _SelectedlibState();
}

class _SelectedlibState extends State<Selectedlib> {
  List<int> indexesChooese = [];
  int selectAl = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: Padding(
        padding: DeviceUtil.isTablet
            ? const EdgeInsets.only(top: 30, right: 20, left: 20)
            : const EdgeInsets.only(top: 15, right: 10, left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "اختر المكتبات لاستخدامها\n في التطبيق",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: DeviceUtil.isTablet ? 42 : 26,
                              color: maincolor,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: DeviceUtil.isTablet ? 30 : 15,
                        ),
                        const Text("يمكنك التعديل لاحقاً",
                            style: TextStyle(fontSize: 15))
                      ],
                    ),
                  ),
                  Container(
                    height: 150,
                    width: DeviceUtil.isTablet ? 200 : 150,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/uiImages/chooseLibImage.png"),
                            fit: BoxFit.fill)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: DeviceUtil.isTablet ? 30 : 11, right: 15, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  indexesChooese.isNotEmpty
                      ? Text(
                          "${indexesChooese.length}  من  ${chooseLibrary.length} ",
                          style: TextStyle(
                              fontSize: DeviceUtil.isTablet ? 28 : 20,
                              fontWeight: FontWeight.bold),
                        )
                      : Container(),
                  InkWell(
                    onTap: () {
                      if (selectAl == 0) {
                        indexesChooese = [];
                        for (int i = 0; i < chooseLibrary.length; i++) {
                          setState(() {
                            indexesChooese.add(i);
                          });
                        }
                        setState(() {
                          selectAl = 1;
                        });
                      } else {
                        setState(() {
                          indexesChooese = [];
                          selectAl = 0;
                        });
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(0.1),
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Row(
                        children: [
                          Icon(
                            selectAl != 0
                                ? Icons.check_circle_outline
                                : Icons.circle_outlined,
                            size: DeviceUtil.isTablet ? 30 : 20,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            'تحديد الكل',
                            style: TextStyle(
                              fontSize: DeviceUtil.isTablet ? 20 : 15,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color:
                      const Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
                  borderRadius: const BorderRadius.all(Radius.circular(27)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: const Offset(0, 3)),
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: DeviceUtil.isTablet ? 10 : 4,
                              crossAxisSpacing: DeviceUtil.isTablet ? 10 : 4,
                              crossAxisCount:
                                  MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? DeviceUtil.isTablet
                                          ? 5
                                          : 4
                                      : 7,
                            ),
                            scrollDirection: Axis.vertical,
                            itemCount: chooseLibrary.length,
                            itemBuilder: ((context, index) {
                              return InkWell(
                                onTap: () {
                                  if (indexesChooese.contains(index)) {
                                    setState(() {
                                      indexesChooese.remove(index);
                                    });
                                  } else {
                                    setState(() {
                                      indexesChooese.add(index);
                                    });
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      DeviceUtil.isTablet ? 8.0 : 4),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: greyColor),
                                      color: const Color.fromARGB(
                                              255, 255, 255, 255)
                                          .withOpacity(0.5),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              DeviceUtil.isTablet ? 27 : 20)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.7),
                                          spreadRadius: 0,
                                          blurRadius: 7,
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
                                                    child: Image.asset(
                                                        chooseLibrary[index]
                                                            .imgurl)),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5),
                                                  child: FittedBox(
                                                    child: Text(
                                                      chooseLibrary[index].name,
                                                      style: TextStyle(
                                                          fontSize: DeviceUtil
                                                                  .isTablet
                                                              ? 25
                                                              : 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                )
                                              ])),
                                          indexesChooese.contains(index)
                                              ? Align(
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                    height: DeviceUtil.isTablet
                                                        ? 30
                                                        : 20,
                                                    width: DeviceUtil.isTablet
                                                        ? 30
                                                        : 20,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              27),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.white
                                                              .withOpacity(0.5),
                                                          spreadRadius: 3,
                                                          blurRadius: 7,
                                                          //offset: Offset(0, 3)),
                                                        )
                                                      ],
                                                    ),
                                                    child: Icon(
                                                      Icons.circle,
                                                      color: Colors.red,
                                                      size: DeviceUtil.isTablet
                                                          ? 25
                                                          : 18,
                                                    ),
                                                  ),
                                                )
                                              : Align(
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                      height: DeviceUtil.isTablet
                                                          ? 30
                                                          : 20,
                                                      width: DeviceUtil.isTablet
                                                          ? 30
                                                          : 20,
                                                      decoration: BoxDecoration(
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              224, 223, 223),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                          border: Border.all(
                                                              color: Colors.red,
                                                              width: 3))),
                                                )
                                        ]),
                                  ),
                                ),
                              );
                            })))
                  ],
                ),
              ),
            ),
            Expanded(child: Container()),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    if (indexesChooese.isNotEmpty) {
                      SharedPreferences liblistChild =
                          await SharedPreferences.getInstance();
                      List<String> libstring = [];
                      for (var index in indexesChooese) {
                        libstring.add(convertLibString(chooseLibrary[index]));
                      }
                      liblistChild.setStringList("liblistChild", libstring);

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainChildPage(
                                    index: 0,
                                  )));
                    } else {
                      SharedPreferences liblistChild =
                          await SharedPreferences.getInstance();
                      List<String> libstring = [];
                      int j = chooseLibrary.length;
                      for (var i = 0; i < j; i++) {
                        libstring.add(convertLibString(chooseLibrary[i]));
                      }
                      liblistChild.setStringList("liblistChild", libstring);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainChildPage(
                                    index: 0,
                                  )));
                    }
                  },
                  child: Image.asset(
                    "assets/uiImages/start.png",
                    height: DeviceUtil.isTablet ? 85 : 50,
                  ),
                ),
                Container(
                  height: DeviceUtil.isTablet ? 18 : 12,
                ),
                InkWell(
                  onTap: () async {
                    SharedPreferences liblistChild =
                        await SharedPreferences.getInstance();
                    List<String> libstring = [];
                    int j = chooseLibrary.length;
                    for (var i = 0; i < j; i++) {
                      libstring.add(convertLibString(chooseLibrary[i]));
                    }
                    liblistChild.setStringList("liblistChild", libstring);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainChildPage(
                                  index: 0,
                                )));
                  },
                  child: Text(
                    "تخطي هذا",
                    style: TextStyle(
                        color: greyColor,
                        fontWeight: FontWeight.bold,
                        fontSize: DeviceUtil.isTablet ? 20 : 17),
                  ),
                ),
                Container(
                  height: 18,
                ),
              ],
            ),
            Expanded(child: Container()),
          ],
        ),
      )),
    );
  }
}
