import 'package:arabic_speaker_child/view/Auth/verifyEmail.dart';

import '../../controller/getAllDataPediction.dart';
import '../../controller/istablet.dart';
import '../../questionspages.dart/sizeOfITem.dart';
import '../../controller/var.dart';
import '/controller/validation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _LoginState();
}

class _LoginState extends State<Signup> {
  bool loadingicon = false;
  final _formKey = GlobalKey<FormState>();
  final passFieldKey = GlobalKey();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _repasswordcontroller = TextEditingController();

  bool showPassConditions = false;
  bool hasCapitalLetter = false;
  bool hasSmallLetter = false;
  bool hasNumber = false;
  bool greaterThan8 = false;
  IconData iconHasNum = Icons.circle;
  Color iconColorHasNum = pinkColor;
  IconData iconHasCapi = Icons.circle;
  Color iconColorHasCapi = pinkColor;
  IconData iconHasSmall = Icons.circle;
  Color iconColorHasSmall = pinkColor;
  IconData iconGre = Icons.circle;
  Color iconColorGre = pinkColor;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/uiImages/bg.png"),
                      fit: BoxFit.cover)),
            ),
            Center(
                child: SingleChildScrollView(
              child: Container(
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height * .7
                        : MediaQuery.of(context).size.height * .95,
                width: DeviceUtil.isTablet
                    ? MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.width * .6
                        : MediaQuery.of(context).size.width * .44
                    : MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.width * .8
                        : MediaQuery.of(context).size.width * .5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border.all(color: const Color(0xff989999), width: 2),
                    borderRadius: BorderRadius.circular(40)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(children: [
                    SizedBox(
                        height: DeviceUtil.isTablet ? 100 : 50,
                        width: DeviceUtil.isTablet ? 100 : 50,
                        child: Image.asset("assets/uiImages/user.png")),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        "مستخدم جديد",
                        style: TextStyle(
                          fontSize: DeviceUtil.isTablet ? 40 : 25,
                          color: maincolor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Material(
                            elevation: 12,
                            shadowColor: greyColor.withOpacity(.6),
                            borderRadius: BorderRadius.circular(25),
                            child: TextFormField(
                              controller: _emailcontroller,
                              validator: (value) {
                                return validate(value, 'البريد الإلكتروني');
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: DeviceUtil.isTablet ? 33 : 20,
                                      horizontal: 15),
                                  errorStyle: const TextStyle(
                                      fontSize: 18, color: Colors.red),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Material(
                            elevation: 12,
                            shadowColor: greyColor.withOpacity(.6),
                            borderRadius: BorderRadius.circular(25),
                            child: TextFormField(
                              key: passFieldKey,
                              onTap: () {
                                Scrollable.ensureVisible(
                                    passFieldKey.currentContext!);
                                setState(() {
                                  showPassConditions = true;
                                });
                              },
                              onEditingComplete: () {
                                setState(() {
                                  showPassConditions = false;
                                });
                              },
                              onChanged: (value) {
                                updateColors(value);
                              },
                              validator: (value) {
                                return validate(value, 'كلمة المرور');
                              },
                              controller: _passwordcontroller,
                              obscureText: true,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: DeviceUtil.isTablet ? 33 : 20,
                                    horizontal: 15),
                                filled: true,
                                errorStyle: const TextStyle(
                                    fontSize: 18, color: Colors.red),
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                // hintText: 'كلمة المرور',
                                labelText: 'كلمة المرور',
                                labelStyle: TextStyle(
                                    color: greyColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Material(
                            elevation: 12,
                            shadowColor: greyColor.withOpacity(.6),
                            borderRadius: BorderRadius.circular(25),
                            child: TextFormField(
                              controller: _repasswordcontroller,
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'أدخل كلمة المرور';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: DeviceUtil.isTablet ? 33 : 20,
                                    horizontal: 15),
                                errorStyle: const TextStyle(
                                    fontSize: 18, color: Colors.red),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                labelText: 'تأكيد كلمة المرور',
                                labelStyle: TextStyle(
                                    color: greyColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        showPassConditions
                            ? Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      ' كلمة المرور يجب أن تحتوي على الأقل على:',
                                      style: TextStyle(
                                          color: pinkColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              DeviceUtil.isTablet ? 16 : 12),
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              iconHasNum,
                                              size:
                                                  DeviceUtil.isTablet ? 16 : 10,
                                              color: iconColorHasNum,
                                            ),
                                            Text(
                                              ' رقم',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: DeviceUtil.isTablet
                                                      ? 16
                                                      : 14,
                                                  color: hasNumber
                                                      ? Colors.green
                                                      : pinkColor),
                                              textDirection: TextDirection.rtl,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              iconGre,
                                              size:
                                                  DeviceUtil.isTablet ? 16 : 10,
                                              color: iconColorGre,
                                            ),
                                            Text(
                                              ' 8 خانات',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: DeviceUtil.isTablet
                                                      ? 16
                                                      : 14,
                                                  color: greaterThan8
                                                      ? Colors.green
                                                      : pinkColor),
                                              textDirection: TextDirection.rtl,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              iconHasSmall,
                                              size:
                                                  DeviceUtil.isTablet ? 16 : 10,
                                              color: iconColorHasSmall,
                                            ),
                                            Text(
                                              ' حرف صغير',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: DeviceUtil.isTablet
                                                      ? 16
                                                      : 14,
                                                  color: hasSmallLetter
                                                      ? Colors.green
                                                      : pinkColor),
                                              textDirection: TextDirection.rtl,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              iconHasCapi,
                                              size:
                                                  DeviceUtil.isTablet ? 16 : 10,
                                              color: iconColorHasCapi,
                                            ),
                                            Text(
                                              ' حرف كبير',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: DeviceUtil.isTablet
                                                      ? 16
                                                      : 14,
                                                  color: hasCapitalLetter
                                                      ? Colors.green
                                                      : pinkColor),
                                              textDirection: TextDirection.rtl,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        Expanded(
                          child: Container(),
                        ),
                        loadingicon
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
                            : InkWell(
                                onTap: () async {
                                  if (_passwordcontroller.text ==
                                      _repasswordcontroller.text) {
                                    if (_formKey.currentState?.validate() ==
                                            null ||
                                        _formKey.currentState!.validate()) {
                                      try {
                                        setState(() {
                                          loadingicon = true;
                                        });
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                                email: _emailcontroller.text
                                                    .trim(),
                                                password: _passwordcontroller
                                                    .text
                                                    .trim())
                                            .then((value) async {
                                          setState(() {
                                            loadingicon = false;
                                          });
                                          SharedPreferences getSignUpOrLogin =
                                              await SharedPreferences
                                                  .getInstance();

                                          getSignUpOrLogin.setBool(
                                              "getSignUpOrLogin", true);
                                          final FirebaseAuth _auth =
                                              FirebaseAuth.instance;
                                          await _auth.currentUser!
                                              .sendEmailVerification();
                                          showDialog(
                                            context: context,
                                            barrierDismissible:
                                                false, // Prevent dismissing by tapping outside
                                            builder: (BuildContext context) {
                                              return CustomPopup();
                                            },
                                          );
                                        });
                                      } on FirebaseAuthException catch (e) {
                                        setState(() {
                                          loadingicon = false;
                                        });
                                        String message = e.code;
                                        switch (e.code) {
                                          case 'ERROR_EMAIL_ALREADY_IN_USE':
                                          case 'email-already-in-use':
                                            message =
                                                'البريد الإلكتروني المدخل مستخدم في تطبيق المتحدث العربي للكبار أو تطبيق المتحدث من قبل من فضلك اضغط على زر تسجيل الدخول';
                                            break;
                                          default:
                                            message =
                                                'فضلا تأكد من صحة بياناتك واتصالك بالإنترنت';
                                        }
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              message,
                                              textAlign: TextAlign.right,
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                            duration:
                                                const Duration(seconds: 6),
                                          ),
                                        );
                                      }
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                          Text("كلمة السر المدخلة غير متطابقة"),
                                      duration: Duration(seconds: 2),
                                    ));
                                  }
                                },
                                child: Image.asset(
                                  "assets/uiImages/signUp.png",
                                  height: DeviceUtil.isTablet ? 85 : 50,
                                ),
                              ),
                        Container(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "هل لديك حساب؟",
                              style: TextStyle(
                                  color: greyColor,
                                  fontSize: DeviceUtil.isTablet ? 27 : 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()));
                              },
                              child: Text(
                                'تسجيل الدخول',
                                style: TextStyle(
                                  fontSize: DeviceUtil.isTablet ? 27 : 16,
                                  color: pinkColor,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                  ]),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  void updateColors(String value) {
    if (value.contains(RegExp(r'[0-9]'))) {
      setState(() {
        hasNumber = true;
        iconHasNum = Icons.check_circle;
        iconColorHasNum = Colors.green;
      });
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      setState(() {
        hasNumber = false;
        iconHasNum = Icons.circle_rounded;
        iconColorHasNum = pinkColor;
      });
    }
    if (value.contains(RegExp(r'[A-Z]'))) {
      setState(() {
        hasCapitalLetter = true;
        iconHasCapi = Icons.check_circle;
        iconColorHasCapi = Colors.green;
      });
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      setState(() {
        hasCapitalLetter = false;
        iconHasCapi = Icons.circle_rounded;
        iconColorHasCapi = pinkColor;
      });
    }
    if (value.contains(RegExp(r'[a-z]'))) {
      setState(() {
        hasSmallLetter = true;
        iconHasSmall = Icons.check_circle;
        iconColorHasSmall = Colors.green;
      });
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      setState(() {
        hasSmallLetter = false;
        iconHasSmall = Icons.circle_rounded;
        iconColorHasSmall = pinkColor;
      });
    }
    if (value.length >= 8) {
      setState(() {
        greaterThan8 = true;
        iconGre = Icons.check_circle;
        iconColorGre = Colors.green;
      });
    }
    if (value.length < 8) {
      setState(() {
        greaterThan8 = false;
        iconGre = Icons.circle_rounded;
        iconColorGre = pinkColor;
      });
    }
  }
}
