// ignore_for_file: file_names

import 'dart:convert';

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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                'المفضلة',
                style: TextStyle(
                    color: maincolor,
                    fontSize: DeviceUtil.isTablet ? 60 : 35,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
      body: favorite.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/uiImages/noSaved.png",
                  height: DeviceUtil.isTablet ? 150 : 100,
                ),
                Container(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "لم تقم باضافة جمل الى مفضلة بعد",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: DeviceUtil.isTablet ? 30 : 24),
                  ),
                ),
              ],
            )
          : Column(children: [
              Padding(
                padding: EdgeInsets.only(
                    right: DeviceUtil.isTablet ? 30 : 10,
                    top: DeviceUtil.isTablet ? 20 : 4,
                    bottom: DeviceUtil.isTablet ? 18 : 10),
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ReArrangeFavChild()),
                          (route) => false);
                    },
                    child: Container(
                      height: DeviceUtil.isTablet ? 50 : 35,
                      width: DeviceUtil.isTablet ? 180 : 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 202, 202, 202)),
                        color: maincolor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 217, 216, 216)
                                .withOpacity(0.4),
                            spreadRadius: 3,
                            blurRadius: 7,
                          )
                        ],
                      ),
                      child: Center(
                          child: Text(
                        "إعادة ترتيب",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: DeviceUtil.isTablet ? 25 : 17),
                      )),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (int i = 0; i < favorite.length; i++)
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            left: DeviceUtil.isTablet ? 30 : 10,
                            right: DeviceUtil.isTablet ? 30 : 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                SharedPreferences favv =
                                    await SharedPreferences.getInstance();

                                setState(() {
                                  favorite.removeAt(i);
                                });

                                List<String> allFav = [];
                                for (var oneFav in favorite) {
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
                                }

                                favv.setStringList("favlistChild", allFav);
                              },
                              child: Container(
                                height: DeviceUtil.isTablet ? 120 : 90,
                                width: DeviceUtil.isTablet ? 80 : 60,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: DeviceUtil.isTablet ? 50 : 35,
                                    ),
                                    Text(
                                      'حذف',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              DeviceUtil.isTablet ? 28 : 22),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                String a = "";
                                for (var element in favorite[i]) {
                                  a += element[0] + " ";
                                }
                                howtospeak(a, context);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: DeviceUtil.isTablet ? 13 : 7),
                                child: Container(
                                  height: DeviceUtil.isTablet ? 120 : 90,
                                  width: DeviceUtil.isTablet ? 80 : 60,
                                  decoration: BoxDecoration(
                                      color: maincolor,
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.volume_up,
                                        color: Colors.white,
                                        size: DeviceUtil.isTablet ? 54 : 35,
                                      ),
                                      Text(
                                        'نطق',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                DeviceUtil.isTablet ? 28 : 22),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  String a = "";
                                  for (var element in favorite[i]) {
                                    a += element[0] + " ";
                                  }
                                  howtospeak(a, context);
                                },
                                child: Container(
                                  height: DeviceUtil.isTablet ? 120 : 90,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20)),
                                      border: Border.all(
                                          width: 2, color: maincolor)),
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      for (int j = 0;
                                          j < favorite[i].length;
                                          j++)
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left:
                                                  DeviceUtil.isTablet ? 10 : 5,
                                              right:
                                                  DeviceUtil.isTablet ? 10 : 5,
                                              bottom: 5,
                                              top: 5),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                  height: DeviceUtil.isTablet
                                                      ? 50
                                                      : 45,
                                                  width: DeviceUtil.isTablet
                                                      ? 50
                                                      : 45,
                                                  child: getImage(
                                                      favorite[i][j][1])),
                                              Container(
                                                height:
                                                    DeviceUtil.isTablet ? 5 : 2,
                                              ),
                                              Text(
                                                favorite[i][j][0],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        DeviceUtil.isTablet
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
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ]),
    );
  }
}
