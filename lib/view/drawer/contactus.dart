// ignore_for_file: depend_on_referenced_packages

import '/controller/erroralert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/var.dart';

class Contactus extends StatelessWidget {
  const Contactus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: maincolor,
          title: const Text("تواصل معنا",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                // fontWeight: FontWeight.bold
              )),
        ),
        body: SafeArea(
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: const [
                // const SizedBox(
                //   height: 20,
                // ),
                Padding(
                  padding: EdgeInsets.only(top: 10,bottom: 15),
                  child: Text(
                    " نسعد بأستقبال ملاحظاتك لتحسين التطبيق",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
            ),
            const Content(),
          ]),
        ),
      ),
    );
  }
}

class Content extends StatefulWidget {
  const Content({Key? key}) : super(key: key);

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  double _ratingValue = 5;

  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController topic = TextEditingController();

  TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 12, left: 15, bottom: 8),
              child: Text(
                "تقييم التطبيق",
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 98, 98, 98)),
              ),
            ),
            Center(
              child: Column(
                children: [
                  RatingBar(
                      initialRating: 5,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      ratingWidget: RatingWidget(
                          full: Icon(Icons.star, color: maincolor),
                          half: Icon(
                            Icons.star_half,
                            color: maincolor,
                          ),
                          empty: Icon(
                            Icons.star_outline,
                            color: maincolor,
                          )),
                      onRatingUpdate: (value) {
                        setState(() {
                          _ratingValue = value;
                        });
                      }),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            //)
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextFormField(
            controller: name,
            maxLength: 30,
            maxLines: 1,
            decoration: InputDecoration(
              hintText: "الاسم",
              labelText: "الاسم",
              hintStyle: const TextStyle(fontWeight: FontWeight.bold),
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 22, color: maincolor),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: maincolor),
                borderRadius: const BorderRadius.all(
                  Radius.circular(13.0),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: maincolor),
                borderRadius: const BorderRadius.all(
                  Radius.circular(13.0),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: topic,
            maxLength: 30,
            maxLines: 1,
            decoration: InputDecoration(
              hintText: "عنوان الرسالة",
              labelText: "عنوان الرسالة",
              hintStyle: const TextStyle(fontWeight: FontWeight.bold),
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 22, color: maincolor),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: maincolor),
                borderRadius: const BorderRadius.all(
                  Radius.circular(13.0),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: maincolor),
                borderRadius: const BorderRadius.all(
                  Radius.circular(13.0),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            controller: message,
            minLines: 4,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: "نص الرسالة",
              labelText: "نص الرسالة",
              hintStyle: const TextStyle(fontWeight: FontWeight.bold),
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 22, color: maincolor),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: maincolor),
                borderRadius: const BorderRadius.all(
                  Radius.circular(13.0),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: maincolor),
                borderRadius: const BorderRadius.all(
                  Radius.circular(13.0),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(100, 60),
            primary: maincolor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: () {
            if (name.text.isEmpty ||
                topic.text.isEmpty ||
                message.text.isEmpty) {
              erroralert(context, "يرجىء ملىء جميع الحقول");
            } else {
              String encodquery(Map<String, String> par) {
                return par.entries
                    .map((e) =>
                        "${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}")
                    .join('&');
              }

              final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: "arabic_speaker@tawasal.org.sa",
                  query: encodquery({
                    'subject': topic.text,
                    'body':
                        "تقييم التطبيق:${_ratingValue.toInt()}/5\nالاسم : ${name.text}\nنص الرسالة : ${message.text}",
                  }));
              launchUrl(emailLaunchUri);
            }
          },
          child: const Text(
            "إرسال ",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
          ),
        )
      ]),
    );
  }
}
