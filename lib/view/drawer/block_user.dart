import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../controller/checkinternet.dart';
import '../../controller/erroralert.dart';
import '../../controller/var.dart';

class BlockUser extends StatefulWidget {
  const BlockUser({super.key});

  @override
  State<BlockUser> createState() => _BlockUserState();
}

class _BlockUserState extends State<BlockUser> {
  late Map<String, dynamic> data;
  Widget theWidget = Container();
  TextEditingController textController = TextEditingController();
  bool isLoading = true;
  @override
  void initState() {
    internetConnection().then((value) async {
      if (value == true) {
        try {
          await FirebaseFirestore.instance
              .collection("blockedEmails")
              .doc("CFpjKa35zNa83PaQDtRU")
              .get()
              .then((v) {
            data = v.data() ?? {};

            setState(() {
              isLoading = false;
            });
          });
        } catch (_) {
          data = {};
          setState(() {
            isLoading = false;
          });
        }
      } else {
        data = {};
        setState(() {
          isLoading = false;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(backgroundColor: maincolor),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 15, right: 15, bottom: 20),
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: "أدخل الايميل",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
                InkWell(
                  onTap: () {
                    String text = textController.text.trim();
                    if (data.containsKey(text)) {
                      if (data[text].toString() == '["1","false"]' ||
                          data[text].toString() == '["1","true"]') {
                        setState(() {
                          theWidget = Container(
                            height: 160,
                            width: MediaQuery.of(context).size.width * .8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: maincolor, width: 3)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "لقد تم توجيه إنذار آول لهذا المستخدم",
                                  style: TextStyle(fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () async {
                                    setState(() {
                                      theWidget = const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    });
                                    try {
                                      data[text] = '["2","false"]';
                                      await FirebaseFirestore.instance
                                          .collection("blockedEmails")
                                          .doc("CFpjKa35zNa83PaQDtRU")
                                          .set(data);
                                      setState(() {
                                        theWidget = Container();
                                        textController.text = "";
                                        acceptalert(
                                            context, "تم التعديل بنجاح ");
                                      });
                                    } catch (_) {}
                                  },
                                  child: Container(
                                    height: 55,
                                    width: 170,
                                    decoration: BoxDecoration(
                                        color: maincolor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Center(
                                      child: Text(
                                        "توجيه إنذار ثاني",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                      } else if (data[text].toString() == '["2","false"]' ||
                          data[text].toString() == '["2","true"]') {
                        setState(() {
                          theWidget = Container(
                            height: 160,
                            width: MediaQuery.of(context).size.width * .8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: maincolor, width: 3)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const FittedBox(
                                  child: Text(
                                    "لقد تم توجيه إنذار أول وثاني لهذا المستخدم",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () async {
                                    setState(() {
                                      theWidget = const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    });
                                    try {
                                      data[text] = '["3","false"]';
                                      await FirebaseFirestore.instance
                                          .collection("blockedEmails")
                                          .doc("CFpjKa35zNa83PaQDtRU")
                                          .set(data);
                                      setState(() {
                                        theWidget = Container();
                                        textController.text = "";
                                        acceptalert(
                                            context, "تم التعديل بنجاح ");
                                      });
                                    } catch (_) {}
                                  },
                                  child: Container(
                                    height: 55,
                                    width: 170,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Center(
                                      child: Text(
                                        "حظر المستخدم",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                      } else if (data[text].toString() == '["3","false"]') {
                        setState(() {
                          theWidget = Container(
                            height: 160,
                            width: MediaQuery.of(context).size.width * .8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: maincolor, width: 3)),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                  child: Text(
                                    "لقد تم توجيه ٣ انذارات لهذا المستخدم\nوتم حظره",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                      }
                    } else {
                      setState(() {
                        theWidget = Container(
                          height: 160,
                          width: MediaQuery.of(context).size.width * .8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: maincolor, width: 3)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "لم يتم توجيه أي إنذار لهذا المستخدم",
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () async {
                                  setState(() {
                                    theWidget = const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  });
                                  try {
                                    data[text] = '["1","false"]';
                                    await FirebaseFirestore.instance
                                        .collection("blockedEmails")
                                        .doc("CFpjKa35zNa83PaQDtRU")
                                        .set(data);
                                    setState(() {
                                      theWidget = Container();
                                      textController.text = "";
                                      acceptalert(context, "تم التعديل بنجاح ");
                                    });
                                  } catch (_) {}
                                },
                                child: Container(
                                  height: 55,
                                  width: 170,
                                  decoration: BoxDecoration(
                                      color: maincolor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Center(
                                    child: Text(
                                      "توجيه إنذار أول",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                    }
                  },
                  child: Container(
                    height: 55,
                    width: 120,
                    decoration: BoxDecoration(
                        color: maincolor,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        "إبحث",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 45),
                  child: theWidget,
                )
              ]),
      ),
    );
  }
}
