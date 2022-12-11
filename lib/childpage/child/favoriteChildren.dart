import 'dart:convert';

import '/controller/images.dart';
import '/controller/istablet.dart';
import '/controller/speak.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/var.dart';

class FavoriteChildren extends StatefulWidget {
  const FavoriteChildren({super.key});

  @override
  State<FavoriteChildren> createState() => _FavoriteChildrenState();
}

class _FavoriteChildrenState extends State<FavoriteChildren> {
  List<List> favorite = [];
  bool isLoading = true;
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
      body: favorite.length == 0
          ? Center(
              child: Text(
                "لم تم باضافة جمل مفضلة بعد",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            )
          : Column(children: [
              Container(
                height: 15,
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (int i = 0; i < favorite.length; i++)
                      InkWell(
                        onTap: () {
                          String a = "";
                          favorite[i].forEach((element) {
                            a += element[0] + " ";
                          });
                          howtospeak(a);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal:
                                  MediaQuery.of(context).size.width * .06),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      color: Color(0xff724666), width: 3)),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Row(
                                  children: [
                                    Container(
                                      height: DeviceUtil.isTablet ? 170 : 110,
                                      width: DeviceUtil.isTablet ? 120 : 80,
                                      decoration: BoxDecoration(
                                          color: Color(0xff724666),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(25),
                                              bottomRight:
                                                  Radius.circular(25))),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.volume_up,
                                            color: Colors.white,
                                            size: 80,
                                          ),
                                          Text(
                                            "نطق",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        height: DeviceUtil.isTablet ? 170 : 110,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            for (int j = 0;
                                                j < favorite[i].length;
                                                j++)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        height:
                                                            DeviceUtil.isTablet
                                                                ? 100
                                                                : 60,
                                                        width:
                                                            DeviceUtil.isTablet
                                                                ? 100
                                                                : 60,
                                                        child: getImage(
                                                            favorite[i][j][1])),
                                                    Container(
                                                      height:
                                                          DeviceUtil.isTablet
                                                              ? 10
                                                              : 5,
                                                    ),
                                                    Text(
                                                      favorite[i][j][0],
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 30),
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
                              )),
                        ),
                      )
                  ],
                ),
              ),
            ]),
    );
  }
}
