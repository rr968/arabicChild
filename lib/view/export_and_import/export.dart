// ignore_for_file: dead_code

import 'dart:convert';
import '/childpage/child/mainchildPage.dart';
import '/controller/allUploadedDone.dart';
import '/controller/uploaddataChild.dart';
import 'package:just_audio/just_audio.dart';

import '/controller/checkinternet.dart';
import '/controller/erroralert.dart';
import '/controller/images.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/libtostring.dart';
import '../../controller/var.dart';
import '../../model/content.dart';
import '../../model/library.dart';

//not Correct
class Export extends StatefulWidget {
  const Export({Key? key}) : super(key: key);

  @override
  State<Export> createState() => _ExportState();
}

class _ExportState extends State<Export> {
  int pageindex = 1;
  bool isloading = true;
  final controller = DragSelectGridViewController();
  @override
  void initState() {
    controller.addListener(() {
      setState(() {});
    });
    getdata().then((v) {
      setState(() {
        isloading = false;
      });
    }).then((v) {
      show(context);
    });
    super.initState();
  }

  getdata() async {
    libraryList = [];
    SharedPreferences liblist = await SharedPreferences.getInstance();
    List<String>? library = liblist.getStringList("liblist");
    if (library != null) {
      for (String element in library) {
        List e = json.decode(element);
        List<Content> contentlist = [];
        for (List l in e[3]) {
          contentlist.add(Content(l[0], l[1], l[2], l[3], l[4], l[5]));
        }
        libraryList.add(lib(e[0], e[1], e[2], contentlist));
      }
    }
  }

  @override
  void dispose() {
    controller.addListener(() {
      setState(() {});
    });
    super.dispose();
  }

  playaudio() async {
    final player = AudioPlayer();
    await player.setAsset(noteVoices[notevoiceindex]);
    player.play();
  }

  @override
  Widget build(BuildContext context) {
    final isSelectedAnyItem = controller.value.isSelecting;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: pageindex,
            onTap: (index) {
              if (index == 3) {
                playaudio();
              } else {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainChildPage(index: index)),
                    (route) => false);
              }
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: maincolor,
            unselectedItemColor: Colors.black,
            selectedFontSize: 20,
            unselectedFontSize: 18,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.wechat),
                label: "التحدث",
                activeIcon: Container(
                  decoration: BoxDecoration(
                    color: maincolor,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.wechat,
                      color: pageindex == 0 ? Colors.white : maincolor,
                    ),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.my_library_books),
                label: "المكتبة",
                activeIcon: Container(
                  decoration: BoxDecoration(
                    color: maincolor,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.my_library_books,
                      color: pageindex == 1 ? Colors.white : maincolor,
                    ),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.star),
                label: "المفضلة",
                activeIcon: Container(
                  decoration: BoxDecoration(
                    color: maincolor,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.star,
                      color: pageindex == 2 ? Colors.white : maincolor,
                    ),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.notifications),
                label: "تنبيه",
                activeIcon: Container(
                  decoration: BoxDecoration(
                    color: maincolor,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.notifications,
                      color: pageindex == 3 ? Colors.white : maincolor,
                    ),
                  ),
                ),
              )
            ]),
        appBar: AppBar(
          title: isSelectedAnyItem
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          "${controller.value.amount} ",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                        const Text(
                          " من المكتبات",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Set<int> indexes = {};
                        for (int i = 0; i < libraryList.length; i++) {
                          indexes.add(i);
                        }
                        controller.value = Selection(indexes);
                      },
                      child: Column(
                        children: const [
                          Icon(
                            Icons.checklist,
                            color: Colors.white,
                          ),
                          Text(
                            "تحديد الكل",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )
                        ],
                      ),
                    ),

