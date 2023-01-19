// ignore_for_file: file_names

import 'dart:convert';

import 'package:arabic_speaker_child/controller/istablet.dart';
import 'package:provider/provider.dart';

import '../../controller/my_provider.dart';
import '../../controller/var.dart';
import '/controller/images.dart';
import '/controller/speak.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteChildren extends StatefulWidget {
  const FavoriteChildren({super.key});

  @override
  State<FavoriteChildren> createState() => _FavoriteChildrenState();
}

class _FavoriteChildrenState extends State<FavoriteChildren> {
  List<List> favorite = [];
  bool isLoading = true;
  int currentIndex = -1;
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
                    color: pinkColor,
                    fontSize: DeviceUtil.isTablet ? 50 : 33,
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
                    "لم تقم باضافة جمل مفضلة بعد",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: DeviceUtil.isTablet ? 30 : 24),
                  ),
                ),
              ],
            )
          : SizedBox(
              height: DeviceUtil.isTablet
                  ? MediaQuery.of(context).size.height - 170
                  : MediaQuery.of(context).size.height - 180,
              child: Column(children: [
                Container(
                  height: DeviceUtil.isTablet ? 10 : 0,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: DeviceUtil.isTablet ? 7 : 4,
                            horizontal: DeviceUtil.isTablet
                                ? MediaQuery.of(context).size.width * .06
                                : 15),
                        child: Text(
                          "عدد الجمل : ${favorite.length.toString()}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: DeviceUtil.isTablet ? 30 : 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      for (int i = 0; i < favorite.length; i++)
                        InkWell(
                          onTap: () {
                            bool t =
                                Provider.of<MyProvider>(context, listen: false)
                                    .isSpeakingNow;

                            if (!t) {
                              setState(() {
                                currentIndex = i;
                              });
                              String a = "";
                              for (var element in favorite[i]) {
                                a += element[0] + " ";
                              }
                              howtospeak(a, context);
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: DeviceUtil.isTablet ? 11 : 5,
                                horizontal: DeviceUtil.isTablet
                                    ? MediaQuery.of(context).size.width * .06
                                    : 15),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Provider.of<MyProvider>(context,
                                                    listen: true)
                                                .isSpeakingNow &&
                                            currentIndex == i
                                        ? pinkColor.withOpacity(.5)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        DeviceUtil.isTablet ? 30 : 25),
                                    border:
                                        Border.all(color: pinkColor, width: 3)),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: DeviceUtil.isTablet ? 130 : 100,
                                        width: DeviceUtil.isTablet ? 110 : 70,
                                        decoration: BoxDecoration(
                                            color: pinkColor,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(
                                                    DeviceUtil.isTablet
                                                        ? 25
                                                        : 17),
                                                bottomRight: Radius.circular(
                                                    DeviceUtil.isTablet
                                                        ? 25
                                                        : 17))),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.volume_up,
                                              color: Colors.white,
                                              size:
                                                  DeviceUtil.isTablet ? 65 : 50,
                                            ),
                                            Text(
                                              "نطق",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: DeviceUtil.isTablet
                                                      ? 28
                                                      : 24),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height:
                                              DeviceUtil.isTablet ? 130 : 100,
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              for (int j = 0;
                                                  j < favorite[i].length;
                                                  j++)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8, right: 8),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        child: SizedBox(
                                                            height: DeviceUtil
                                                                    .isTablet
                                                                ? 90
                                                                : 55,
                                                            width: DeviceUtil
                                                                    .isTablet
                                                                ? 90
                                                                : 55,
                                                            child: getImage(
                                                                favorite[i][j]
                                                                    [1])),
                                                      ),
                                                      Container(
                                                        height: 7,
                                                      ),
                                                      Text(
                                                        favorite[i][j][0],
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: DeviceUtil
                                                                    .isTablet
                                                                ? 30
                                                                : 22),
                                                      ),
                                                      Container(
                                                        height: 7,
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
                          ),
                        )
                    ],
                  ),
                ),
              ]),
            ),
    );
  }
}
