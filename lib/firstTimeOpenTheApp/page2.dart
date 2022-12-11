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
        decoration: BoxDecoration(
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
                  width:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.width * .6
                          : MediaQuery.of(context).size.width * .44,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff989999), width: 2),
                      borderRadius: BorderRadius.circular(40)),
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(children: [
                        Container(
                          height: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            "سهولة الكتابة\nباستخدام التوقع\nالذكي للكلمات",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 36,
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
                              MaterialPageRoute(builder: (context) => Page3()),
                              (route) => false),
                          child: Image.asset(
                            "assets/uiImages/next.png",
                            height: 85,
                          ),
                        ),
                        Container(
                          height: 18,
                        ),
                        InkWell(
                          onTap: () async {
                            SharedPreferences firstTimeOpenApp =
                                await SharedPreferences.getInstance();
                            firstTimeOpenApp.setBool("firstTimeOpenApp", false);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                                (route) => false);
                          },
                          child: Text(
                            "تخطي هذا",
                            style: TextStyle(
                                color: greyColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        Container(
                          height: 18,
                        ),
                      ])))))
    ]));
  }
}
