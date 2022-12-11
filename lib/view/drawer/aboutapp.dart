// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/var.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: maincolor,
            title: const Text("عن التطبيق",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  //fontWeight: FontWeight.bold
                )),
          ),
          body: SafeArea(
              child: ListView(
            children: [
              Container(
                color: maincolor,
                height: 369,
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: Image.asset(
                    "assets/logo.png",
                    height: 963,
                    width: 963,
                  )),
                  const Text(
                    "المتحدث العربي",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    "Smart Arabic Speaker",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 31,
                  ),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(17),
                child: Text(
                    "أحدث تطبيق للتحدث و التواصل باللغة العربية لذوي صعوبات النطق للأطفال والبالغين و كبار السن.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23, //fontSize: 21,
                      color: Color.fromARGB(255, 21, 21, 21),
                      //  backgroundColor: Color.fromARGB(255, 230, 232, 233)
                    )),
              ),
              /* const Text(
                    "The advanced application for communication in Arabic for young and adult people with speech difficulties",
                    textAlign: TextAlign.center,
                  ),*/
              const SizedBox(
                height: 10,
              ),

              const Text(" تطبيق المتحدث العربي ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold, //fontSize: 21,

                    color: Color.fromARGB(255, 21, 21, 21),
                    //  backgroundColor: Color.fromARGB(255, 230, 232, 233)
                  )),
              const SizedBox(
                height: 11,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 227, 225, 226),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                height: 200,
                width: double.infinity,
                margin: const EdgeInsets.only(left: 50, right: 50),
                padding: const EdgeInsets.all(3),
                ////
                child: Column(
                  children: const [
                    Text("التوقع الذكي للكلمات",
                        style: TextStyle(
                          fontSize: 19,
                        )),
                    SizedBox(
                      height: 3,
                    ),
                    Text("تحديث كلمات التوقع تلقائيًا",
                        style: TextStyle(
                          fontSize: 19,
                        )),
                    SizedBox(
                      height: 3,
                    ),
                    Text("أفضل ناطق باللغة العربية",
                        style: TextStyle(
                          fontSize: 19,
                        )),
                    SizedBox(
                      height: 3,
                    ),
                    Text("تصميم وإضافة تصنيفات جديدة",
                        style: TextStyle(
                          fontSize: 19,
                        )),
                    Text("إمكانية مشاركة المكتبات مع الآخرين ",
                        style: TextStyle(
                          fontSize: 19,
                        )),
                  ],
                ),
              ),

              const SizedBox(
                height: 29,
              ),
              const Text(" التطبيق يخدم الفئات التالية",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    //    fontSize: 17,
                    // fontSize: 21,

                    color: Color.fromARGB(255, 21, 21, 21),
                    //  backgroundColor: Color.fromARGB(255, 230, 232, 233)
                  )),
              const SizedBox(
                height: 11,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: const [
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/family.png"),
                        backgroundColor: Color.fromARGB(255, 218, 221, 221),
                        radius: 31, // radius: 27,
                      ),
                      Text("التخاطب والتواصل",
                          style: TextStyle(
                            fontSize: 21,
                          )),
                    ],
                  ),
                  Column(
                    children: const [
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/couple.png"),
                        backgroundColor: Color.fromARGB(255, 218, 221, 221),
                        radius: 31, // radius: 27,
                      ),
                      Text("كبار السن",
                          style: TextStyle(
                            fontSize: 21,
                          )),
                    ],
                  ),
                  Column(
                    children: const [
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/wheelchair.jpg"),
                        backgroundColor: Color.fromARGB(255, 218, 221, 221),
                        radius: 31, // radius: 27,
                      ),
                      Text("حركي",
                          style: TextStyle(
                            fontSize: 21,
                          )),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 11, //40
              ),
              Padding(
                padding: const EdgeInsets.only(left: 55, right: 55),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: const [
                        CircleAvatar(
                          backgroundImage: AssetImage("assets/baby-boy.png"),
                          backgroundColor: Color.fromARGB(255, 218, 221, 221),
                          radius: 31, // radius: 27,
                        ),
                        Text("اطفال التوحد",
                            style: TextStyle(
                              fontSize: 21,
                            )),
                      ],
                    ),
                    Column(
                      children: const [
                        CircleAvatar(
                          backgroundImage: AssetImage("assets/ear.png"),
                          backgroundColor: Color.fromARGB(255, 218, 221, 221),
                          radius: 31, // radius: 27,
                        ),
                        Text("سمعي",
                            style: TextStyle(
                              fontSize: 21,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 11,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: const Color.fromARGB(255, 197, 197, 197),
                height: 51,
                width: double.infinity,
                child: const Center(
                    // center لوضع النص بالمنتصف
                    child: Padding(
                  padding: EdgeInsets.all(3),
                  child: Text(
                    " فكرة : د.أمل السيف  ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 19),
                  ),
                )),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(" تنفيذ وتشغيل    ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 27,
                    color: Colors.black,
                  )),
              Image.asset("assets/twasal.png", height: 270, width: 270),

              const Text(
                "V2-2022",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const Text(
                "تم تحديث التطبيق وإضافة ميزات جديدة",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),

              /////////////////////
              /////////////////////

              const SizedBox(
                height: 47, //60
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      String url = "http://mobile.twitter.com/tawasal2019";
                      launchUrl(Uri.parse(url));
                    },
                    child: Column(
                      children: [
                        Image.asset("assets/twitter.png",
                            fit: BoxFit.fill, height: 40, width: 40),
                        const Text("tawasal.2019",
                            style: TextStyle(
                              color: Color.fromARGB(255, 134, 133, 133),
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: () {
                          final Uri emailLaunchUri = Uri(
                            scheme: 'mailto',
                            path: "tawasal.2019@gmail.com",
                          );
                          launchUrl(emailLaunchUri);
                        },
                        child: Column(
                          children: const [
                            Icon(
                              Icons.email,
                              color: Color.fromARGB(255, 71, 71, 71),
                              size: 40,
                            ),
                            Text("tawasal2019",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 134, 133, 133),
                                )),
                          ],
                        )),
                  )
                ],
              )
            ],
          ))),
    );
  }
}
