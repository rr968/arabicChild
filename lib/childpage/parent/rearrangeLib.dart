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
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color:
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
                borderRadius: const BorderRadius.all(Radius.circular(27)),
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
                    padding: const EdgeInsets.all(8.0),
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
                                  style: const TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  Container(
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 70, 70, 70),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        (i + 1).toString(),
                        style: const TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
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
                        fontSize: 45,
                        fontWeight: FontWeight.w900),
                  ),
                  Container(
                    height: 60,
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * .44,
                      width: MediaQuery.of(context).size.width - 70,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 202, 202, 202)),
                        color: const Color.fromARGB(255, 255, 255, 255)
                            .withOpacity(0.3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(27)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 5,
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 25, bottom: 25, right: 10),
                        child: DraggableGridViewBuilder(
                          controller: controllerList,
                          scrollDirection: Axis.vertical,
                          dragFeedback:
                              (List<DraggableGridItem> list, int index) {
                            return SizedBox(
                              width: 150,
                              height: 150,
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
                                          ? 5
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
                                            const MainParentPage(index: 0)),
                                    (route) => false);
                                // acceptalert(context, "تم الحفظ بنجاح");
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 200,
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
                                            const MainParentPage(index: 0)),
                                    (route) => false);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 200,
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
