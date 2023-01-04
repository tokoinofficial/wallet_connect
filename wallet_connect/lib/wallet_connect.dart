library wallet_connect;

import 'package:wallet_connect_platform_interface/wallet_connect_platform_interface.dart';

class WalletConnect {
  Future<String?> getPlatformVersion() async {
    final version = await WalletConnectPlatform.instance.getPlatformVersion();
    return version;
  }
}
