import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:android_apk_listener/android_apk_listener.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _androidApkListenerPlugin = AndroidApkListener();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    AndroidApkListener()
        .searchPackageInfo("top.jawa0919.app_info_listener_example")
        .then((value) => debugPrint("searchPackageInfo $value"));
    initListener();
  }

  initListener() {
    AndroidApkListener().onChanged.listen((event) {
      debugPrint("Flutter Listener onChanged $event");
    });
    AndroidApkListener().onApkAdded.listen((event) {
      debugPrint("Flutter Listener onApkAdded $event");
    });
    AndroidApkListener().onApkRemoved.listen((event) {
      debugPrint("Flutter Listener onApkRemoved $event");
    });
    AndroidApkListener().onApkReplaced.listen((event) {
      debugPrint("Flutter Listener onApkReplaced $event");
    });
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await _androidApkListenerPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    _platformVersion = platformVersion;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
