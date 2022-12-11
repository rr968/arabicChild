import 'dart:convert';
import '/childpage/parent/mainparent.dart';
import '/controller/images.dart';
import '/controller/istablet.dart';
import 'package:provider/provider.dart';

import '../../controller/my_provider.dart';
import '/controller/erroralert.dart';
import '/view/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/libtostring.dart';
import '../../controller/var.dart';
import '../../model/content.dart';
import '../../model/library.dart';

class ReArrangeContentChild extends StatefulWidget {
  final int contentIndex;
  const ReArrangeContentChild({Key? key, required this.contentIndex})
      : super(key: key);

  @override
  State<ReArrangeContentChild> createState() => _ReArrangeContentChildState();
}

class _ReArrangeContentChildState extends State<ReArrangeContentChild> {
  final List<DraggableGridItem> _draggList = [];
  getDraggbleItems() {
    for (int i = 0;
        i < libraryListChild[widget.contentIndex].contenlist.length;
        i++) {
      _draggList.add(DraggableGridItem(
        isDraggable: true,
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
            borderRadius: BorderRadius.all(Radius.circular(27)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3)),
            ],
            border: Border.all(
              width: 2,
              color: Colors.grey,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Expanded(
                  child: getImage(libraryListChild[widget.contentIndex]
                      .contenlist[i]
                      .imgurl)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(
                    child: Text(
                      libraryListChild[widget.contentIndex].contenlist[i].name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ));
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
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: const Drawerc(),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: isloading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/uiImages/bg.png"),
                            fit: BoxFit.cover)),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 80),
                        child: Text(
                          'إعادة ترتيب الجمل',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: purcolor,
                              fontSize: 45,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 70,
                        height: 290,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 202, 202, 202)),
                          color: Color.fromARGB(255, 255, 255, 255)
                              .withOpacity(0.3),
                          borderRadius: BorderRadius.all(Radius.circular(27)),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 217, 216, 216)
                                  .withOpacity(0.4),
                              spreadRadius: 3,
                              blurRadius: 7,
                            )
                          ],
                        ),
                        child: Container(
                            width: MediaQuery.of(context).size.width - 250,
                            height:
                                MediaQuery.of(context).size.height / 3 - 100,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 25, bottom: 25),
                              child: DraggableGridViewBuilder(
                                scrollDirection: Axis.horizontal,
                                dragFeedback:
                                    (List<DraggableGridItem> list, int index) {
                                  return SizedBox(
                                    width: 90,
                                    height: 100,
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
                                        crossAxisCount: 1,
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 20,
                                        childAspectRatio: 1 / 1),
                                dragCompletion: (List<DraggableGridItem> list,
                                    int beforeIndex, int afterIndex) {
                                  setState(() {
                                    final elementLibrary =
                                        libraryListChild[widget.contentIndex]
                                            .contenlist
                                            .elementAt(beforeIndex);
                                    libraryListChild[widget.contentIndex]
                                        .contenlist
                                        .removeAt(beforeIndex);
                                    libraryListChild[widget.contentIndex]
                                        .contenlist
                                        .insert(afterIndex, elementLibrary);
                                    final elementDraggable =
                                        _draggList.elementAt(beforeIndex);
                                    _draggList.removeAt(beforeIndex);
                                    _draggList.insert(
                                        afterIndex, elementDraggable);
                                  });
                                },
                                children: _draggList,
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                updateSharedPreferences().then((v) {
                                  getdata();
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .setIscontentOfLibrary(
                                          widget.contentIndex);

                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainParentPage(
                                                index: 0,
                                              )),
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
                                child: Text(
                                  "حفظ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Provider.of<MyProvider>(context, listen: false)
                                    .setIscontentOfLibrary(widget.contentIndex);

                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainParentPage(
                                              index: 0,
                                            )),
                                    (route) => false);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 200,
                                decoration: BoxDecoration(
                                    color: pinkColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  "إلغاء",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
