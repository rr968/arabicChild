import 'package:flutter/material.dart';

class MyProvider with ChangeNotifier {
  ///////////////////
  List<int> isSelectedInAlert = [];
  void addOrRemove(int index) {
    if (isSelectedInAlert.contains(index)) {
      isSelectedInAlert.remove(index);
    } else {
      isSelectedInAlert.add(index);
    }
    notifyListeners();
  }

  void clearSelectedInAlert() {
    isSelectedInAlert = [];

    notifyListeners();
  }

  ///////////////////
  ////////////////////
  int iscontentOfLibrary = -1;
  void setIscontentOfLibrary(int index) {
    iscontentOfLibrary = index;
    notifyListeners();
  } ///////////////////

  ////////////////////
  bool isloading = false;
  void isLoading(bool val) {
    isloading = val;
    notifyListeners();
  }

  ///////////////////
  ////////////////////
  String lastimagepath = "";
  void setPath(String path) {
    lastimagepath = path;
    notifyListeners();
  }

/////////////////
  //////////////
  int pass1 = -1;
  int pass2 = -1;
  int pass3 = -1;
  int pass4 = -1;
  bool errorpass = false;
  void seterror(bool b) {
    errorpass = b;
    notifyListeners();
  }

  void incPass1(int num) {
    pass1 = num;
    notifyListeners();
  }

  void incPass2(int num) {
    pass2 = num;
    notifyListeners();
  }

  void incPass3(int num) {
    pass3 = num;
    notifyListeners();
  }

  void incPass4(int num) {
    pass4 = num;
    notifyListeners();
  }

  /////////////

}
