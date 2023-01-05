import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_connect_ios/wallet_connect_ios.dart';
import 'package:wallet_connect_platform_interface/wallet_connect_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('WalletConnectIOS', () {
    const kPlatformName = 'iOS';
    late WalletConnectIOS walletConnect;
    late List<MethodCall> log;

    setUp(() async {
      walletConnect = WalletConnectIOS();

      log = <MethodCall>[];
      TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger
          .setMockMethodCallHandler(walletConnect.methodChannel, (methodCall) async {
        log.add(methodCall);
        switch (methodCall.method) {
          case 'getPlatformName':
            return kPlatformName;
          default:
            return null;
        }
      });
    });

    test('can be registered', () {
      WalletConnectIOS.registerWith();
      expect(WalletConnectPlatform.instance, isA<WalletConnectIOS>());
    });

    test('getPlatformName returns correct name', () async {
      final name = await walletConnect.getPlatformName();
      expect(
        log,
        <Matcher>[isMethodCall('getPlatformName', arguments: null)],
      );
      expect(name, equals(kPlatformName));
    });
  });
}
