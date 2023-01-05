import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wallet_connect/wallet_connect.dart';
import 'package:wallet_connect_platform_interface/wallet_connect_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWalletConnectPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements WalletConnectPlatform {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('WalletConnect', () {
    late WalletConnectPlatform walletConnectPlatform;

    setUp(() {
      walletConnectPlatform = MockWalletConnectPlatform();
      WalletConnectPlatform.instance = walletConnectPlatform;
    });

    group('getPlatformName', () {
      test('returns correct name when platform implementation exists',
          () async {
        const platformName = '__test_platform__';
        when(
          () => walletConnectPlatform.getPlatformName(),
        ).thenAnswer((_) async => platformName);

        final actualPlatformName = await getPlatformName();
        expect(actualPlatformName, equals(platformName));
      });

      test('throws exception when platform implementation is missing',
          () async {
        when(
          () => walletConnectPlatform.getPlatformName(),
        ).thenAnswer((_) async => null);

        expect(getPlatformName, throwsException);
      });
    });
  });
}
