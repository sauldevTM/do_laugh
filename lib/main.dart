import 'dart:io';

import 'package:do_laugh/home/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:giphy_flutter_sdk/giphy_flutter_sdk.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void initPlatformState() {
    try {
      String? apiKey;
      if (Platform.isAndroid) {
        apiKey = 'KpCokA9FZnzUiujbMRqBmBAOkfoZ1NCO'; // Android SDK key
      } else if (Platform.isIOS) {
        apiKey = 'zoq5Xg0C0h1N0YDS5eHxzSJJTZ8J26bR'; // iOS SDK key
      } else {
        throw Exception('Unsupported platform');
      }
      if (apiKey.isEmpty) {
        throw Exception('API key for the platform is null or not configured');
      }
      GiphyFlutterSDK.configure(apiKey: apiKey);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(body: Center(child: Home())),
      ),
    );
  }
}
