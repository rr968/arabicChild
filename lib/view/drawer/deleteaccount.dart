import '/controller/var.dart';
import '/main.dart';
import '/view/Auth/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controller/removeallshared.dart';

deleteAccount() async {
  User user = FirebaseAuth.instance.currentUser!;
  // delete firestore libraries
  try {
    await FirebaseFirestore.instance.collection('Users').doc(user.uid).delete();
    await user.delete();
  } on Exception catch (_) {
    /// if needs sign in
  }

  isFemale = false; // default
  removeAllSharedPrefrences().then((value) {
    navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Login()),
        (Route<dynamic> route) => false);
  });

  ScaffoldMessenger.of(navigatorKey.currentContext!)
      .showSnackBar(const SnackBar(
          content: Text(
    'تم حذف الحساب بنجاح',
    textDirection: TextDirection.rtl,
  )));
}
