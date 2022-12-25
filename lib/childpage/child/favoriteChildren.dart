import 'dart:convert';

import '../../controller/var.dart';
import '/controller/images.dart';
import '/controller/istablet.dart';
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
                    fontSize: 50,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
      body: favorite.length == 0
          ? Center(
              child: Text(
                "لم تم باضافة جمل مفضلة بعد",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            )
          : Container(
              height: MediaQuery.of(context).size.height - 170,
              child: Column(children: [
                Container(
                  height: 10,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 7,
                            horizontal:
                                MediaQuery.of(context).size.width * .06),
                        child: Text(
                          "عدد الجمل : ${favorite.length.toString()}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
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
                                vertical: 11,
                                horizontal:
                                    MediaQuery.of(context).size.width * .06),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border:
                                        Border.all(color: pinkColor, width: 3)),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 130,
                                        width: 110,
                                        decoration: BoxDecoration(
                                            color: pinkColor,
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
                                              size: 65,
                                            ),
                                            Text(
                                              "نطق",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 28),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height: 130,
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
                                                        child: Container(
                                                            height: 90,
                                                            width: 90,
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
                                                            fontSize: 30),
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
