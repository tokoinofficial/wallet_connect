import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:wallet_connect_ios/callback_dispatcher.dart';
import 'package:wallet_connect_platform_interface/wallet_connect_platform_interface.dart';

/// The iOS implementation of [WalletConnectPlatform].
class WalletConnectIOS extends WalletConnectPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('wallet_connect_ios');

  /// Registers this class as the default instance of [WalletConnectPlatform]
  static void registerWith() {
    WalletConnectPlatform.instance = WalletConnectIOS();
  }

  @override
  Future<String?> getPlatformName() {
    return methodChannel.invokeMethod<String>('getPlatformName');
  }

  @override
  Future<bool?> initializeForBackground() async {
    final callback = PluginUtilities.getCallbackHandle(callbackDispatcher);
    return methodChannel
        .invokeMethod('initializeForBackground', [callback?.toRawHandle()]);
  }

  @override
  Future<bool?> callBackgroundService(void Function(String s) callback) async {
    final args = <dynamic>[
      PluginUtilities.getCallbackHandle(callback)?.toRawHandle()
    ];
    return methodChannel.invokeMethod('callBackgroundService', args);
  }
}
