// ignore_for_file: use_build_context_synchronously, file_names

import 'dart:convert';

import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:arabic_speaker_child/view/export_and_import/importlibrary.dart';

import '../../controller/checkinternet.dart';
import '../../controller/exportnote.dart';
import '/controller/erroralert.dart';
import '/controller/var.dart';
import '/model/library.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/content.dart';

class LibraryUploadedSettings extends StatefulWidget {
  const LibraryUploadedSettings({Key? key}) : super(key: key);

  @override
  State<LibraryUploadedSettings> createState() =>
      _LibraryUploadedSettingsState();
}

class _LibraryUploadedSettingsState extends State<LibraryUploadedSettings> {
  int loadingIndex = -1;
  int loadingIndexT = -1;
  final key = GlobalKey<AnimatedListState>();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> data = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> allData = [];
  bool loading = true;
  String searchText = "";
  final TextEditingController _controller = TextEditingController(text: "");

  @override
  void initState() {
    getdata().then((value) {
      setState(() {
        loading = false;
      });
    });

    super.initState();
  }

  Future getdata() async {
    await FirebaseFirestore.instance.collection("Shared").get().then((value) {
      for (var element in value.docs) {
        if (element.data()["approval"] != "true") {
          data.add(element);
          allData.add(element);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: AnimatedSearchBar(
            label: "ابحث",
            labelStyle: const TextStyle(),
            alignment: TextAlign.center,
            controller: _controller,
            searchStyle: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            searchDecoration: const InputDecoration(
              hintText: "ابحث هنا",
              alignLabelWithHint: true,
              focusColor: Colors.white,
              hintStyle:
                  TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
              border: InputBorder.none,
            ),
            onChanged: (value) {
              setState(() {
                searchText = value.trim();
                data = dataAfterSearch(value);
              });
            },
          ),
          /*const Text(
            "تنزيل مكتبات",
            style: TextStyle(
                fontSize: 24, //fontWeight: FontWeight.bold,
                color: Colors.white),
          ),*/
          backgroundColor: maincolor,
        ),
        body: loading
            ? Center(
                child: CircularProgressIndicator(
                  color: maincolor,
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 25),
                child: AnimatedList(
                    key: key,
                    initialItemCount: data.length,
                    itemBuilder: ((context, index, animation) {
                      return buildItem(data[index], index, animation);
                    }))),
      ),
    );
  }

  buildItem(item, index, animation) {
    return ScaleTransition(
      scale: animation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: FittedBox(
          child: Container(
            width: 330,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: maincolor, width: 2)),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        "اسم التصدير : ${data[index]["name"]}",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                          "اسم الناشر : ${data[index]["publisherName"]}",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8, bottom: 7),
                      child: Text(
                          "شرح عن التصدير : ${data[index]["explaination"]}",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      loadingIndexT != index
                          ? InkWell(
                              onTap: () {
                                if (data.length > 1) {
                                  internetConnection().then((value) {
                                    setState(() {
                                      loadingIndexT = index;
                                    });
                                    if (value == true) {
                                      FirebaseFirestore.instance
                                          .collection("Shared")
                                          .doc(data[index].id)
                                          .update({"approval": "true"}).then(
                                              (v) {
                                        final item = data.removeAt(index);
                                        key.currentState?.removeItem(
                                            index,
                                            (context, animation) => buildItem(
                                                item, index, animation));
                                        setState(() {
                                          loadingIndexT = -1;
                                        });
                                      });
                                    } else {
                                      erroralert(
                                          context, "يرجى الاتصال بالانترنت");
                                    }
                                  });
                                } else {
                                  cantDelete(context);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: maincolor,
                                      size: 25,
                                    ),
                                    Text(
                                      "  موافقة ",
                                      style: TextStyle(
                                          color: maincolor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Center(
                              child: CircularProgressIndicator(
                              color: maincolor,
                            )),
                      loadingIndex != index
                          ? InkWell(
                              onTap: () async {
                                if (data.length > 1) {
                                  internetConnection().then((value) {
                                    setState(() {
                                      loadingIndex = index;
                                    });
                                    if (value == true) {
                                      FirebaseFirestore.instance
                                          .collection("Shared")
                                          .doc(data[index].id)
                                          .delete()
                                          .then((v) {
                                        final item = data.removeAt(index);
                                        key.currentState?.removeItem(
                                            index,
                                            (context, animation) => buildItem(
                                                item, index, animation));
                                        setState(() {
                                          loadingIndex = -1;
                                        });
                                      });
                                    } else {
                                      erroralert(
                                          context, "يرجى الاتصال بالانترنت");
                                    }
                                  });
                                } else {
                                  cantDelete(context);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: maincolor,
                                      size: 25,
                                    ),
                                    Text(
                                      "  مخالف ",
                                      style: TextStyle(
                                          color: maincolor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Center(
                              child: CircularProgressIndicator(
                              color: maincolor,
                            )),
                      TextButton(
                          onPressed: () {
                            List<lib> library = [];
                            for (var element in data[index]["data"]) {
                              List e = json.decode(element);
                              List<Content> contentlist = [];
                              for (List l in e[3]) {
                                contentlist.add(Content(
                                    l[0], l[1], l[2], l[3], l[4], l[5]));
                              }
                              library.add(lib(e[0], e[1], e[2], contentlist));
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ImportLibrary(data: library)));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder,
                                color: maincolor,
                              ),
                              Text(
                                "محتوى المكتبة",
                                style: TextStyle(
                                    color: maincolor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ],
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> dataAfterSearch(value) {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> returnList = [];

    for (var element in allData) {
      if (element["name"].contains(value) ||
          element["publisherName"].contains(value) ||
          element["explaination"].contains(value)) {
        returnList.add(element);
      }
    }
    return returnList;
  }
}
