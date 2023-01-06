import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// callbackDispatcher
void callbackDispatcher() {
  const backgroundChannel = MethodChannel('background_channel');
  WidgetsFlutterBinding.ensureInitialized();

  backgroundChannel.setMethodCallHandler((MethodCall call) async {
      final arguments = call.arguments;
      if (arguments is List<dynamic>) {
        final args = arguments;
        final callbackThis = PluginUtilities.getCallbackFromHandle(
            CallbackHandle.fromRawHandle(args.first as int));
        final s = args[1] as String;
        callbackThis!(s);
      }
  });
}