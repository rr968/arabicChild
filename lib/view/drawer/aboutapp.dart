// ignore_for_file: depend_on_referenced_packages

import 'package:arabic_speaker_child/controller/istablet.dart';
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
            body: Stack(
          children: [
            Image.asset(
              "assets/uiImages/circle.png",
              height: DeviceUtil.isTablet ? 100 : 55,
              width: MediaQuery.of(context).size.width * .6,
              fit: BoxFit.fill,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "عن التطبيق",
                    style: TextStyle(
                        fontSize: DeviceUtil.isTablet ? 45 : 35,
                        fontWeight: FontWeight.bold,
                        color: pinkColor),
                  ),
                  Container(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.zero,
                    child: Image.asset(
                      "assets/uiImages/logo1.png",
                      height: DeviceUtil.isTablet ? 160 : 150,
                    ),
                  ),
                  Text("_________________________",
                      style: TextStyle(
                          fontSize: DeviceUtil.isTablet ? 35 : 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey)),
                  Container(
                    height: 10,
                  ),
                  Text(
                    "أحدث تطبيق للتـواصـل والـــــــــتــحــدث بالــلــغــــــة\nالعربية لذوي صعوبات الـــنــطـــــــق لـلأطـــــفـــــال\nوالبالغيـن وكـبــار الـسـن",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: DeviceUtil.isTablet ? 25 : 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text("_________________________",
                      style: TextStyle(
                          fontSize: DeviceUtil.isTablet ? 35 : 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey)),
                  Container(
                    height: 10,
                  ),
                  Text(
                    "فكــــــرة : د.أمــــل السيف",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: DeviceUtil.isTablet ? 25 : 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 10,
                  ),
                  Text(
                    "تصميم : م.خالد مسلم",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: DeviceUtil.isTablet ? 25 : 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text("_________________________",
                      style: TextStyle(
                          fontSize: DeviceUtil.isTablet ? 35 : 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey)),
                  Container(
                    height: 10,
                  ),
                  Text(
                    "تـــنـفـيــذ وتــشـغيـل",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: DeviceUtil.isTablet ? 25 : 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Image.asset(
                    "assets/uiImages/tawasal.png",
                    height: DeviceUtil.isTablet ? 120 : 100,
                  ),
                  const Text(
                    "جمعية تواصل للتقنيات المساعدة لذوي الإعاقة",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Container(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          String url = "http://mobile.twitter.com/tawasal2019";
                          launchUrl(Uri.parse(url));
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/twitter.png",
                              fit: BoxFit.fill,
                              height: DeviceUtil.isTablet ? 43 : 35,
                            ),
                            Text("tawasal.2019",
                                style: TextStyle(
                                  fontSize: DeviceUtil.isTablet ? 20 : 17,
                                  color: Colors.black,
                                )),
                          ],
                        ),
                      ),
                      Container(
                        width: 25,
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
                              children: [
                                //
                                Image.asset(
                                  "assets/uiImages/google.png",
                                  fit: BoxFit.fill,
                                  height: DeviceUtil.isTablet ? 43 : 35,
                                ),
                                Text("tawasal2019",
                                    style: TextStyle(
                                      fontSize: DeviceUtil.isTablet ? 20 : 17,
                                      color: Colors.black,
                                    )),
                              ],
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const SizedBox(
                height: 130,
                width: 80,
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 40,
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}
