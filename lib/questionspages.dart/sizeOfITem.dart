// ignore_for_file: file_names

import 'package:arabic_speaker_child/questionspages.dart/childFirstInfo.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/istablet.dart';
import '../controller/var.dart';

class NumofItems extends StatefulWidget {
  const NumofItems({Key? key}) : super(key: key);

  @override
  State<NumofItems> createState() => _NumofItemsState();
}

class _NumofItemsState extends State<NumofItems> {
  int itemsnum = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/uiImages/bg.png"),
                  fit: BoxFit.cover)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SafeArea(
            child: Center(
              child: Container(
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height * .70
                        : MediaQuery.of(context).size.height * .9,
                width: DeviceUtil.isTablet
                    ? MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.width * .6
                        : MediaQuery.of(context).size.width * .44
                    : MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.width * .8
                        : MediaQuery.of(context).size.width * .5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border.all(color: const Color(0xff989999), width: 2),
                    borderRadius: BorderRadius.circular(40)),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Column(children: [
                    Container(
                      height: DeviceUtil.isTablet ? 18 : 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        "اختر حجم \nالأيقونات المناسب",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: DeviceUtil.isTablet ? 50 : 27,
                          color: maincolor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? DeviceUtil.isTablet
                              ? 22
                              : 14
                          : 20,
                    ),
                    Text(
                      "يمكنك التعديل لاحقا",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: greyColor,
                          fontSize: DeviceUtil.isTablet ? 22 : 17,
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(DeviceUtil.isTablet ? 40 : 20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: const Color.fromARGB(255, 255, 255, 255)
                              .withOpacity(0.8),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(60)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset: const Offset(0, 3)),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.portrait
                                              ? 100
                                              : 50,
                                          width: MediaQuery.of(context)
                                                      .orientation ==
                                                  Orientation.portrait
                                              ? 50
                                              : 20,
                                          decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/uiImages/bigBox.png"),
                                                  fit: BoxFit.fill)),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2),
                                          child: Container(
                                            height: 20,
                                            width: 50,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/uiImages/horBig.png"),
                                                    fit: BoxFit.fill)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 3.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 100,
                                            width: 50,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/uiImages/bigBox.png"),
                                                    fit: BoxFit.fill)),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2),
                                            child: Container(
                                              height: 20,
                                              width: 50,
                                              decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/uiImages/horBig.png"),
                                                      fit: BoxFit.fill)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 60),
                                      child: Center(
                                        child: Lottie.asset(
                                          "assets/15-ratio-outline (1).json",
                                          width: 150,
                                          height: 150,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 60),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/uiImages/boxSmall.png"),
                                                    fit: BoxFit.fill)),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/uiImages/boxSmall.png"),
                                                      fit: BoxFit.fill)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 3.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/uiImages/boxSmall.png"),
                                                    fit: BoxFit.fill)),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2),
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/uiImages/boxSmall.png"),
                                                      fit: BoxFit.fill)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: DeviceUtil.isTablet ? 20 : 10),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Slider(
                                      onChanged: (value) {
                                        setState(() {
                                          itemsnum = value.toInt();
                                        });
                                      },
                                      value: itemsnum.toDouble(),
                                      max: 2,
                                      min: 1,
                                      divisions: 1,
                                      label: itemsnum.toString(),
                                      activeColor: const Color.fromARGB(
                                              220, 220, 220, 220)
                                          .withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "كبير",
                                    style: TextStyle(
                                      fontSize: DeviceUtil.isTablet ? 24 : 20,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Text(
                                      "عادي",
                                      style: TextStyle(
                                        fontSize: DeviceUtil.isTablet ? 24 : 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              SharedPreferences si =
                                  await SharedPreferences.getInstance();
                              if (itemsnum == 1) {
                                si.setInt("size", 1);
                              } else {
                                si.setInt("size", 0);
                              }
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Selectedlib()),
                                  (route) => false);
                            },
                            child: Image.asset(
                              "assets/uiImages/next.png",
                              height: DeviceUtil.isTablet ? 85 : 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
