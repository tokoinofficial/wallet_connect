import 'package:flutter/material.dart';
import 'package:wallet_connect/wallet_connect.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _platformName;

  @override
  void initState() {
    super.initState();
    WalletConnect.initializeForBackground();
  }

  static Future<void> callback(String s) async {
    debugPrint('I am from main.dart');
    debugPrint(s);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WalletConnect Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_platformName == null)
              const SizedBox.shrink()
            else
              Text(
                'Platform Name: $_platformName',
                style: Theme.of(context).textTheme.headline5,
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                try {
                  final result = await getPlatformName();
                  setState(() => _platformName = result);
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).primaryColor,
                      content: Text('$error'),
                    ),
                  );
                }
              },
              child: const Text('Get Platform Name'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await WalletConnect.callBackgroundService(callback);
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).primaryColor,
                      content: Text('$error'),
                    ),
                  );
                }
              },
              child: const Text('Call Background Service'),
            ),
          ],
        ),
      ),
    );
  }
}
