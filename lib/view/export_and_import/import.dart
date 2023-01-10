// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:arabic_speaker_child/childpage/parent/mainparent.dart';
import 'package:arabic_speaker_child/view/export_and_import/importlibrary.dart';

import '/controller/erroralert.dart';
import '/controller/var.dart';
import '/model/library.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/content.dart';

class Import extends StatefulWidget {
  const Import({Key? key}) : super(key: key);

  @override
  State<Import> createState() => _ImportState();
}

class _ImportState extends State<Import> {
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
      data = value.docs;
      allData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: 40,
              ),
            ),
            title: AnimatedSearchBar(
              closeIcon: Icon(
                Icons.close,
                size: 40,
              ),
              searchIcon: Icon(
                Icons.search,
                size: 40,
              ),
              label: "ابحث",
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              alignment: TextAlign.center,
              controller: _controller,
              searchStyle: TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              searchDecoration: InputDecoration(
                hintText: "ابحث هنا",
                alignLabelWithHint: true,
                focusColor: Colors.white,
                hintStyle: TextStyle(
                    color: Colors.white70,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value.trim();
                  print(searchText);
                  data = dataAfterSearch(value);
                });
              },
            ),
            backgroundColor: maincolor,
          ),
          body: loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: maincolor,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 25),
                  child: ListView(
                    children: [
                      for (int index = 0; index < data.length; index++)
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 15, top: 10),
                              child: Container(
                                width: MediaQuery.of(context).size.width * .75,
                                height: 170,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 10,
                                        spreadRadius: .5,
                                      )
                                    ],
                                    border: Border.all(
                                        color:
                                            Color.fromARGB(255, 172, 171, 171),
                                        width: 3)),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 8),
                                            child: Text(
                                              "اسم التصدير : ${data[index]["name"]}",
                                              style: const TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 8),
                                            child: Text(
                                                "اسم الناشر : ${data[index]["publisherName"]}",
                                                style: const TextStyle(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8, bottom: 7),
                                            child: Text(
                                                "شرح عن التصدير : ${data[index]["explaination"]}",
                                                style: const TextStyle(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                SharedPreferences liblistChild =
                                                    await SharedPreferences
                                                        .getInstance();
                                                List<String> past =
                                                    liblistChild.getStringList(
                                                            "liblistChild") ??
                                                        [];
                                                for (var element in data[index]
                                                    ["data"]) {
                                                  past.add(element.toString());
                                                }
                                                liblistChild.setStringList(
                                                    "liblistChild", past);
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MainParentPage(
                                                                index: 0)));
                                                acceptalert(context,
                                                    "تم التنزيل بنجاح");
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Container(
                                                  height: 50,
                                                  width: 160,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: maincolor,
                                                          width: 3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.download,
                                                        color: maincolor,
                                                        size: 35,
                                                      ),
                                                      Text(
                                                        " تنزيل ",
                                                        style: TextStyle(
                                                            color: maincolor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 22),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  List<lib> library = [];
                                                  for (var element
                                                      in data[index]["data"]) {
                                                    List e =
                                                        json.decode(element);
                                                    List<Content> contentlist =
                                                        [];
                                                    for (List l in e[3]) {
                                                      contentlist.add(Content(
                                                          l[0],
                                                          l[1],
                                                          l[2],
                                                          l[3],
                                                          l[4],
                                                          l[5]));
                                                    }
                                                    library.add(lib(e[0], e[1],
                                                        e[2], contentlist));
                                                  }
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ImportLibrary(
                                                                  data:
                                                                      library)));
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 160,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: maincolor,
                                                          width: 3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.folder,
                                                        color: maincolor,
                                                      ),
                                                      Text(
                                                        "محتوى المكتبة",
                                                        style: TextStyle(
                                                            color: maincolor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ))),
    );
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> dataAfterSearch(value) {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> returnList = [];

    allData.forEach((element) {
      if (element["name"].contains(value) ||
          element["publisherName"].contains(value) ||
          element["explaination"].contains(value)) {
        returnList.add(element);
      }
    });
    return returnList;
  }
}
