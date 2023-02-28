// ignore_for_file: file_names

import 'package:arabic_speaker_child/controller/istablet.dart';

import '/controller/var.dart';
import 'package:flutter/material.dart';

import '../../childpage/child/mainchildPage.dart';

List<String> images = [
  DeviceUtil.isTablet ? 'assets/HowToUse/t1.png' : 'assets/HowToUse/p1.png',
  DeviceUtil.isTablet ? 'assets/HowToUse/t2.png' : 'assets/HowToUse/p2.png',
  DeviceUtil.isTablet ? 'assets/HowToUse/t3.png' : 'assets/HowToUse/p3.png',
  DeviceUtil.isTablet ? 'assets/HowToUse/t4.png' : 'assets/HowToUse/p4.png',
  DeviceUtil.isTablet ? 'assets/HowToUse/t5.png' : 'assets/HowToUse/p5.png',
  DeviceUtil.isTablet ? 'assets/HowToUse/t6.png' : 'assets/HowToUse/p6.png',
  DeviceUtil.isTablet ? 'assets/HowToUse/t7.png' : 'assets/HowToUse/p7.png',
  DeviceUtil.isTablet ? 'assets/HowToUse/t8.png' : 'assets/HowToUse/p8.png',
  DeviceUtil.isTablet ? 'assets/HowToUse/t9.png' : 'assets/HowToUse/p9.png',
  DeviceUtil.isTablet ? 'assets/HowToUse/t10.png' : 'assets/HowToUse/p10.png',
];

class HowToUse extends StatefulWidget {
  const HowToUse({Key? key}) : super(key: key);

  @override
  State<HowToUse> createState() => _HowToUseState();
}

class _HowToUseState extends State<HowToUse> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: pinkColor,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios)),
          title: const Text(" شرح التطبيق",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                // fontWeight: FontWeight.bold
              )),
        ),
        body: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: pinkColor, width: DeviceUtil.isTablet ? 8 : 3)),
          child: Stack(
            children: [
              Column(children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(images[currentStep]),
                            fit: BoxFit.fill)),
                  ),
                ),
              ]),
              InkWell(
                onTap: () async {
                  if (currentStep < 9) {
                    setState(() {
                      currentStep += 1;
                    });
                  } else if (currentStep == 9) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const MainChildPage(index: 0)),
                        (route) => false);
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: DeviceUtil.isTablet ? 60 : 25, left: 20),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: pinkColor),
                      child: const Center(
                          child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 50,
                      )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
