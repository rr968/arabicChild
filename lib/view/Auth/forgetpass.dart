// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controller/erroralert.dart';
import '../../controller/istablet.dart';
import '../../controller/var.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({Key? key}) : super(key: key);

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  bool isloading = false;
  final TextEditingController _emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/uiImages/bg.png"),
                  fit: BoxFit.cover)),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: 45, right: DeviceUtil.isTablet ? 25 : 15),
          child: Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_ios,
                size: DeviceUtil.isTablet ? 45 : 30,
              ),
            ),
          ),
        ),
        Center(
            child: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.height * .66
                  : MediaQuery.of(context).size.height * .92,
              width: DeviceUtil.isTablet
                  ? MediaQuery.of(context).orientation == Orientation.portrait
                      ? MediaQuery.of(context).size.width * .6
                      : MediaQuery.of(context).size.width * .44
                  : MediaQuery.of(context).orientation == Orientation.portrait
                      ? MediaQuery.of(context).size.width * .8
                      : MediaQuery.of(context).size.width * .5,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xff989999), width: 2),
                  borderRadius: BorderRadius.circular(40)),
              child: SafeArea(
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(children: [
                        Image.asset("assets/uiImages/forget.png",
                            height: DeviceUtil.isTablet ? 250 : 130),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            "إعادة تعيين كلمة المرور",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: DeviceUtil.isTablet ? 40 : 20,
                                color: maincolor),
                          ),
                        ),
                        Container(
                          height: DeviceUtil.isTablet ? 15 : 5,
                        ),
                        Text(
                          "قم بكتابة الايميل لإرسال\n رمز الاستعادة",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: greyColor,
                              fontSize: DeviceUtil.isTablet ? 27 : 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Container()),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Material(
                            elevation: 12,
                            shadowColor: greyColor.withOpacity(.6),
                            borderRadius: BorderRadius.circular(25),
                            child: TextFormField(
                              controller: _emailcontroller,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: DeviceUtil.isTablet ? 33 : 20,
                                      horizontal: 15),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: "الايــمـيــل",
                                  labelStyle: TextStyle(
                                      color: greyColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  )),
                            ),
                          ),
                        ),
                        Expanded(child: Container()),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              isloading = true;
                            });
                            try {
                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(
                                      email: _emailcontroller.text.trim());
                              Navigator.pop(context);
                              acceptalert(context,
                                  "لقد تم ارسال رابط لاعادة تعيين\n كلمة المرور راجع بريدك الالكتروني\n");
                            } on FirebaseAuthException catch (e) {
                              if (e.code == "user-not-found") {
                                snackbar(context,
                                    "هذا البريد الالكتروني غير مسجل مسبقا");
                              } else {
                                snackbar(context,
                                    "حدث خطأ تأكد من اتصالك بالانترنت");
                              }
                              setState(() {
                                isloading = false;
                              });
                            }
                          },
                          child: isloading
                              ? Container(
                                  height: DeviceUtil.isTablet ? 80 : 45,
                                  width: DeviceUtil.isTablet ? 80 : 45,
                                  decoration: BoxDecoration(
                                      color: maincolor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: const Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.white,
                                  )),
                                )
                              : Image.asset(
                                  "assets/uiImages/send.png",
                                  height: DeviceUtil.isTablet ? 85 : 50,
                                ),
                        ),
                        Expanded(child: Container()),
                      ])))),
        ))
      ])),
    );
  }
}
