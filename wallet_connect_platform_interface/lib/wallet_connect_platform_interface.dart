library wallet_connect_platform_interface;

import 'dart:async';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'method_channel_wallet_connect.dart';


abstract class WalletConnectPlatform extends PlatformInterface {
  /// Constructs a UrlLauncherPlatform.
  WalletConnectPlatform() : super(token: _token);

  static final Object _token = Object();

  static WalletConnectPlatform _instance = MethodChannelWalletConnect();

  static WalletConnectPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [UrlLauncherPlatform] when they register themselves.
  static set instance(WalletConnectPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
