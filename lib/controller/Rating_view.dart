import 'dart:math';

import 'package:arabic_speaker_child/controller/checkinternet.dart';
import 'package:arabic_speaker_child/controller/var.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RatingView extends StatefulWidget {
  const RatingView({Key? key}) : super(key: key);

  @override
  _RatingViewState createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView> {
  final _ratingPageController = PageController();
  var _rating = 0;
  var _rating2 = 0;
  var _rating3 = 0;
  var _rating4 = 0;
  bool IsC = false;
  String isRaiting = "false";
  @override
  void initState() {
    //getRatingInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(children: [
        //thank_you wedigit
        Container(
          height: max(100, MediaQuery.of(context).size.height * 0.2),
          width: max(400, MediaQuery.of(context).size.height * 0.4),
          child: PageView(
            controller: _ratingPageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              _buildThanksNote(),
              _causeOfRating(),
              _ThirdRating(),
              _forthRating(),
              _thankYouPage(),
            ],
          ),
        ),
        //Done button
        //Skip button
        Positioned(
            right: 0,
            child: MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Skip',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )),
      ]),
    );
  }

  _buildThanksNote() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            'التطبيق سهل الاستخدام',
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        SizedBox(
          height: 8,
        ),
        //Star Rating

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              3,
              (index) => IconButton(
                  onPressed: () {
                    setState(() {
                      //_starPosision=20.0;
                      _rating = index + 1;
                      IsC = true;
                    });
                  },
                  color: pinkColor,
                  icon: index < _rating
                      ? Icon(
                          Icons.star,
                          size: 40,
                        )
                      : Icon(
                          Icons.star_border,
                          size: 40,
                        ))),
        ),
        SizedBox(
          height: 20,
        ),

        SizedBox(
          width: 100, //height of button
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: pinkColor, // background color
              ),
              onPressed: () {
                IsC == true
                    ? _ratingPageController.nextPage(
                        duration: Duration(microseconds: 300),
                        curve: Curves.easeIn)
                    : Container();
                IsC = false;
              },
              child: Text(
                "التالي",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              )),
        ),
      ],
    );
  }

  _causeOfRating() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'مفيد للتواصل اليومي',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),

        //Star rating],

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              3,
              (index2) => IconButton(
                  onPressed: () {
                    setState(() {
                      //_starPosision=20.0;
                      _rating2 = index2 + 1;
                      IsC = true;
                    });
                  },
                  color: pinkColor,
                  icon: index2 < _rating2
                      ? Icon(
                          Icons.star,
                          size: 40,
                        )
                      : Icon(
                          Icons.star_border,
                          size: 40,
                        ))),
        ),
        SizedBox(
          height: 20,
        ),

        SizedBox(
          width: 100, //height of button
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: pinkColor, // background color
              ),
              onPressed: () {
                IsC == true
                    ? _ratingPageController.nextPage(
                        duration: Duration(microseconds: 300),
                        curve: Curves.easeIn)
                    : Container();
                IsC = false;
              },
              child: Text(
                "التالي",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              )),
        ),
      ],
    );
  }

  _ThirdRating() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'بناء الجملة سهل وواضح',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),

        //Star rating],

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              3,
              (index3) => IconButton(
                  onPressed: () {
                    setState(() {
                      //_starPosision=20.0;
                      _rating3 = index3 + 1;
                      IsC = true;
                    });
                  },
                  color: pinkColor,
                  icon: index3 < _rating3
                      ? Icon(
                          Icons.star,
                          size: 40,
                        )
                      : Icon(
                          Icons.star_border,
                          size: 40,
                        ))),
        ),
        SizedBox(
          height: 20,
        ),

        SizedBox(
          width: 100, //height of button
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: pinkColor, // background color
              ),
              onPressed: () {
                IsC == true
                    ? _ratingPageController.nextPage(
                        duration: Duration(microseconds: 300),
                        curve: Curves.easeIn)
                    : Container();
                IsC = false;
              },
              child: Text(
                "التالي",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              )),
        ),
      ],
    );
  }

  _forthRating() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            ' أنت راضٍ عن الخدمات المقدمة في التطبيق',
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 10,
        ),

        //Star rating],

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              3,
              (index4) => IconButton(
                  onPressed: () {
                    setState(() {
                      _rating4 = index4 + 1;
                      IsC = true;
                    });
                  },
                  color: pinkColor,
                  icon: index4 < _rating4
                      ? Icon(
                          Icons.star,
                          size: 40,
                        )
                      : Icon(
                          Icons.star_border,
                          size: 40,
                        ))),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: 100,
          color: pinkColor,
          child: MaterialButton(
            onPressed: () {
              if (IsC == true) {
                isRaiting = "true";
                print(isRaiting);
                switch (_rating) {
                  case 1:
                    RatingFirebase(0, 0);
                    break;
                  case 2:
                    RatingFirebase(0, 1);
                    break;
                  case 3:
                    RatingFirebase(1, 0);
                    break;
                }
                switch (_rating2) {
                  case 1:
                    RatingFirebase2(0, 0);
                    break;
                  case 2:
                    RatingFirebase2(0, 1);
                    break;
                  case 3:
                    RatingFirebase2(1, 0);
                    break;
                }
                switch (_rating3) {
                  case 1:
                    RatingFirebase3(0, 0);
                    break;
                  case 2:
                    RatingFirebase3(0, 1);
                    break;
                  case 3:
                    RatingFirebase3(1, 0);
                    break;
                }
                switch (_rating4) {
                  case 1:
                    RatingFirebase4(0, 0);
                    break;
                  case 2:
                    RatingFirebase4(0, 1);
                    break;
                  case 3:
                    RatingFirebase4(1, 0);
                    break;
                }
                _ratingPageController.nextPage(
                    duration: Duration(microseconds: 300),
                    curve: Curves.easeIn);
              }
            },
            child: Text(
              'ارسال',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
            textColor: Colors.white,
          ),
        )
      ],
    );
  }

  _thankYouPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "شكرا لك",
            style: TextStyle(
                color: pinkColor, fontWeight: FontWeight.bold, fontSize: 40),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 100, //height of button

            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: pinkColor, // background color
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("موافق",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15))),
          )
        ],
      ),
    );
  }

  RatingFirebase(int y, int half) {
    try {
      internetConnection().then((value) async {
        if (value == true) {
          DocumentReference<Map<String, dynamic>> ref = await FirebaseFirestore
              .instance
              .collection('rating')
              .doc('sRatingQ1');
          SharedPreferences Spref = await SharedPreferences.getInstance();
          Spref.setString("israting", isRaiting);
          print(isRaiting);

          ref.update({"Nuser": FieldValue.increment(1)});
          if (y == 1) {
            ref.update({"NumofYes": FieldValue.increment(1)});
          } else if (half == 1) {
            ref.update({"NumofNeural": FieldValue.increment(1)});
          } else {
            ref.update({"NumofNo": FieldValue.increment(1)});
          }
        }
      });
    } catch (_) {}
  }

  RatingFirebase2(int y, int half) {
    try {
      internetConnection().then((value) async {
        if (value == true) {
          DocumentReference<Map<String, dynamic>> ref = await FirebaseFirestore
              .instance
              .collection('rating')
              .doc('sRatingQ2');
          //DatabaseReference ref = FirebaseDatabase.instance.ref("rating/");

          ref.update({"Nuser": FieldValue.increment(1)});
          if (y == 1) {
            ref.update({"NumofYes": FieldValue.increment(1)});
          } else if (half == 1) {
            ref.update({"NumofNeural": FieldValue.increment(1)});
          } else {
            ref.update({"NumofNo": FieldValue.increment(1)});
          }
        }
      });
    } catch (_) {}
  }

  RatingFirebase3(int y, int half) {
    try {
      internetConnection().then((value) async {
        if (value == true) {
          DocumentReference<Map<String, dynamic>> ref = await FirebaseFirestore
              .instance
              .collection('rating')
              .doc('sRatingQ3');
          //DatabaseReference ref = FirebaseDatabase.instance.ref("rating/");

          ref.update({"Nuser": FieldValue.increment(1)});
          if (y == 1) {
            ref.update({"NumofYes": FieldValue.increment(1)});
          } else if (half == 1) {
            ref.update({"NumofNeural": FieldValue.increment(1)});
          } else {
            ref.update({"NumofNo": FieldValue.increment(1)});
          }
        }
      });
    } catch (_) {}
  }

  RatingFirebase4(int y, int half) {
    try {
      internetConnection().then((value) async {
        if (value == true) {
          DocumentReference<Map<String, dynamic>> ref = await FirebaseFirestore
              .instance
              .collection('rating')
              .doc(' sRatingQLast');
          //DatabaseReference ref = FirebaseDatabase.instance.ref("rating/");

          ref.update({"Nuser": FieldValue.increment(1)});
          if (y == 1) {
            ref.update({"NumofYes": FieldValue.increment(1)});
          } else if (half == 1) {
            ref.update({"NumofNeural": FieldValue.increment(1)});
          } else {
            ref.update({"NumofNo": FieldValue.increment(1)});
          }
        }
      });
    } catch (_) {}
  }
}
