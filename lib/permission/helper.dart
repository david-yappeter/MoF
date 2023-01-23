import 'dart:io';

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

// exit application gracefully if permission not granted
Future mustGetStoragePermission() async {
  if (!(await Permission.storage.request().isGranted)) {
    Platform.isAndroid
        ? SystemChannels.platform.invokeMethod('SystemNavigator.pop')
        : exit(0);
  }
}
