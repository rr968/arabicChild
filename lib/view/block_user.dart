import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'drawer/contactus.dart';

Widget blockedUser(BuildContext context) {
  return Scaffold(
    body: Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Image.asset(
              'assets/blocked.gif',
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text("لقد تم حظرك من استخدام التطبيق لانك تتبع نشاط مسيء",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: const Color(0xff424D4D),
                      fontWeight: FontWeight.normal)),
            ),
            Container(
              padding: const EdgeInsetsDirectional.only(
                  top: 30.0, start: 30.0, end: 30.0),
              child: Text("إذا كنت تعتقد انه حدث خطأ يرجى التواصل معنا",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: const Color.fromARGB(255, 129, 129, 129),
                        fontWeight: FontWeight.normal,
                      )),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 25),
                child: CupertinoButton(
                  child: Container(
                      height: 45,
                      width: 150,
                      alignment: FractionalOffset.center,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 239, 95, 85),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Text("تواصل معنا",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Contactus()));
                  },
                ))
          ]),
        ),
      ),
    ),
  );
}
