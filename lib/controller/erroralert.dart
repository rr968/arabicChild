import '/controller/var.dart';
import 'package:flutter/material.dart';

snackbar(context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text, textAlign: TextAlign.right),
      duration: const Duration(seconds: 2),
    ),
  );
}

erroralert(context, text) {
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
                      "assets/cancel.png",
                      fit: BoxFit.fill,
                    )),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  " خطأ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )
              ],
            ),
            content: Column(
              children: [
                Center(child: Text(text)),
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
                      // border: Border.all(color: Colors.black, width: 2)
                    ),
                    child: const Center(
                        child: Text(
                      "موافق",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ),
                )
              ],
            ),
          ),
        );
      });
}

acceptalert(context, String text) {
  showDialog(
      context: context,
      builder: (context) {
        Future.delayed(
          const Duration(seconds: 3),
          () {
            Navigator.of(context).pop(true);
          },
        );
        return AlertDialog(
          title: Column(
            children: [
              SizedBox(
                  height: 90,
                  child: Image.asset(
                    "assets/accept.png",
                    fit: BoxFit.fill,
                  )),
              const SizedBox(
                height: 20,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    color: maincolor,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        );
      });
}

noteAlert(context) {
  showDialog(
      context: context,
      builder: (context) {
        Future.delayed(
          const Duration(seconds: 5),
          () {
            Navigator.of(context).pop(true);
          },
        );
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
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )
              ],
            ),
            content: Column(
              children: [
                const Center(
                    child: Text(
                        "لقد لاحظنا استخدامك للتطبيق لفترة دون الاتصال بالانترنت \nنود تنبيهك لضرورة الاتصال بالانترنت ليتم حفظ بياناتك في حال حذف التطبيق")),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.black, width: 2)),
                    child: const Center(
                        child: Text(
                      "إغلاق",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ),
                )
              ],
            ),
          ),
        );
      });
}
