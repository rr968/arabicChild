// ignore_for_file: file_names

import '/controller/var.dart';
import 'package:flutter/material.dart';

import '../../childpage/child/mainchildPage.dart';

List<String> images = [
  'assets/HowToUse/1.png',
  'assets/HowToUse/2.png',
  'assets/HowToUse/3.png',
  'assets/HowToUse/4.png',
  'assets/HowToUse/5.png',
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
          backgroundColor: maincolor,
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
        body: Stack(
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
                if (currentStep < 4) {
                  setState(() {
                    currentStep += 1;
                  });
                } else if (currentStep == 4) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainChildPage(index: 0)),
                      (route) => false);
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 60, left: 20),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: maincolor),
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
    );
  }
}
