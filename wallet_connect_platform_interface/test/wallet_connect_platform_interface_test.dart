import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_connect_platform_interface/wallet_connect_platform_interface.dart';

class WalletConnectMock extends WalletConnectPlatform {
  static const mockPlatformName = 'Mock';

  @override
  Future<String?> getPlatformName() async => mockPlatformName;

  @override
  Future<bool?> callBackgroundService(dynamic) {
    // TODO: implement callBackgroundService
    throw UnimplementedError();
  }

  @override
  Future<bool?> initializeForBackground(dynamic) {
    // TODO: implement initializeForBackground
    throw UnimplementedError();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('WalletConnectPlatformInterface', () {
    late WalletConnectPlatform walletConnectPlatform;

    setUp(() {
      walletConnectPlatform = WalletConnectMock();
      WalletConnectPlatform.instance = walletConnectPlatform;
    });

    group('getPlatformName', () {
      test('returns correct name', () async {
        expect(
          await WalletConnectPlatform.instance.getPlatformName(),
          equals(WalletConnectMock.mockPlatformName),
        );
      });
    });
  });
}
