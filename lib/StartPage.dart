// ignore_for_file: prefer_const_constructors, file_names

import 'dart:async';

import '/childpage/child/mainchildPage.dart';
import '/controller/sharedpref.dart';
import '/firstTimeOpenTheApp/page1.dart';
import '/view/Auth/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
