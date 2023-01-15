// ignore_for_file: file_names

import 'dart:convert';
import '/childpage/parent/mainparent.dart';

import '../../controller/istablet.dart';
import '/controller/images.dart';
import '/view/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/libtostring.dart';
import '../../controller/var.dart';
import '../../model/content.dart';
import '../../model/library.dart';

class ReArrangeLibraryChild extends StatefulWidget {
  const ReArrangeLibraryChild({
    Key? key,
  }) : super(key: key);

  @override
  State<ReArrangeLibraryChild> createState() => _ReArrangeLibraryChildState();
}

class _ReArrangeLibraryChildState extends State<ReArrangeLibraryChild> {
  final List<DraggableGridItem> _draggList = [];
  getDraggbleItems() {
    for (int i = 0; i < libraryListChild.length; i++) {
      _draggList.add(DraggableGridItem(
          isDraggable: true,
          child: Padding(
            padding: EdgeInsets.all(DeviceUtil.isTablet ? 8 : 2),
            child: Container(
              decoration: BoxDecoration(
                color:
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
                borderRadius: BorderRadius.all(
                    Radius.circular(DeviceUtil.isTablet ? 27 : 20)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 3)),
                ],
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Padding(
                    padding: EdgeInsets.all(DeviceUtil.isTablet ? 8 : 5),
                    child: Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: getImage(libraryListChild[i].imgurl)),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: DeviceUtil.isTablet ? 10 : 0),
                              child: FittedBox(
                                child: Text(
                                  libraryListChild[i].name,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: DeviceUtil.isTablet ? 25 : 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  Container(
                    height: DeviceUtil.isTablet ? 38 : 20,
                    width: DeviceUtil.isTablet ? 38 : 20,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 70, 70, 70),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        (i + 1).toString(),
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: DeviceUtil.isTablet ? 30 : 13),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )));
    }
  }

  final controllerList = ScrollController();
  double currentOffsetScroll = 0;
  bool isloading = true;
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
    SharedPreferences liblist = await SharedPreferences.getInstance();
    List<String>? library = liblist.getStringList("liblistChild");

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
    await getDraggbleItems();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        drawer: const Drawerc(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,

          // backgroundColor: maincolor,
        ),
        body: isloading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                  ),
                  Text(
                    'إعادة ترتيب المكتبات',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: purcolor,
                        fontSize: DeviceUtil.isTablet ? 45 : 30,
                        fontWeight: FontWeight.w900),
                  ),
                  Container(
                    height: DeviceUtil.isTablet ? 60 : 28,
                  ),
                  Container(
                      width: DeviceUtil.isTablet
                          ? MediaQuery.of(context).size.width - 70
                          : MediaQuery.of(context).size.width - 35,
                      height: MediaQuery.of(context).size.height * .44,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 202, 202, 202)),
                        color: const Color.fromARGB(255, 255, 255, 255)
                            .withOpacity(0.3),
                        borderRadius: BorderRadius.all(Radius.circular(27)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 5,
                          )
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: DeviceUtil.isTablet ? 25 : 8,
                            bottom: DeviceUtil.isTablet ? 25 : 8,
                            right: DeviceUtil.isTablet ? 10 : 5),
                        child: DraggableGridViewBuilder(
                          controller: controllerList,
                          scrollDirection: Axis.vertical,
                          dragFeedback:
                              (List<DraggableGridItem> list, int index) {
                            return SizedBox(
                              width: DeviceUtil.isTablet ? 150 : 90,
                              height: DeviceUtil.isTablet ? 150 : 90,
                              child: list[index].child,
                            );
                          },
                          isOnlyLongPress: false,
                          dragPlaceHolder:
                              (List<DraggableGridItem> list, index) {
                            return PlaceHolderWidget(
                              child: Container(
                                color: Colors.white,
                              ),
                            );
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      MediaQuery.of(context).orientation ==
                                              Orientation.portrait
                                          ? DeviceUtil.isTablet
                                              ? 5
                                              : 4
                                          : 7,
                                  childAspectRatio: 1 / 1),
                          dragCompletion: (List<DraggableGridItem> list,
                              int beforeIndex, int afterIndex) {
                            setState(() {
                              final elementLibrary =
                                  libraryListChild.elementAt(beforeIndex);
                              libraryListChild.removeAt(beforeIndex);
                              libraryListChild.insert(
                                  afterIndex, elementLibrary);
                              final elementDraggable =
                                  _draggList.elementAt(beforeIndex);
                              _draggList.removeAt(beforeIndex);
                              _draggList.insert(afterIndex, elementDraggable);
                            });
                          },
                          children: _draggList,
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                            onTap: () {
                              updateSharedPreferences().then((v) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MainParentPage(index: 1)),
                                    (route) => false);
                                // acceptalert(context, "تم الحفظ بنجاح");
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: DeviceUtil.isTablet ? 50 : 44,
                              width: DeviceUtil.isTablet ? 200 : 100,
                              decoration: BoxDecoration(
                                  color: greenColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Text(
                                "حفظ",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MainParentPage(index: 1)),
                                    (route) => false);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: DeviceUtil.isTablet ? 50 : 44,
                                width: DeviceUtil.isTablet ? 200 : 100,
                                decoration: BoxDecoration(
                                    color: pinkColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Text(
                                  "إلغاء",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future updateSharedPreferences() async {
    SharedPreferences liblist = await SharedPreferences.getInstance();
    List<String> v = [];
    for (lib l in libraryListChild) {
      String s = convertLibString(l);
      v.add(s);
    }
    liblist.setStringList("liblistChild", v);
  }
}
