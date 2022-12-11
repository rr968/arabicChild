import '/controller/var.dart';
import 'package:flutter/material.dart';

exportNote(context) {
  showDialog(
      context: context,
      builder: (context) {
        return FittedBox(
          child: AlertDialog(
            title: Column(
              children: [
                SizedBox(
                    height: 90,
                    child: Image.asset(
                      "assets/warning.png",
                      fit: BoxFit.fill,
                    )),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  " تنبيه",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                )
              ],
            ),
            content: Column(
              children: [
                const Center(
                    child: Text(
                  "سوف تقوم بمشاركة المكتبات المختارة مع بقية المستخدمين",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: maincolor,
                      borderRadius: BorderRadius.circular(30),
                      // border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: const Center(
                        child: Text(
                      "موافق",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white),
                    )),
                  ),
                )
              ],
            ),
          ),
        );
      });
}

cantDelete(context) {
  showDialog(
      context: context,
      builder: (context) {
        return FittedBox(
          child: AlertDialog(
            title: Column(
              children: [
                SizedBox(
                    height: 90,
                    child: Image.asset(
                      "assets/warning.png",
                      fit: BoxFit.fill,
                    )),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  " تنبيه",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                )
              ],
            ),
            content: Column(
              children: [
                const Center(
                    child: Text(
                  "يجب ترك عنصر في الصفحة على الاقل",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: maincolor,
                      borderRadius: BorderRadius.circular(30),
                      // border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: const Center(
                        child: Text(
                      "موافق",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white),
                    )),
                  ),
                )
              ],
            ),
          ),
        );
      });
}
