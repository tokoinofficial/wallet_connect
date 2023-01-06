import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:wallet_connect_platform_interface/wallet_connect_platform_interface.dart';

/// The Android implementation of [WalletConnectPlatform].
class WalletConnectAndroid extends WalletConnectPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('wallet_connect_android');

  /// Registers this class as the default instance of [WalletConnectPlatform]
  static void registerWith() {
    WalletConnectPlatform.instance = WalletConnectAndroid();
  }

  @override
  Future<String?> getPlatformName() {
    return methodChannel.invokeMethod<String>('getPlatformName');
  }

  @override
  Future<bool?> callBackgroundService(dynamic) {
    return methodChannel.invokeMethod('initializeForBackground', dynamic);
  }

  @override
  Future<bool?> initializeForBackground(dynamic) {
    return methodChannel.invokeMethod('callBackgroundService', dynamic);
  }
}
