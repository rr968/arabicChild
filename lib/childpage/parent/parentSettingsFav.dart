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
                    fontSize: 60,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
      body: Column(children: [
        selectedAvaiabel
            ? Container(
                height: 50,
              )
            : Padding(
                padding: const EdgeInsets.only(right: 30, top: 20, bottom: 18),
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
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
                        color: maincolor,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 217, 216, 216)
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
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 30, right: 30),
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
                        },
                        child: Container(
                          height: 120,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 50,
                              ),
                              Text(
                                'حذف',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 28),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          String a = "";
                          favorite[i].forEach((element) {
                            a += element[0] + " ";
                          });
                          howtospeak(a);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 13),
                          child: Container(
                            height: 120,
                            width: 80,
                            decoration: BoxDecoration(
                                color: maincolor,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.volume_up,
                                  color: Colors.white,
                                  size: 54,
                                ),
                                Text(
                                  'نطق',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 28),
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
                            favorite[i].forEach((element) {
                              a += element[0] + " ";
                            });
                            howtospeak(a);
                          },
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20)),
                                border: Border.all(width: 2, color: maincolor)),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                for (int j = 0; j < favorite[i].length; j++)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 5, top: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            height: 50,
                                            width: 50,
                                            child: getImage(favorite[i][j][1])),
                                        Container(
                                          height: 5,
                                        ),
                                        Text(
                                          favorite[i][j][0],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: DeviceUtil.isTablet
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
