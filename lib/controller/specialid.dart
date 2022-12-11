import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

getSpecialName() {
  String specialId = FirebaseAuth.instance.currentUser!.uid;
  String additionRandom = getRandomString(15);
  return specialId + additionRandom;
}

getSpecialid() {
  String additionRandom = getRandomString(20);
  return additionRandom;
}
