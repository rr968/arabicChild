// ignore_for_file: file_names

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/content.dart';
import '../model/library.dart';

Future<bool> allUploadedDataChildDone() async {
  SharedPreferences liblist = await SharedPreferences.getInstance();
  List<String> librarys = liblist.getStringList("liblistChild") ?? [];
  for (String element in librarys) {
    lib onelib;
    List e = json.decode(element);
    List<Content> contentlist = [];
    for (List l in e[3]) {
      contentlist.add(Content(l[0], l[1], l[2], l[3], l[4], l[5]));
    }
    onelib = lib(e[0], e[1], e[2], contentlist);
    if (onelib.isImageUpload == "no") {
      return false;
    } else {
      for (Content c in onelib.contenlist) {
        if (c.isImageUpload == "no" || c.isVoiceUpload == "no") return false;
      }
    }
  }
  return true;
}
