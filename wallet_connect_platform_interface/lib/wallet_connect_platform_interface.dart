import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:wallet_connect_platform_interface/src/method_channel_wallet_connect.dart';

/// The interface that implementations of wallet_connect must implement.
///
/// Platform implementations should extend this class
/// rather than implement it as `WalletConnect`.
/// Extending this class (using `extends`) ensures that the subclass will get
/// the default implementation, while platform implementations that `implements`
///  this interface will be broken by newly added [WalletConnectPlatform] methods.
abstract class WalletConnectPlatform extends PlatformInterface {
  /// Constructs a WalletConnectPlatform.
  WalletConnectPlatform() : super(token: _token);

  static final Object _token = Object();

  static WalletConnectPlatform _instance = MethodChannelWalletConnect();

  /// The default instance of [WalletConnectPlatform] to use.
  ///
  /// Defaults to [MethodChannelWalletConnect].
  static WalletConnectPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [WalletConnectPlatform] when they register themselves.
  static set instance(WalletConnectPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Return the current platform name.
  Future<String?> getPlatformName();

  /// Initialize call for background
  Future<bool?> initializeForBackground(dynamic args);

  /// Call background service
  Future<bool?> callBackgroundService(dynamic args);
}
