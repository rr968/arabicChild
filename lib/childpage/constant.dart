import 'child/speakingchildtablet.dart';

convertFvaChildrenToString(List favList) {
  List<String> listChild = [];
  for (var element in favList) {
    String newFav = "";
    for (int y = 0; y < element.length; y++) {
      String name = element[y][0];
      String imurl = element[y][1];
      String isimup = element[y][2];
      String voiceurl = element[y][3];
      String cachevoice = element[y][4];
      String isvoiceup = element[y][5];
      if (y == element.length - 1) {
        newFav +=
            """["$name","$imurl","$isimup","$voiceurl","$cachevoice","$isvoiceup"]""";
      } else {
        newFav +=
            """["$name","$imurl","$isimup","$voiceurl","$cachevoice","$isvoiceup"],""";
      }
    }
    newFav = "[$newFav]";
    listChild.add(newFav);
  }
  return listChild;
}

String getNumber(int num) {
  if (num == 0) return "صفر";
  if (num == 1) return "واحد";
  if (num == 2) return "اثنين";
  if (num == 3) return "ثلاثة";
  if (num == 4) return "اربعة";
  if (num == 5) return "خمسة";
  if (num == 6) return "ستة";
  if (num == 7) return "سبعة";
  if (num == 8) return "ثمانية";
  if (num == 9) return "تسعة";
  return "صفر";
}

List<List<String>> pred = [
  ["انا", getImageWord("انا")],
  ["هل", getImageWord("هل")],
  ["متى", getImageWord("متى")],
  ["اين", getImageWord("اين")],
  ["كيف", getImageWord("كيف")],
  ["كم", getImageWord("كم")],
  ["افتح", getImageWord("افتح")],
  ["ممكن", getImageWord("ممكن")],
  ["طيب", getImageWord("طيب")],
  ["السلام", getImageWord("السلام")],
  ["أريد", getImageWord("أريد")],
  ["لماذا", getImageWord("لماذا")],
  ["قال", getImageWord("قال")],
  ["نعم", getImageWord("نعم")],
  ["مع", getImageWord("مع")],
  ["لكن", getImageWord("لكن")],
];
