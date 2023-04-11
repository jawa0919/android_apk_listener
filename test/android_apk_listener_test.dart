import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';
import 'package:android_apk_listener/android_apk_listener.dart';
import 'package:android_apk_listener/android_apk_listener_platform_interface.dart';
import 'package:android_apk_listener/android_apk_listener_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAndroidApkListenerPlatform
    with MockPlatformInterfaceMixin
    implements AndroidApkListenerPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> launchPackageInfo(String packageName) => Future.value();

  @override
  Stream<String> get onApkAdded =>
      Stream.periodic(const Duration(seconds: 1), (i) => "com.example.a$i");

  @override
  Stream<String> get onApkRemoved =>
      Stream.periodic(const Duration(seconds: 1), (i) => "com.example.b$i");

  @override
  Stream<String> get onApkReplaced =>
      Stream.periodic(const Duration(seconds: 1), (i) => "com.example.c$i");

  @override
  Stream<Map<String, dynamic>> get onChanged => Stream.periodic(
      const Duration(seconds: 1), (i) => {"AA": "com.example.d$i"});

  @override
  Future<Map<String, dynamic>> searchPackageInfo(String packageName) {
    return Future.value({});
  }
}

void main() {
  final AndroidApkListenerPlatform initialPlatform =
      AndroidApkListenerPlatform.instance;

  test('$MethodChannelAndroidApkListener is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAndroidApkListener>());
  });

  test('getPlatformVersion', () async {
    AndroidApkListener androidApkListenerPlugin = AndroidApkListener();
    MockAndroidApkListenerPlatform fakePlatform =
        MockAndroidApkListenerPlatform();
    AndroidApkListenerPlatform.instance = fakePlatform;

    expect(await androidApkListenerPlugin.getPlatformVersion(), '42');
  });
}
