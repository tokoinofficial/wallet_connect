import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'wallet_connect_platform_interface.dart';

/// An implementation of [WalletConnectPlatform] that uses method channels.
class MethodChannelWalletConnect extends WalletConnectPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('wallet_connect');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
