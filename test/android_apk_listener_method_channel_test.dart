import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:android_apk_listener/android_apk_listener_method_channel.dart';

void main() {
  MethodChannelAndroidApkListener platform = MethodChannelAndroidApkListener();
  const MethodChannel channel = MethodChannel('android_apk_listener');

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
    expect(await platform.getPlatformVersion(), '42');
  });
}
