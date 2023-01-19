// ignore_for_file: empty_catches, use_build_context_synchronously, file_names

import 'dart:io';
import 'package:arabic_speaker_child/controller/istablet.dart';

import '../../controller/erroralert.dart';
import '/childpage/parent/mainparent.dart';
import 'package:provider/provider.dart';

import '../../../controller/my_provider.dart';
import '../../icon/iconsgroup.dart';
import '/controller/var.dart';
import '/model/library.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controller/libtostring.dart';

class AddChildLibrary extends StatefulWidget {
  const AddChildLibrary({Key? key}) : super(key: key);

  @override
  State<AddChildLibrary> createState() => _AddChildLibraryState();
}

class _AddChildLibraryState extends State<AddChildLibrary> {
  TextEditingController libraryname = TextEditingController();
  bool errorsen = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "إنشاء مكتبة",
                style: TextStyle(
                    fontSize: DeviceUtil.isTablet ? 38 : 30,
                    color: maincolor,
                    fontWeight: FontWeight.w900),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: DeviceUtil.isTablet ? 40 : 30,
                    horizontal: MediaQuery.of(context).size.width * .09),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255)
                        .withOpacity(0.3),
                    border: Border.all(
                        color: const Color.fromARGB(255, 200, 200, 200)),
                    borderRadius: const BorderRadius.all(Radius.circular(27)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 217, 216, 216)
                            .withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 7,
                        //offset: Offset(0, 3)),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: DeviceUtil.isTablet ? 40 : 30,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 8,
                            left: DeviceUtil.isTablet
                                ? MediaQuery.of(context).size.width * .1
                                : 15,
                            right: DeviceUtil.isTablet
                                ? MediaQuery.of(context).size.width * .1
                                : 15),
                        child: TextFormField(
                          controller: libraryname,
                          maxLines: 1,
                          autofocus: true,
                          decoration: InputDecoration(
                            labelText: "اسم المكتبة",
                            labelStyle: TextStyle(
                                fontSize: DeviceUtil.isTablet ? 30 : 22,
                                fontWeight: FontWeight.bold,
                                color: maincolor),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: maincolor),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(13.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: DeviceUtil.isTablet ? 30 : 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: 21, bottom: DeviceUtil.isTablet ? 36 : 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Provider.of<MyProvider>(context)
                                    .lastimagepath
                                    .toString()
                                    .isNotEmpty
                                ? InkWell(
                                    onTap: () => diag(),
                                    child: Container(
                                        height: DeviceUtil.isTablet ? 220 : 150,
                                        width: DeviceUtil.isTablet ? 220 : 150,
                                        decoration: Provider.of<MyProvider>(context)
                                                .lastimagepath
                                                .toString()
                                                .contains("assets/")
                                            ? BoxDecoration(
                                                border: Border.all(
                                                    color: const Color.fromARGB(
                                                        255, 200, 200, 200),
                                                    width: 1.5),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                    image: AssetImage(Provider.of<MyProvider>(context)
                                                        .lastimagepath
                                                        .toString()),
                                                    fit: BoxFit.fill))
                                            : Provider.of<MyProvider>(context).lastimagepath.toString().contains(
                                                    "https://firebasestorage.googleapis.com")
                                                ? BoxDecoration(
                                                    border: Border.all(color: const Color.fromARGB(255, 200, 200, 200), width: 2),
                                                    borderRadius: BorderRadius.circular(15),
                                                    image: DecorationImage(image: NetworkImage(Provider.of<MyProvider>(context).lastimagepath.toString()), fit: BoxFit.fill))
                                                : BoxDecoration(border: Border.all(color: const Color.fromARGB(255, 200, 200, 200), width: 2), borderRadius: BorderRadius.circular(15), image: DecorationImage(image: FileImage(File(Provider.of<MyProvider>(context).lastimagepath.toString())), fit: BoxFit.fill))),
                                  )
                                : Container(),
                            Provider.of<MyProvider>(context)
                                    .lastimagepath
                                    .toString()
                                    .isEmpty
                                ? InkWell(
                                    onTap: () => diag(),
                                    child: Container(
                                      height: DeviceUtil.isTablet ? 220 : 150,
                                      width: DeviceUtil.isTablet ? 220 : 150,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: greyColor, width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: const Color.fromARGB(
                                                  255,
                                                  255,
                                                  255,
                                                  255) // Color.fromARGB(255, 121, 161, 134)
                                              .withOpacity(.4)),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "إرفاق صورة",
                                              style: TextStyle(
                                                  color: greyColor,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.add_a_photo,
                                                size: 50,
                                                color: greyColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                      errorsen
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                  Container(
                                    width: 8,
                                  ),
                                  Text("يجب وضع اسم للمكتبة",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize:
                                              DeviceUtil.isTablet ? 20 : 17,
                                          fontWeight: FontWeight.w900)),
                                ],
                              ),
                            )
                          : const SizedBox(),
                      Container(
                        height: DeviceUtil.isTablet ? 25 : 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: InkWell(
                              onTap: () async {
                                if (libraryname.text.isNotEmpty) {
                                  SharedPreferences liblistChild =
                                      await SharedPreferences.getInstance();
                                  List<String> lb = liblistChild
                                          .getStringList("liblistChild") ??
                                      [];
                                  if (Provider.of<MyProvider>(context,
                                              listen: false)
                                          .lastimagepath
                                          .toString()
                                          .isEmpty ||
                                      Provider.of<MyProvider>(context,
                                              listen: false)
                                          .lastimagepath
                                          .toString()
                                          .contains("assets/")) {
                                    lb.add(convertLibString(lib(
                                        libraryname.text,
                                        Provider.of<MyProvider>(context,
                                                listen: false)
                                            .lastimagepath
                                            .toString(),
                                        "yes",
                                        [])));
                                  } else {
                                    lb.add(convertLibString(lib(
                                        libraryname.text,
                                        Provider.of<MyProvider>(context,
                                                listen: false)
                                            .lastimagepath
                                            .toString(),
                                        "no",
                                        [])));
                                  }

                                  liblistChild
                                      .setStringList("liblistChild", lb)
                                      .then((value) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MainParentPage(
                                                  index: 1,
                                                )),
                                        (route) => false);
                                    Provider.of<MyProvider>(context,
                                            listen: false)
                                        .setPath("");
                                    acceptalert(
                                        context, "تم إضافة المكتبة بنجاح");
                                  });
                                } else {
                                  setState(() {
                                    errorsen = true;
                                  });
                                }
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: DeviceUtil.isTablet ? 50 : 45,
                                  width: DeviceUtil.isTablet ? 200 : 160,
                                  decoration: BoxDecoration(
                                      color: maincolor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Text(
                                    'حفظ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  )),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future pickimage(ImageSource source) async {
    try {
      final im = await ImagePicker().pickImage(source: source);
      if (im == null) {
        return;
      } else {
        Provider.of<MyProvider>(context, listen: false).setPath(im.path);
      }
    } on PlatformException {
      return;
    }
  }

  diag() {
    return showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                  child: const Text(
                    "الكاميرا",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    pickimage(ImageSource.camera);
                  }),
              CupertinoDialogAction(
                child: const Text(" الاستديو",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.pop(context);
                  pickimage(ImageSource.gallery);
                },
              ),
              CupertinoDialogAction(
                child: const Text("مكتبة الايقونات",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Icongroups()));
                },
              ),
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                  child: const Text('إلغاء',
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold))),
            ],
          );
        });
  }
}
