import 'dart:async';

import 'package:flutter/services.dart';

class MyFlutterPlugin {
  static const MethodChannel _channel =
      const MethodChannel('my_flutter_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> get batteryPercent async {
    final String version = await _channel.invokeMethod('getBatteryPercent');
    return version;
  }
}
