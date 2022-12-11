import 'dart:convert';

import '/childpage/parent/mainparent.dart';
import '/childpage/parent/rearrangeFavChild.dart';
import '/controller/istablet.dart';
import '/controller/speak.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/images.dart';
import '../../controller/var.dart';

class ParentSettingsFav extends StatefulWidget {
  const ParentSettingsFav({super.key});

  @override
  State<ParentSettingsFav> createState() => _ParentSettingsFavState();
}

class _ParentSettingsFavState extends State<ParentSettingsFav> {
  List<List> favorite = [];
  bool isLoading = true;
  List isSelected = [];
  bool selectedAvaiabel = false;
  @override
  void initState() {
    getFavData().then((v) {
      setState(() {
        isLoading = false;
      });
    });

    super.initState();
  }

  getFavData() async {
    SharedPreferences favlist = await SharedPreferences.getInstance();
    var tem = favlist.getStringList("favlistChild");
    if (tem != null) {
      for (var element in tem) {
        List test = json.decode(element);
        favorite.add(test);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'المفضلة',
                style: TextStyle(
                    color: maincolor,
                    fontSize: 60,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
        //  backgroundColor: maincolor,
        actions: [
          !selectedAvaiabel
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedAvaiabel = false;
                          });
                        },
                        child: Text(
                          "إلغاء",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                      ),
                      Container(
                        width: 60,
                      ),
                      InkWell(
                        onTap: () {
                          showAlertDialog(context);
                        },
                        child: Text(
                          "حفظ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                )
        ],
      ),
      body: Column(children: [
        selectedAvaiabel
            ? Container(
                height: 50,
              )
            : Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReArrangeFavChild()),
                            (route) => false);
                      },
                      child: Container(
                        height: DeviceUtil.isTablet ? 50 : 35,
                        width: DeviceUtil.isTablet ? 180 : 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 202, 202, 202)),
                          color: Color.fromARGB(255, 255, 255, 255)
                              .withOpacity(0.3),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 217, 216, 216)
                                  .withOpacity(0.4),
                              spreadRadius: 3,
                              blurRadius: 7,
                              //offset: Offset(0, 3)),
                            )
                          ],
                        ),
                        child: Center(
                            child: Text(
                          "إعادة ترتيب",
                          style: TextStyle(
                              color: maincolor,
                              fontWeight: FontWeight.bold,
                              fontSize: DeviceUtil.isTablet ? 25 : 17),
                        )),
                      ),
                    ),
                    Container(
                      width: 10,
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     setState(() {
                    //       isSelected = [];
                    //       selectedAvaiabel = true;
                    //     });
                    //   },
                    //   child: Container(
                    //     height: DeviceUtil.isTablet ? 50 : 35,
                    //     width: DeviceUtil.isTablet ? 150 : 90,
                    //     decoration: BoxDecoration(
                    //         color: maincolor,
                    //         borderRadius: BorderRadius.circular(10)),
                    //     child: Center(
                    //         child: Text(
                    //       "حذف مكتبة",
                    //       style: TextStyle(
                    //           color: Colors.white,
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: DeviceUtil.isTablet ? 25 : 17),
                    //     )),
                    //   ),
                    // ),
                  ],
                ),
              ),
        Expanded(
          child: ListView(
            children: [
              for (int i = 0; i < favorite.length; i++)
                Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        if (selectedAvaiabel) {
                          if (isSelected.contains(i)) {
                            setState(() {
                              isSelected.remove(i);
                            });
                          } else {
                            setState(() {
                              isSelected.add(i);
                            });
                          }
                        } else {
                          String a = "";
                          favorite[i].forEach((element) {
                            a += element[0] + " ";
                          });
                          howtospeak(a);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.grey, width: 2)),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        child: Container(
                                          height:
                                              DeviceUtil.isTablet ? 170 : 100,
                                          width: DeviceUtil.isTablet ? 120 : 70,
                                          color: greenColor,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                                size: DeviceUtil.isTablet
                                                    ? 80
                                                    : 60,
                                              ),
                                              Text(
                                                'حذف',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 28),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        child: Container(
                                          height:
                                              DeviceUtil.isTablet ? 170 : 100,
                                          width: DeviceUtil.isTablet ? 120 : 70,
                                          color: greenColor,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.volume_up,
                                                color: Colors.white,
                                                size: DeviceUtil.isTablet
                                                    ? 80
                                                    : 60,
                                              ),
                                              Text(
                                                'نطق',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 28),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height:
                                              DeviceUtil.isTablet ? 170 : 100,
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              for (int j = 0;
                                                  j < favorite[i].length;
                                                  j++)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15, right: 15),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                          height: DeviceUtil
                                                                  .isTablet
                                                              ? 100
                                                              : 70,
                                                          width: DeviceUtil
                                                                  .isTablet
                                                              ? 100
                                                              : 50,
                                                          child: getImage(
                                                              favorite[i][j]
                                                                  [1])),
                                                      Container(
                                                        height:
                                                            DeviceUtil.isTablet
                                                                ? 10
                                                                : 0,
                                                      ),
                                                      Text(
                                                        favorite[i][j][0],
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: DeviceUtil
                                                                    .isTablet
                                                                ? 30
                                                                : 20),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                    !selectedAvaiabel
                        ? Container()
                        : isSelected.contains(i)
                            ? Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: 34,
                                  width: 34,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 224, 223, 223),
                                      borderRadius: BorderRadius.circular(40),
                                      border: Border.all(
                                          color: Colors.red, width: 3)),
                                  child: const Icon(
                                    Icons.done,
                                    color: Colors.red,
                                    size: 25,
                                  ),
                                ),
                              )
                            : Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: 34,
                                  width: 34,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 224, 223, 223),
                                      borderRadius: BorderRadius.circular(40),
                                      border: Border.all(
                                          color: Colors.red, width: 3)),
                                ),
                              ),
                  ],
                )
            ],
          ),
        ),
      ]),
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
      content: Text(
        "هل أنت متأكد أنك تريد حذف هذه المفضلة؟ ",
        textDirection: TextDirection.rtl,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: DeviceUtil.isTablet ? 25 : 17),
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
                  height: DeviceUtil.isTablet ? 50 : 35,
                  width: DeviceUtil.isTablet ? 150 : 100,
                  decoration: BoxDecoration(
                      color: maincolor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
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
                  SharedPreferences favv =
                      await SharedPreferences.getInstance();
                  List theSelectedItem = isSelected;
                  theSelectedItem.sort();
                  theSelectedItem = theSelectedItem.reversed.toList();

                  for (var element in theSelectedItem) {
                    favorite.removeAt(element);
                  }

                  ///////////////////////////
                  List<String> allFav = [];
                  favorite.forEach((oneFav) {
                    String newFav = "";
                    for (int y = 0; y < oneFav.length; y++) {
                      String input = oneFav[y][0];
                      String imurl = oneFav[y][1];
                      String isimup = oneFav[y][2];
                      String voiceurl = oneFav[y][3];
                      String voiceCache = oneFav[y][4];
                      String isvoiceUp = oneFav[y][5];

                      if (y == oneFav.length - 1) {
                        newFav +=
                            """["$input","$imurl","$isimup","$voiceurl","$voiceCache","$isvoiceUp"]""";
                      } else {
                        newFav +=
                            """["$input","$imurl","$isimup","$voiceurl","$voiceCache","$isvoiceUp"],""";
                      }
                    }
                    newFav = "[$newFav]";
                    allFav.add(newFav);
                  });

                  favv.setStringList("favlistChild", allFav);
                  //////////////////////////

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainParentPage(index: 1)),
                      (route) => false);
                },
                child: Container(
                  height: DeviceUtil.isTablet ? 50 : 35,
                  width: DeviceUtil.isTablet ? 150 : 100,
                  decoration: BoxDecoration(
                      color: maincolor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
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
