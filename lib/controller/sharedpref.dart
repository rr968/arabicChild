import 'package:shared_preferences/shared_preferences.dart';

Future getIsSignUpOrLogin() async {
  SharedPreferences getSignUpOrLogin = await SharedPreferences.getInstance();
  return getSignUpOrLogin.getBool("getSignUpOrLogin") ?? false;
}
