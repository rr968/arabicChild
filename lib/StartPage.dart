// ignore_for_file: prefer_const_constructors, file_names

import 'dart:async';

import 'package:arabic_speaker_child/controller/getAllDataPediction.dart';
import 'package:arabic_speaker_child/pay/deviceinfo.dart';
import 'package:arabic_speaker_child/pay/needPay.dart';
import 'package:arabic_speaker_child/pay/pay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  bool needPay = false;
  @override
  void initState() {
    //  canGetData();
    /* getSetPayData().then((v) {
      if (!v) setpayData();
    });*/

    getFirstTimeOpenApp().then((v) {
      getIsSignUpOrLogin().then((sign) {
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
    return firstTimeOpenTheApp =
        firstTimeOpenApp.getBool("firstTimeOpenApp") ?? true;
  }

  getSetPayData() async {
    SharedPreferences setPayData = await SharedPreferences.getInstance();
    return setPayData.getBool("isSetPayData") ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Image.asset("assets/uiImages/first.gif")));
  }
}
