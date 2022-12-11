// ignore_for_file: camel_case_types

import '/model/content.dart';

class lib {
  String name;
  String imgurl;
  String isImageUpload;
  List<Content> contenlist;

  lib(this.name, this.imgurl, this.isImageUpload, this.contenlist);
}

List<lib> libraryList = [];
List<Content> favoritList = [];
List<lib> libraryListChild = [];
List<Content> favoritListChild = [];
