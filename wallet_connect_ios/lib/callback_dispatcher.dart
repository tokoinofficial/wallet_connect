import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void callbackDispatcher() {
  const backgroundChannel = MethodChannel('background_channel');
  WidgetsFlutterBinding.ensureInitialized();

  backgroundChannel.setMethodCallHandler((MethodCall call) async {
    final args = call.arguments as List<dynamic>?;
    if (args != null) {
      final callbackThis = PluginUtilities.getCallbackFromHandle(
        CallbackHandle.fromRawHandle(args[0] as int),
      );

      final s = args[1] as String;
      // ignore: avoid_dynamic_calls
      callbackThis?.call(s);
    }
  });
}
