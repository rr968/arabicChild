import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

Future<List> initPlatformState() async {
  List deviceData = [];

  try {
    if (Platform.isAndroid) {
      deviceData = _readAndroidBuildData(await DeviceInfoPlugin().androidInfo);
    } else if (Platform.isIOS) {
      deviceData = _readIosDeviceInfo(await DeviceInfoPlugin().iosInfo);
    }
  } on PlatformException {
    deviceData = [];
  }
  return deviceData;
}

List _readAndroidBuildData(AndroidDeviceInfo build) {
  return [
    build.id,
    build.serialNumber,
  ];
}

List _readIosDeviceInfo(IosDeviceInfo data) {
  return [
    data.name,
    data.identifierForVendor,
  ];
}
