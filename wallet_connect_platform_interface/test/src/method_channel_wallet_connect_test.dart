import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_connect_platform_interface/src/method_channel_wallet_connect.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const kPlatformName = 'platformName';

  group('$MethodChannelWalletConnect', () {
    late MethodChannelWalletConnect methodChannelWalletConnect;
    final log = <MethodCall>[];

    setUp(() async {
      methodChannelWalletConnect = MethodChannelWalletConnect()
        ..methodChannel.setMockMethodCallHandler((MethodCall methodCall) async {
          log.add(methodCall);
          switch (methodCall.method) {
            case 'getPlatformName':
              return kPlatformName;
            default:
              return null;
          }
        });
    });

    tearDown(log.clear);

    test('getPlatformName', () async {
      final platformName = await methodChannelWalletConnect.getPlatformName();
      expect(
        log,
        <Matcher>[isMethodCall('getPlatformName', arguments: null)],
      );
      expect(platformName, equals(kPlatformName));
    });
  });
}
