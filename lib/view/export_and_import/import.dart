// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:arabic_speaker_child/childpage/parent/mainparent.dart';
import 'package:arabic_speaker_child/controller/istablet.dart';
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
                size: DeviceUtil.isTablet ? 40 : 30,
              ),
            ),
            title: AnimatedSearchBar(
              closeIcon: Icon(
                Icons.close,
                size: DeviceUtil.isTablet ? 40 : 30,
              ),
              searchIcon: Icon(
                Icons.search,
                size: DeviceUtil.isTablet ? 40 : 30,
              ),
              label: "ابحث",
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: DeviceUtil.isTablet ? 30 : 25),
              alignment: TextAlign.center,
              controller: _controller,
              searchStyle: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              searchDecoration: const InputDecoration(
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
                  padding: EdgeInsets.only(
                      top: DeviceUtil.isTablet ? 30 : 10, bottom: 25),
                  child: ListView(
                    children: [
                      for (int index = 0; index < data.length; index++)
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: DeviceUtil.isTablet ? 15 : 10,
                                  top: 10),
                              child: Container(
                                width: DeviceUtil.isTablet
                                    ? MediaQuery.of(context).size.width * .75
                                    : MediaQuery.of(context).size.width * .9,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 10,
                                        spreadRadius: .5,
                                      )
                                    ],
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 172, 171, 171),
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
                                            padding: EdgeInsets.only(
                                                right: DeviceUtil.isTablet
                                                    ? 8
                                                    : 4),
                                            child: Text(
                                              "اسم التصدير : ${data[index]["name"]}",
                                              style: TextStyle(
                                                  fontSize: DeviceUtil.isTablet
                                                      ? 22
                                                      : 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                right: DeviceUtil.isTablet
                                                    ? 8
                                                    : 4),
                                            child: Text(
                                                "اسم الناشر : ${data[index]["publisherName"]}",
                                                style: TextStyle(
                                                    fontSize:
                                                        DeviceUtil.isTablet
                                                            ? 22
                                                            : 18,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                right:
                                                    DeviceUtil.isTablet ? 8 : 4,
                                                bottom: 7),
                                            child: Text(
                                                "شرح عن التصدير : ${data[index]["explaination"]}",
                                                style: TextStyle(
                                                    fontSize:
                                                        DeviceUtil.isTablet
                                                            ? 22
                                                            : 18,
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
                                                /*   if (DateTime.now().isBefore(
                                                    DateTime.utc(
                                                        2023, 3, 27))) 
                                                        {
                                                  if (Platform.isAndroid) {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                PaymentView(
                                                                    amount:
                                                                        49)));
                                                  } else {
                                                    PayModel data =
                                                        await MoyasarPayment().applePay(
                                                            amount: 49,
                                                            publishableKey:
                                                                "pk_live_5HcCv9pGLqGGttnHj95LrTntgqphFMmn2Fop35dk",
                                                            applepayMerchantId:
                                                                "merchant.sa.org.tawasal.store",
                                                            paymentItems: {
                                                              ' ': 1.0
                                                            },
                                                            currencyCode: "SAR",
                                                            countryCode: "SA");
                                                    if (data.type != null) {
                                                      print(data.message);
                                                    } else {
                                                      ApplePayModel
                                                          applePayModel =
                                                          ApplePayModel
                                                              .fromJson(
                                                                  data.source);
                                                      internetConnection()
                                                          .then((value) {
                                                        if (value) {
                                                          initPlatformState()
                                                              .then((value) {
                                                            try {
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "payChildApp")
                                                                  .doc(
                                                                      "mi63rhuIAw1hKJDnLNwx")
                                                                  .set(
                                                                      {
                                                                    "${value[0]}${value[1]}": DateTime
                                                                            .now()
                                                                        .add(Duration(
                                                                            days:
                                                                                365))
                                                                  },
                                                                      SetOptions(
                                                                          merge:
                                                                              true));
                                                              Navigator.of(
                                                                      context)
                                                                  .pushReplacement(
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const MainChildPage(
                                                                    index: 0,
                                                                  ),
                                                                ),
                                                              );
                                                            } catch (e) {}
                                                          });
                                                        }
                                                      });
                                                    }
                                                  }
                                                } else {*/
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
                                                            const MainParentPage(
                                                                index: 1)));
                                                acceptalert(context,
                                                    "تم التنزيل بنجاح");
                                                // }
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Container(
                                                  height: DeviceUtil.isTablet
                                                      ? 50
                                                      : 40,
                                                  width: DeviceUtil.isTablet
                                                      ? 160
                                                      : 120,
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
                                                        size:
                                                            DeviceUtil.isTablet
                                                                ? 35
                                                                : 28,
                                                      ),
                                                      Text(
                                                        " تنزيل ",
                                                        style: TextStyle(
                                                            color: maincolor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: DeviceUtil
                                                                    .isTablet
                                                                ? 22
                                                                : 18),
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
                                                  height: DeviceUtil.isTablet
                                                      ? 50
                                                      : 40,
                                                  width: DeviceUtil.isTablet
                                                      ? 160
                                                      : 130,
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
                                                            fontSize: DeviceUtil
                                                                    .isTablet
                                                                ? 20
                                                                : 15),
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
