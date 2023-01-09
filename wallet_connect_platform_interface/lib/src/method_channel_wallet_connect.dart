import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter/services.dart';
import 'package:wallet_connect_platform_interface/wallet_connect_platform_interface.dart';

/// An implementation of [WalletConnectPlatform] that uses method channels.
class MethodChannelWalletConnect extends WalletConnectPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('wallet_connect');

  @override
  Future<String?> getPlatformName() {
    return methodChannel.invokeMethod<String>('getPlatformName');
  }

  @override
  Future<bool?> initializeForBackground(dynamic args) {
    return methodChannel.invokeMethod<bool>('callBackgroundService', args);
  }

  @override
  Future<bool?> callBackgroundService(dynamic args) {
    return methodChannel.invokeMethod<bool>('initializeForBackground', args);
  }

  @override
  Future<bool?> signInitialize() {
    return methodChannel.invokeMethod<bool>('signInitialize');
  }
}
