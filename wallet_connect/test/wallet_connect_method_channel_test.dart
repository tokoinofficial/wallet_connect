import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // MethodChannelWalletConnect platform = MethodChannelWalletConnect();
  const MethodChannel channel = MethodChannel('wallet_connect');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    // expect(await platform.getPlatformVersion(), '42');
  });
}
