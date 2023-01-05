
import 'package:flutter/services.dart';
import 'package:wallet_connect_platform_interface/wallet_connect_platform_interface.dart';

const MethodChannel _channel = MethodChannel('wallet_connect');

class WalletConnectAndroid extends WalletConnectPlatform {
  static void registerWith() {
    WalletConnectPlatform.instance = WalletConnectAndroid();
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version = await _channel.invokeMethod<String>(
      'getPlatformVersion'
    );
    return version;
  }
}
