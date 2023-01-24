// ignore_for_file: file_names
import 'package:arabic_speaker_child/controller/checkinternet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

setDataPredictionWordsAndImage() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  final userChildDoc = FirebaseFirestore.instance
      .collection('dataImagesAndWordsPrediction')
      .doc("R9CumOp2sHCNvujWxNm9");
  internetConnection().then((value) async {
    if (value == true) {
      try {
        await userChildDoc.get().then((value) async {
          String a = value
              .data()!
              .values
              .toString()
              .replaceAll("(", "")
              .replaceAll(")", "");

          pref.setString("PredictionData", a);
        });
      } catch (_) {}
    }
  });
}

setDataHarakatWords() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  final userChildDoc = FirebaseFirestore.instance
      .collection('dataImagesAndWordsPrediction')
      .doc("uZKXN0IyWgMpdS2uCi7d");
  internetConnection().then((value) async {
    if (value == true) {
      try {
        await userChildDoc.get().then((value) async {
          String te = value
              .data()!
              .values
              .toString()
              .replaceAll("(", "")
              .replaceAll(")", "");

          pref.setString("Harakat", te);
        });
      } catch (_) {}
    }
  });
}
