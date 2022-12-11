import '../model/library.dart';

String convertLibString(lib l) {
  String a = "";

  for (int i = 0; i < l.contenlist.length; i++) {
    if (i == l.contenlist.length - 1) {
      a += """
["${l.contenlist[i].name}",
"${l.contenlist[i].imgurl}",
"${l.contenlist[i].isImageUpload}",
"${l.contenlist[i].opvoice}",
"${l.contenlist[i].cacheVoicePath}",
"${l.contenlist[i].isVoiceUpload}"]
""";
    } else {
      a += """
["${l.contenlist[i].name}",
"${l.contenlist[i].imgurl}",
"${l.contenlist[i].isImageUpload}",
"${l.contenlist[i].opvoice}",
"${l.contenlist[i].cacheVoicePath}",
"${l.contenlist[i].isVoiceUpload}"],
""";
    }
  }
  return """[
    "${l.name}","${l.imgurl}","${l.isImageUpload}",
    [$a]
    
    ]""";
}

String convertListOfContrntToString(List l) {
  String a = "";

  for (int i = 0; i < l.length; i++) {
    if (i == l.length - 1) {
      a += """
["${l[i][0]}",
"${l[i][1]}",
"${l[i][2]}",
"${l[i][3]}",
"${l[i][4]}",
"${l[i][5]}"]
""";
    } else {
      a += """
["${l[i][0]}",
"${l[i][1]}",
"${l[i][2]}",
"${l[i][3]}",
"${l[i][4]}",
"${l[i][5]}"],
""";
    }
  }
  return """[$a]""";
}
