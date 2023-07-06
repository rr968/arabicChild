// ignore_for_file: file_names

import 'package:arabic_speaker_child/controller/checkinternet.dart';
import 'package:arabic_speaker_child/pay/deviceinfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

setpayData() async {
  SharedPreferences isSetPayData = await SharedPreferences.getInstance();
  internetConnection().then((v) {
    if (v) {
      initPlatformState().then((value) {
        try {
          FirebaseFirestore.instance
              .collection("payChildApp")
              .doc("mi63rhuIAw1hKJDnLNwx")
              .set({
            "${value[0]}${value[1]}":
                DateTime.now().add(const Duration(days: 60))
          }, SetOptions(merge: true));
          isSetPayData.setBool("isSetPayData", true);
        } catch (_) {}
      });
    }
  });
}
