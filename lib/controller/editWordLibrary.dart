// ignore_for_file: file_names

import 'package:arabic_speaker_child/controller/libtostring.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/library.dart';

editWordboxContent(context, int indexLib, int indexContent,
    String nameNewContent, String imgNewContent) async {
  librarywordChild[indexLib].contenlist[indexContent].name = nameNewContent;
  librarywordChild[indexLib].contenlist[indexContent].imgurl = imgNewContent;
  saveWordboxContent(context, librarywordChild);
}

saveWordboxContent(context, List<lib> l) async {
  List<String> data = [];
  for (var element in l) {
    String l = convertLibString(element);
    data.add(l);
  }
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setStringList("wordListChild", data);
}
