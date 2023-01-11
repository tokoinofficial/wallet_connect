import 'dart:ui';

import 'package:wallet_connect_platform_interface/wallet_connect_platform_interface.dart';

import 'callback_dispatcher.dart';

WalletConnectPlatform get _platform => WalletConnectPlatform.instance;

/// Returns the name of the current platform.
Future<String> getPlatformName() async {
  final platformName = await _platform.getPlatformName();
  if (platformName == null) throw Exception('Unable to get platform name.');
  return platformName;
}

class WalletConnect {
  WalletConnect._();

  /// Initialize for background call
  static Future<void> initializeForBackground() async {
    final callback = PluginUtilities.getCallbackHandle(callbackDispatcher);
    await _platform.initializeForBackground([callback?.toRawHandle()]);
  }

  /// Call background service
  static Future<void> callBackgroundService(
      void Function(String s) callback) async {
    final args = <dynamic>[
      PluginUtilities.getCallbackHandle(callback)?.toRawHandle()
    ];
    await _platform.callBackgroundService(args);
  }

  /// Initialize for sign
  static Future<void> signInitialize() async {
    await _platform.signInitialize();
  }
}
