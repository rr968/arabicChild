// ignore_for_file: file_names

import 'dart:convert';
import '/childpage/parent/mainparent.dart';
import '/controller/images.dart';
import '/controller/istablet.dart';

import '/view/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/var.dart';

class ReArrangeFavChild extends StatefulWidget {
  const ReArrangeFavChild({
    Key? key,
  }) : super(key: key);

  @override
  State<ReArrangeFavChild> createState() => _ReArrangeFavChildState();
}

class _ReArrangeFavChildState extends State<ReArrangeFavChild> {
  final List<DraggableGridItem> _draggList = [];
  bool isLoading = true;
  List<List> favorite = [];
  getDraggbleItems() {
    for (int i = 0; i < favorite.length; i++) {
      _draggList.add(DraggableGridItem(
          isDraggable: true,
          child: Padding(
            padding: EdgeInsets.all(DeviceUtil.isTablet ? 15 : 5),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: maincolor, width: 2)),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      Container(
                        height: double.maxFinite,
                        width: 90,
                        decoration: BoxDecoration(
                            color: maincolor,
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        child: Icon(
                          Icons.volume_up,
                          color: Colors.white,
                          size: DeviceUtil.isTablet ? 80 : 60,
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (int j = 0; j < favorite[i].length; j++)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          height: 70,
                                          width: 70,
                                          child: getImage(favorite[i][j][1])),
                                      Container(
                                        height: 6,
                                      ),
                                      Text(
                                        favorite[i][j][0],
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            decoration: TextDecoration.none,
                                            fontSize: 27),
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
          )));
    }
  }

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
    await getDraggbleItems();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: const Drawerc(),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  Center(
                    child: Text(
                      'إعادة ترتيب',
                      style: TextStyle(
                          color: maincolor,
                          fontSize: 60,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
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
                                //  acceptalert(context, "تم الحفظ بنجاح");
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: maincolor,
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
                                height: 50,
                                width: 200,
                                decoration: BoxDecoration(
                                    color: maincolor,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        child: DraggableGridViewBuilder(
                          dragFeedback:
                              (List<DraggableGridItem> list, int index) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width * .7,
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
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                            childAspectRatio: 5 / 1.1,
                          ),
                          dragCompletion: (List<DraggableGridItem> list,
                              int beforeIndex, int afterIndex) {
                            setState(() {
                              final elementLibrary =
                                  favorite.elementAt(beforeIndex);
                              favorite.removeAt(beforeIndex);
                              favorite.insert(afterIndex, elementLibrary);
                              final elementDraggable =
                                  _draggList.elementAt(beforeIndex);
                              _draggList.removeAt(beforeIndex);
                              _draggList.insert(afterIndex, elementDraggable);
                            });
                          },
                          children: _draggList,
                        )),
                  ),
                ],
              ),
      ),
    );
  }

  Future updateSharedPreferences() async {
    SharedPreferences liblist = await SharedPreferences.getInstance();

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

    liblist.setStringList("favlistChild", allFav);
  }
}
