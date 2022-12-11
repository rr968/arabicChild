import 'dart:io';

Future<bool> internetConnection() async {
  bool thereIsInternet;

  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      thereIsInternet = true;
    } else {
      thereIsInternet = false;
    }
  } on SocketException catch (_) {
    thereIsInternet = false;
  }
  return thereIsInternet;
}
