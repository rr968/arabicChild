import 'package:shared_preferences/shared_preferences.dart';

Future removeAllSharedPrefrences() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
}
