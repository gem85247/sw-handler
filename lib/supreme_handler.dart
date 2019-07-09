import 'dart:async';

import 'package:flutter/services.dart';

class SupremeHandler {
  static const MethodChannel _channel =
      const MethodChannel('supreme_handler');

  static Future<bool> get clearCookies async {
    return await _channel.invokeMethod('clearCookies');
  }
}
