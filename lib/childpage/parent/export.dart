// ignore_for_file: file_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../controller/allUploadedDone.dart';
import '../../controller/checkinternet.dart';
import '../../controller/erroralert.dart';
import '../../controller/uploaddataChild.dart';

import '/childpage/parent/mainparent.dart';

import '/controller/images.dart';
import '/controller/istablet.dart';
import '/controller/my_provider.dart';
import '/controller/var.dart';
import '/model/library.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/libtostring.dart';

class Export extends StatefulWidget {
  const Export({super.key});

  @override
  State<Export> createState() => _ExportState();
}

class _ExportState extends State<Export> {
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
              padding: const EdgeInsets.only(right: 17, bottom: 25, top: 50),
              child: Column(
                children: [
                  Text(
                    "رفع المكتبات",
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
              ),
            ),
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
                      List<String> dataToExport = [];
                      for (int i in isSelected) {
                        String s = convertLibString(libraryListChild[i]);
                        dataToExport.add(s);
                      } //here

                      showDialog(
                          context: context,
                          builder: (context) {
                            TextEditingController name =
                                TextEditingController();

                            TextEditingController publisherName =
                                TextEditingController();

                            TextEditingController explaination =
                                TextEditingController();
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                child: SingleChildScrollView(
                                  child: AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(DeviceUtil.isTablet
                                                ? 32
                                                : 20))),
                                    title: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Column(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: FittedBox(
                                              child: Text(
                                                "معلومات المكتبات المرغوب مشاركتها",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                DeviceUtil.isTablet ? 35 : 15,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left:
                                                  DeviceUtil.isTablet ? 20 : 8,
                                              right:
                                                  DeviceUtil.isTablet ? 20 : 8,
                                              //bottom: 11,
                                            ),
                                            child: TextFormField(
                                              controller: name,
                                              maxLength: 25,
                                              maxLines: 1,
                                              decoration: InputDecoration(
                                                // hintText: "اسم التصدير",
                                                labelText: "اسم النسخة",
                                                hintStyle: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                                labelStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 22,
                                                    color: maincolor),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: maincolor),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(13.0),
                                                  ),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: maincolor),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(13.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "* هذا الاسم سيظهر للمستخدمين عند تنزيل المكتبة",
                                            // textAlign: TextAlign.right,
                                            // ignore: prefer_const_constructors
                                            style: TextStyle(
                                                fontSize: DeviceUtil.isTablet
                                                    ? 14
                                                    : 11,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: DeviceUtil.isTablet
                                                    ? 40
                                                    : 10,
                                                bottom: DeviceUtil.isTablet
                                                    ? 20
                                                    : 10,
                                                right: DeviceUtil.isTablet
                                                    ? 20
                                                    : 8,
                                                left: DeviceUtil.isTablet
                                                    ? 20
                                                    : 8),
                                            child: TextFormField(
                                              controller: publisherName,
                                              maxLength: 25,
                                              maxLines: 1,
                                              decoration: InputDecoration(
                                                //   hintText: "اسم الناشر",
                                                labelText: "اسم الناشر",
                                                hintStyle: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                                labelStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 22,
                                                    color: maincolor),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: maincolor),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(13.0),
                                                  ),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: maincolor),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(13.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: DeviceUtil.isTablet
                                                    ? 20
                                                    : 8,
                                                right: DeviceUtil.isTablet
                                                    ? 20
                                                    : 8),
                                            child: TextFormField(
                                              controller: explaination,
                                              maxLength: 120,
                                              minLines:
                                                  DeviceUtil.isTablet ? 4 : 3,
                                              maxLines:
                                                  DeviceUtil.isTablet ? 4 : 3,
                                              decoration: InputDecoration(
                                                labelText:
                                                    "شرح توضيحي عن المكتبات ",
                                                hintStyle: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                labelStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        DeviceUtil.isTablet
                                                            ? 22
                                                            : 20,
                                                    color: maincolor),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: maincolor),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(13.0),
                                                  ),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: maincolor),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(13.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20),
                                                child: InkWell(
                                                  onTap: () {
                                                    if (name.text.isEmpty ||
                                                        publisherName
                                                            .text.isEmpty ||
                                                        explaination
                                                            .text.isEmpty) {
                                                      erroralert(context,
                                                          "يجب ملىء جميع الحقول");
                                                    } else {
                                                      internetConnection()
                                                          .then((value) {
                                                        if (value == true) {
                                                          Provider.of<MyProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .isLoading(true);
                                                          tryUploadDataChild()
                                                              .then((v) {
                                                            allUploadedDataChildDone()
                                                                .then((value2) {
                                                              if (value2 ==
                                                                  true) {
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "Shared")
                                                                    .doc()
                                                                    .set({
                                                                  "data":
                                                                      dataToExport,
                                                                  "name":
                                                                      name.text,
                                                                  "publisherName":
                                                                      publisherName
                                                                          .text,
                                                                  "explaination":
                                                                      explaination
                                                                          .text,
                                                                  "approval":
                                                                      "no"
                                                                }).then((value) {
                                                                  Navigator.pushAndRemoveUntil(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => const MainParentPage(
                                                                              index:
                                                                                  1)),
                                                                      (route) =>
                                                                          false);
                                                                  acceptalert(
                                                                    context,
                                                                    "سيتم نشر مكتبتك بعد مراجعتها يمكنك الوصول للمكتبات من خلال اعدادات -> تنزيل المكتبات",
                                                                  );
                                                                });
                                                              } else {
                                                                Navigator.pushAndRemoveUntil(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => const MainParentPage(
                                                                            index:
                                                                                1)),
                                                                    (route) =>
                                                                        false);
                                                                erroralert(
                                                                    context,
                                                                    "حاول مرة اخرى");
                                                              }
                                                              Provider.of<MyProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .isLoading(
                                                                      false);
                                                            });
                                                          });
                                                        } else {
                                                          erroralert(context,
                                                              "يرجى الاتصال بالانترنت");
                                                        }
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    height: DeviceUtil.isTablet
                                                        ? 50
                                                        : 44,
                                                    width: DeviceUtil.isTablet
                                                        ? 200
                                                        : 100,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color: maincolor),
                                                    child: Center(
                                                      child: Provider.of<
                                                                      MyProvider>(
                                                                  context,
                                                                  listen: true)
                                                              .isloading
                                                          ? const CircularProgressIndicator()
                                                          : FittedBox(
                                                              child: Text(
                                                                "رفع",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        DeviceUtil.isTablet
                                                                            ? 25
                                                                            : 20),
                                                              ),
                                                            ),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              ////////////////////////////////// الغاء
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    // left: 65,
                                                    // right: 65,
                                                    top: 20),
                                                child: InkWell(
                                                  onTap: (() {
                                                    Navigator.pop(context);
                                                  }),
                                                  child: Container(
                                                    height: DeviceUtil.isTablet
                                                        ? 50
                                                        : 44,
                                                    width: DeviceUtil.isTablet
                                                        ? 200
                                                        : 100,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color: maincolor),
                                                    child: Center(
                                                      child: FittedBox(
                                                        child: Text(
                                                          "إلغاء",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: DeviceUtil
                                                                      .isTablet
                                                                  ? 25
                                                                  : 20),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height:
                                                DeviceUtil.isTablet ? 35 : 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: DeviceUtil.isTablet ? 50 : 40,
                      width: DeviceUtil.isTablet ? 200 : 130,
                      decoration: BoxDecoration(
                          color: greenColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "رفع",
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
}
