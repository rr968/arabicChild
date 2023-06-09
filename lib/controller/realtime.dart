import 'package:arabic_speaker_child/controller/specialid.dart';
import 'package:firebase_database/firebase_database.dart';

import '/controller/checkinternet.dart';
import 'package:shared_preferences/shared_preferences.dart';

tryUploadToRealTimeForChild(String text) {
  try {
    String d = getSpecialid();
    internetConnection().then((value) async {
      if (value == true) {
        DatabaseReference ref = FirebaseDatabase.instance.ref("child/");
        SharedPreferences pref2 = await SharedPreferences.getInstance();
        List<String> dataCache = pref2.getStringList("realtime") ?? [];

        for (var element in dataCache) {
          String s = getSpecialid();

          await ref.update({s: element});
        }

        await ref.update({d: text});
        pref2.setStringList("realtime", []);
      } else {
        SharedPreferences pref = await SharedPreferences.getInstance();
        List<String> data = pref.getStringList("realtime") ?? [];
        data.add(text);
        pref.setStringList("realtime", data);
      }
    });
  } catch (_) {}
}
