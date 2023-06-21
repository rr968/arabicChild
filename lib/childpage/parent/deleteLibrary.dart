// ignore_for_file: file_names, use_build_context_synchronously

import '/childpage/parent/mainparent.dart';

import '/controller/images.dart';
import '/controller/istablet.dart';
import '/controller/var.dart';
import '/model/library.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/libtostring.dart';

class DeleteLibrary extends StatefulWidget {
  const DeleteLibrary({super.key});

  @override
  State<DeleteLibrary> createState() => _DeleteLibraryState();
}

class _DeleteLibraryState extends State<DeleteLibrary> {
  List isSelected = [];

  final controllerList = ScrollController();
  double currentOffsetScroll = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(right: 17, bottom: 25, top: 50),
                child: Column(
                  children: [
                    Text(
                      "حـذف مكتبة",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: purcolor,
                          fontSize: DeviceUtil.isTablet ? 45 : 26,
                          fontWeight: FontWeight.w900),
                    ),
                    Container(
                      height: DeviceUtil.isTablet ? 40 : 30,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(right: DeviceUtil.isTablet ? 30 : 10),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "تم تحديدد ${isSelected.length} من المكتبات",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: DeviceUtil.isTablet ? 25 : 19,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ],
                )),
            Container(
              width: DeviceUtil.isTablet
                  ? MediaQuery.of(context).size.width - 70
                  : MediaQuery.of(context).size.width - 35,
              height: MediaQuery.of(context).size.height * .44,
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 202, 202, 202)),
                color:
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.3),
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: GridView.builder(
                        padding: const EdgeInsets.all(1),
                        controller: controllerList,
                        scrollDirection: Axis.vertical,
                        itemCount: libraryListChild.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? DeviceUtil.isTablet
                                  ? 5
                                  : 4
                              : 7,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if (isSelected.contains(index)) {
                                setState(() {
                                  isSelected.remove(index);
                                });
                              } else {
                                setState(() {
                                  isSelected.add(index);
                                });
                              }
                            },
                            child: Padding(
                              padding:
                                  EdgeInsets.all(DeviceUtil.isTablet ? 8 : 4),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: greyColor),
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255)
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
                                      padding: const EdgeInsets.all(8),
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
                                              style: TextStyle(
                                                  fontSize: DeviceUtil.isTablet
                                                      ? 25
                                                      : 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    isSelected.contains(index)
                                        ? Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                              height:
                                                  DeviceUtil.isTablet ? 34 : 20,
                                              width:
                                                  DeviceUtil.isTablet ? 34 : 20,
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(27)),
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
                                              height:
                                                  DeviceUtil.isTablet ? 34 : 21,
                                              width:
                                                  DeviceUtil.isTablet ? 34 : 21,
                                              decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 224, 223, 223),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
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
            Padding(
              padding: EdgeInsets.all(DeviceUtil.isTablet ? 50 : 20),
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
                      height: DeviceUtil.isTablet ? 50 : 40,
                      width: DeviceUtil.isTablet ? 200 : 130,
                      decoration: BoxDecoration(
                          color: greenColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "حذف",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: DeviceUtil.isTablet ? 25 : 20),
                      ),
                    ),
                  ),
                  Container(
                    width: DeviceUtil.isTablet ? 100 : 40,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: DeviceUtil.isTablet ? 50 : 40,
                      width: DeviceUtil.isTablet ? 200 : 130,
                      decoration: BoxDecoration(
                          color: pinkColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "إلغاء",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: DeviceUtil.isTablet ? 25 : 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
        "هل أنت متأكد أنك تريد حذف هذه المكتبات؟ ",
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
                  Navigator.pop(context);
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
                          builder: (context) => const MainParentPage(index: 1)),
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
