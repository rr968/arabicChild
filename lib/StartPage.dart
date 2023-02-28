// ignore_for_file: prefer_const_constructors, file_names

import 'dart:async';

import 'package:arabic_speaker_child/controller/getAllDataPediction.dart';
import 'package:arabic_speaker_child/controller/harakatPrediction.dart';
import 'package:arabic_speaker_child/data.dart';
import 'package:flutter/services.dart';

import '/childpage/child/mainchildPage.dart';
import '/controller/sharedpref.dart';
import '/firstTimeOpenTheApp/page1.dart';
import '/view/Auth/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/checkinternet.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  bool signOrLogIn = false;
  bool firstTimeOpenTheApp = true;
  @override
  void initState() {
    //  canGetData();

    getIsSignUpOrLogin().then((sign) {
      getFirstTimeOpenApp().then((v) {
        signOrLogIn = sign;
      });
    });
    Timer(
        Duration(seconds: 4),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => firstTimeOpenTheApp == true
                    ? Page1()
                    : signOrLogIn == false
                        ? const Login()
                        : MainChildPage(
                            index: 0,
                          ))));
    super.initState();
  }

  canGetData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int numb = pref.getInt("numb") ?? -1;
    internetConnection().then((value) async {
      if (value == true) {
        if (numb == -1 || numb == 1) {
          setDataPredictionWordsAndImage();
          setDataHarakatWords();
          setModonaSentence();
          pref.setInt("numb", 0);
        } else {
          pref.setInt("numb", numb + 1);
        }
      }
    });
  }

  getFirstTimeOpenApp() async {
    SharedPreferences firstTimeOpenApp = await SharedPreferences.getInstance();
    firstTimeOpenTheApp = firstTimeOpenApp.getBool("firstTimeOpenApp") ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Image.asset("assets/uiImages/first.gif")));
  }
}
