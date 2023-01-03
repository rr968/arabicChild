// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:arabic_speaker_child/childpage/child/childFirstInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../childpage/child/mainchildPage.dart';
import '../../controller/checkinternet.dart';
import '../../controller/setdataonlogin.dart';
import '/controller/var.dart';
import '/view/Auth/forgetpass.dart';
import '/view/Auth/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/validation.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool checkBoxValue = true;
  bool loadingicon = false;
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  getInfo() async {
    SharedPreferences myLoginInfo = await SharedPreferences.getInstance();
    List<String> myInfo = myLoginInfo.getStringList("myLoginInfo") ?? [];
    if (myInfo.isNotEmpty) {
      _emailcontroller.text = myInfo[0];
      _passwordcontroller.text = myInfo[1];
    }
  }

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
                width:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.width * .6
                        : MediaQuery.of(context).size.width * .44,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border.all(color: const Color(0xff989999), width: 2),
                    borderRadius: BorderRadius.circular(40)),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(children: [
                      SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset("assets/uiImages/user.png")),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          "تسجيل الدخول",
                          style: TextStyle(
                            fontSize: 40,
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
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 33, horizontal: 15),
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
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 10),
                            child: Material(
                              elevation: 12,
                              shadowColor: greyColor.withOpacity(.6),
                              borderRadius: BorderRadius.circular(25),
                              child: TextFormField(
                                controller: _passwordcontroller,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ' أدخل كلمة المرور';
                                  }
                                  return null;
                                },
                                obscureText: _passwordVisible,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 33, horizontal: 15),
                                  errorStyle: const TextStyle(
                                      fontSize: 18, color: Colors.red),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: pinkColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: "كلمة المرور",
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: greyColor,
                                      fontSize: 20),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          InkWell(
                            onTap: () async {
                              if (_formKey.currentState?.validate() == null ||
                                  _formKey.currentState!.validate()) {
                                try {
                                  setState(() {
                                    loadingicon = true;
                                  });

                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: _emailcontroller.text.trim(),
                                          password:
                                              _passwordcontroller.text.trim())
                                      .then((value) async {
                                    /////////////////
                                    if (checkBoxValue) {
                                      SharedPreferences myLoginInfo =
                                          await SharedPreferences.getInstance();
                                      myLoginInfo.setStringList("myLoginInfo", [
                                        _emailcontroller.text,
                                        _passwordcontroller.text
                                      ]);
                                    }
                                    /////////////////
                                    try {
                                      final userChildDoc = FirebaseFirestore
                                          .instance
                                          .collection('childUsers')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid);
                                      internetConnection().then((value) async {
                                        if (value == true) {
                                          await userChildDoc
                                              .get()
                                              .then((value) async {
                                            if (value.exists) {
                                              if (value.data() == null ||
                                                  value.data()!.isEmpty ||
                                                  value.data() == {}) {
                                                SharedPreferences
                                                    getSignUpOrLogin =
                                                    await SharedPreferences
                                                        .getInstance();
                                                getSignUpOrLogin.setBool(
                                                    "getSignUpOrLogin", true);
                                                Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Selectedlib()),
                                                        (route) => false);
                                              } else {
                                                setDataOnLoginChild(
                                                        value.data())
                                                    .then((value) async {
                                                  SharedPreferences
                                                      getSignUpOrLogin =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  getSignUpOrLogin.setBool(
                                                      "getSignUpOrLogin", true);
                                                });
                                              }
                                            } else {
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Selectedlib()),
                                                      (route) => false);
                                              SharedPreferences
                                                  getSignUpOrLogin =
                                                  await SharedPreferences
                                                      .getInstance();
                                              getSignUpOrLogin.setBool(
                                                  "getSignUpOrLogin", true);
                                            }
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MainChildPage(
                                                          index: 0,
                                                        )));
                                          });
                                        } else {
                                          setState(() {
                                            loadingicon = false;
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  "لا يوجد اتصال بالانترنت",
                                                  textAlign: TextAlign.right),
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        }
                                      });
                                    } catch (e) {
                                      setState(() {
                                        loadingicon = false;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text("حدث خطأ أعد المحاولة",
                                              textAlign: TextAlign.right),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                  });
                                } on FirebaseAuthException catch (e) {
                                  setState(() {
                                    loadingicon = false;
                                  });
                                  String message = e.code;
                                  switch (e.code) {
                                    case 'user-not-found':
                                      message =
                                          "البريد الإلكتروني المدخل غير مسجل سابقًا";
                                      break;
                                    case 'invalid-email':
                                    case 'wrong-password':
                                      message = 'فضلًا تأكد من صحة كلمة المرور';
                                      break;
                                    case 'Error 17011':
                                    case 'Error 17009':
                                      message =
                                          'فضلًا تأكد من صحة البريد الإلكتروني وكلمة المرور';
                                      break;
                                    default:
                                      message =
                                          'فضلا تأكد من صحة بياناتك واتصالك بالإنترنت';
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(message,
                                          textAlign: TextAlign.right),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                }
                              }
                            },
                            child: loadingicon
                                ? Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        color: maincolor,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: const Center(
                                        child: CircularProgressIndicator(
                                      color: Colors.white,
                                    )),
                                  )
                                : Image.asset(
                                    "assets/uiImages/butt.png",
                                    height: 85,
                                  ),
                          ),
                          Container(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                        checkColor: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        fillColor: MaterialStateProperty.all(
                                            yellowColor),
                                        value: checkBoxValue,
                                        onChanged: (v) {
                                          setState(() {
                                            checkBoxValue = v!;
                                          });
                                        }),
                                    Text(
                                      "تذكرني",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: greyColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Forgetpassword()));
                                  },
                                  child: Text(
                                    'نسيت كلمة المرور؟',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: greyColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "ليس لديك حساب؟",
                                style: TextStyle(
                                    color: greyColor,
                                    fontSize: 27,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Signup()));
                                },
                                child: Text(
                                  'تسجيل',
                                  style: TextStyle(
                                    fontSize: 27,
                                    color: pinkColor,
                                    fontWeight: FontWeight.bold,
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
              ),
            )),
          ],
        ),
      ),
    );
  }
}
