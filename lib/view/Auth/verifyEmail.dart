import 'dart:async';

import 'package:arabic_speaker_child/view/Auth/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../questionspages.dart/sizeOfITem.dart';

class CustomPopup extends StatefulWidget {
  @override
  State<CustomPopup> createState() => _CustomPopupState();
}

class _CustomPopupState extends State<CustomPopup> {
  late Timer timer;
  bool isSend = false;
  @override
  void initState() {
    isveryfied();
    super.initState();
  }

  isveryfied() {
    timer = Timer.periodic(Duration(seconds: 2), (timer) async {
      await FirebaseAuth.instance.currentUser!.reload();

      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const NumofItems()));
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Disable the back button functionality
        return false;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Center(child: Text('التحقق من الايميل')),
          content: Text(
            'لقد قمنا بارسال رابط للتحقق من بريدك الالكتروني على ${FirebaseAuth.instance.currentUser!.email}',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () async {
                    final FirebaseAuth _auth = FirebaseAuth.instance;
                    await _auth.currentUser!.sendEmailVerification();
                    setState(() {
                      isSend = true;
                    });
                    Future.delayed(Duration(milliseconds: 3850)).then((value) {
                      setState(() {
                        isSend = false;
                      });
                    });
                  },
                  child: isSend
                      ? Image.asset(
                          "assets/verifyemail.gif",
                          height: 50,
                        )
                      : Text(
                          'إعادة ارسال',
                          style: TextStyle(color: Colors.black),
                        ),
                ),
                TextButton(
                  onPressed: () async {
                    // Handle button press
                    final FirebaseAuth _auth = FirebaseAuth.instance;
                    User? user = _auth.currentUser;
                    if (user != null) {
                      try {
                        await user.delete();
                      } catch (_) {}
                    }
                    _auth.signOut();

                    SharedPreferences getSignUpOrLogin =
                        await SharedPreferences.getInstance();

                    getSignUpOrLogin.setBool("getSignUpOrLogin", false);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Signup()),
                        (route) => false);
                  },
                  child: Text(
                    'التسجيل بايميل اخر',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
