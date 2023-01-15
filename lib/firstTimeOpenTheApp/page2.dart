// ignore_for_file: use_build_context_synchronously

import '../controller/istablet.dart';
import '/firstTimeOpenTheApp/page3.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/var.dart';
import '../view/Auth/login.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/uiImages/bg.png"),
                fit: BoxFit.cover)),
      ),
      Center(
          child: SingleChildScrollView(
              child: Container(
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.height * .66
                          : MediaQuery.of(context).size.height * .92,
                  width: DeviceUtil.isTablet
                      ? MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.width * .6
                          : MediaQuery.of(context).size.width * .44
                      : MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.width * .8
                          : MediaQuery.of(context).size.width * .5,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(color: const Color(0xff989999), width: 2),
                      borderRadius: BorderRadius.circular(40)),
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(children: [
                        Container(
                          height: DeviceUtil.isTablet ? 18 : 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            "سهولة الكتابة\nباستخدام التوقع\nالذكي للكلمات",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: DeviceUtil.isTablet ? 40 : 29,
                              color: maincolor,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                              child: Image.asset("assets/uiImages/easy.png")),
                        ),
                        InkWell(
                          onTap: () => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Page3()),
                              (route) => false),
                          child: Image.asset(
                            "assets/uiImages/next.png",
                            height: DeviceUtil.isTablet ? 85 : 50,
                          ),
                        ),
                        Container(
                          height: DeviceUtil.isTablet ? 18 : 12,
                        ),
                        InkWell(
                          onTap: () async {
                            SharedPreferences firstTimeOpenApp =
                                await SharedPreferences.getInstance();
                            firstTimeOpenApp.setBool("firstTimeOpenApp", false);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()),
                                (route) => false);
                          },
                          child: Text(
                            "تخطي هذا",
                            style: TextStyle(
                                color: greyColor,
                                fontWeight: FontWeight.bold,
                                fontSize: DeviceUtil.isTablet ? 20 : 18),
                          ),
                        ),
                        Container(
                          height: 18,
                        ),
                      ])))))
    ]));
  }
}
