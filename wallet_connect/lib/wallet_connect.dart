import 'package:wallet_connect_platform_interface/wallet_connect_platform_interface.dart';

WalletConnectPlatform get _platform => WalletConnectPlatform.instance;

/// Returns the name of the current platform.
Future<String> getPlatformName() async {
  final platformName = await _platform.getPlatformName();
  if (platformName == null) throw Exception('Unable to get platform name.');
  return platformName;
}
