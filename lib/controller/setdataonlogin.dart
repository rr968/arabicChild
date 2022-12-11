import 'dart:convert';

import '/controller/libtostring.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/content.dart';
import '../model/library.dart';

Future setDataOnLoginChild(data) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setBool("firsttimeChild", false);
  List tem = data?["library list"] ?? [];
  List fav = data?["favlist"] ?? [];

  List<String> lastLibrarylist = [];
  List<String> lastfavlist = [];
  for (var element in tem) {
    lib onelib;
    List e = json.decode(element);
    List<Content> contentlist = [];
    for (List l in e[3] as List) {
      contentlist.add(Content(l[0], l[1], l[2], l[3], "", l[5]));
    }
    onelib = lib(e[0], e[1], e[2], contentlist);
    String newLib = convertLibString(onelib);
    lastLibrarylist.add(newLib);
  }
  for (var elementfav in fav) {
    List e = json.decode(elementfav);
    lastfavlist.add(convertListOfContrntToString(e));
  }

  pref.setStringList("liblistChild", lastLibrarylist);
  pref.setStringList("favlistChild", lastfavlist);
//back.......
  // pref.setStringList("favlist", lastFavoritelist);
}