//////////////////////////////////////////////////////

                    Padding(
                      padding: const EdgeInsets.only(right: 7),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Column(
                          children: const [
                            Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            Text(
                              "إلغاء",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),

                    /////////////////////////////////////////////////////
                  ],
                )
              : const Text(
                  "رفع المكتبات",
                  style: TextStyle(
                      fontSize: 24,
                      //  fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
          backgroundColor: maincolor,
        ),
        body: isloading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(),
                      isSelectedAnyItem
                          ? Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: SizedBox(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(85, 31),
                                    backgroundColor: maincolor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(11)),
                                  ),
                                  onPressed: () {
                                    List<int> theSelectedItem = controller
                                        .value.selectedIndexes
                                        .toList();
                                    List<String> dataToExport = [];
                                    for (int i in theSelectedItem) {
                                      String s =
                                          convertLibString(libraryList[i]);
                                      dataToExport.add(s);
                                    }
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          bool isloading = false;
                                          TextEditingController name =
                                              TextEditingController();

                                          TextEditingController publisherName =
                                              TextEditingController();

                                          TextEditingController explaination =
                                              TextEditingController();
                                          return Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Center(
                                              child: SingleChildScrollView(
                                                child: AlertDialog(
                                                  title: Directionality(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child: Column(
                                                      children: [
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: FittedBox(
                                                            child: Text(
                                                              "معلومات المكتبات المرغوب مشاركتها",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 25),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 35,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 20,
                                                            right: 20,
                                                            //bottom: 11,
                                                          ),
                                                          child: TextFormField(
                                                            controller: name,
                                                            maxLength: 25,
                                                            maxLines: 1,
                                                            decoration:
                                                                InputDecoration(
                                                              // hintText: "اسم التصدير",
                                                              labelText:
                                                                  "اسم النسخة",
                                                              hintStyle: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              labelStyle: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 22,
                                                                  color:
                                                                      maincolor),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                        color:
                                                                            maincolor),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          13.0),
                                                                ),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                        color:
                                                                            maincolor),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          13.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const Text(
                                                          "* هذا الاسم سيظهر للمستخدمين عند تنزيل المكتبة",
                                                          // textAlign: TextAlign.right,
                                                          // ignore: prefer_const_constructors
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 40,
                                                                  bottom: 20,
                                                                  right: 20,
                                                                  left: 20),
                                                          child: TextFormField(
                                                            controller:
                                                                publisherName,
                                                            maxLength: 25,
                                                            maxLines: 1,
                                                            decoration:
                                                                InputDecoration(
                                                              //   hintText: "اسم الناشر",
                                                              labelText:
                                                                  "اسم الناشر",
                                                              hintStyle: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              labelStyle: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 22,
                                                                  color:
                                                                      maincolor),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                        color:
                                                                            maincolor),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          13.0),
                                                                ),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                        color:
                                                                            maincolor),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          13.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 20,
                                                                  right: 20),
                                                          child: TextFormField(
                                                            controller:
                                                                explaination,
                                                            maxLength: 120,
                                                            minLines: 4,
                                                            maxLines: 4,
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  "شرح توضيحي عن المكتبات ",
                                                              hintStyle: const TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              labelStyle: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 22,
                                                                  color:
                                                                      maincolor),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                        color:
                                                                            maincolor),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          13.0),
                                                                ),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                        color:
                                                                            maincolor),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          13.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 20),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  if (name.text
                                                                          .isEmpty ||
                                                                      publisherName
                                                                          .text
                                                                          .isEmpty ||
                                                                      explaination
                                                                          .text
                                                                          .isEmpty) {
                                                                    erroralert(
                                                                        context,
                                                                        "يجب ملىء جميع الحقول");
                                                                  } else {
                                                                    internetConnection()
                                                                        .then(
                                                                            (value) {
                                                                      if (value ==
                                                                          true) {
                                                                        setState(
                                                                            () {
                                                                          isloading =
                                                                              true;
                                                                        });
                                                                        tryUploadDataChild()
                                                                            .then((v) {
                                                                          allUploadedDataChildDone()
                                                                              .then((value2) {
                                                                            if (value2 ==
                                                                                true) {
                                                                              FirebaseFirestore.instance.collection("Shared").doc().set({
                                                                                "data": dataToExport,
                                                                                "name": name.text,
                                                                                "publisherName": publisherName.text,
                                                                                "explaination": explaination.text,
                                                                                "approval": "no"
                                                                              }).then((value) {
                                                                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MainChildPage(index: 1)), (route) => false);
                                                                                acceptalert(
                                                                                  context,
                                                                                  "تم النشر يمكنك الوصول للمكتبة من خلال اعدادات -> تنزيل المكتبات",
                                                                                );
                                                                              });
                                                                            } else {
                                                                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MainChildPage(index: 1)), (route) => false);
                                                                              erroralert(context, "حاول مرة اخرى");
                                                                            }
                                                                          });
                                                                        });
                                                                      } else {
                                                                        erroralert(
                                                                            context,
                                                                            "يرجى الاتصال بالانترنت");
                                                                      }
                                                                    });
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 50,
                                                                  width: 100,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      color:
                                                                          maincolor),
                                                                  child: Center(
                                                                    child:
                                                                        FittedBox(
                                                                      child: isloading
                                                                          ? const Center(
                                                                              child: CircularProgressIndicator(),
                                                                            )
                                                                          : const Text(
                                                                              "رفع",
                                                                              style: TextStyle(color: Colors.white, fontSize: 25),
                                                                            ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),

                                                            ////////////////////////////////// الغاء
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .only(
                                                                  // left: 65,
                                                                  // right: 65,
                                                                  top: 20),
                                                              child: InkWell(
                                                                onTap: (() {
                                                                  Navigator.pop(
                                                                      context);
                                                                }),
                                                                child:
                                                                    Container(
                                                                  height: 50,
                                                                  width: 100,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      color:
                                                                          maincolor),
                                                                  child: Center(
                                                                    child:
                                                                        FittedBox(
                                                                      child: isloading
                                                                          ? const Center(
                                                                              child: CircularProgressIndicator(),
                                                                            )
                                                                          : const Text(
                                                                              "إلغاء",
                                                                              style: TextStyle(color: Colors.white, fontSize: 25),
                                                                            ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 35,
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
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.cloud_upload,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text(
                                          "رفع",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(
                              height: 30,
                            )
                    ],
                  ),
                  //................................
                  Row(
                    children: const [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 23, bottom: 18),
                          child: Text(
                            "اضغط لعدة ثواني لاختيار المكتبات المرغوب مشاركتها",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //................................
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SafeArea(
                      child: SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height -
                            AppBar().preferredSize.height -
                            230,
                        child: DragSelectGridView(
                            gridController: controller,
                            itemCount: libraryList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                            ),
                            itemBuilder: ((context, index, isSelected) {
                              return Stack(
                                children: [
                                  Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: maincolor, width: 1.5),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(children: [
                                        const SizedBox(
                                          height: 7,
                                        ),
                                        Expanded(
                                            child: getImage(
                                                libraryList[index].imgurl)),
                                        Text(
                                          libraryList[index].name,
                                          style: const TextStyle(
                                              fontSize: 21,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ])),
                                  !isSelectedAnyItem
                                      ? Container()
                                      : isSelected
                                          ? Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Container(
                                                height: 23,
                                                width: 23,
                                                decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 224, 223, 223),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    border: Border.all(
                                                        color: Colors.red,
                                                        width: 3)),
                                                child: const Icon(
                                                  Icons.done,
                                                  color: Colors.red,
                                                  size: 17,
                                                ),
                                              ),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Container(
                                                height: 23,
                                                width: 23,
                                                decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 224, 223, 223),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    border: Border.all(
                                                        color: Colors.red,
                                                        width: 3)),
                                              ),
                                            )
                                ],
                              );
                            })),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

show(context) {
  showDialog(
      context: context,
      builder: (context) {
        return FittedBox(
          child: AlertDialog(
            //.................................
            title: Column(
              //.......title: Column(),
              children: [
                SizedBox(
                    height: 90,
                    child: Image.asset(
                      "assets/warning.png",
                      fit: BoxFit.fill,
                    )),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  " تنبيه",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                )
              ],
            ),

            content: FittedBox(
              child: Column(
                children: [
                  const Center(
                      child: Text(
                    "سوف تقوم بمشاركة المكتبات المختارة مع بقية المستخدمين",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  const SizedBox(
                    height: 37, // height: 20,
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: maincolor,
                        borderRadius: BorderRadius.circular(30),
                        //border: Border.all(width: 2)
                      ),
                      child: const Center(
                          child: Text(
                        "موافق", // "إغلاق",
                        //...................................

                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}
