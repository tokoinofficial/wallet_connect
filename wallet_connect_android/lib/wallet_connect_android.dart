
import 'package:wallet_connect_platform_interface/wallet_connect_platform_interface.dart';

class WalletConnectAndroid extends WalletConnectPlatform {
  static void registerWith() {
    WalletConnectPlatform.instance = WalletConnectAndroid();
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version = await WalletConnectPlatform.instance.getPlatformVersion();
    return version;
  }
}
