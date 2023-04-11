import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'android_apk_listener_platform_interface.dart';

/// An implementation of [AndroidApkListenerPlatform] that uses method channels.
class MethodChannelAndroidApkListener extends AndroidApkListenerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('android_apk_listener');

  @visibleForTesting
  final eventChannel = const EventChannel('android_apk_listener');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<Map<String, dynamic>> searchPackageInfo(String packageName) async {
    Map<String, dynamic> params = {"packageName": packageName};
    final res = await methodChannel.invokeMethod('searchPackageInfo', params);
    return Map<String, dynamic>.from(res);
  }

  @override
  Future<void> launchPackageInfo(String packageName) async {
    Map<String, dynamic> params = {"packageName": packageName};
    await methodChannel.invokeMethod<String>('launchPackageInfo', params);
  }

  Stream<Map<String, dynamic>>? _onChanged;

  @override
  Stream<Map<String, dynamic>> get onChanged {
    _onChanged ??= eventChannel.receiveBroadcastStream().map((res) => Map<String, dynamic>.from(res));
    return _onChanged!;
  }

  @override
  Stream<String> get onApkAdded {
    _onChanged ??= eventChannel.receiveBroadcastStream().map((res) => Map<String, dynamic>.from(res));
    return _onChanged!
        .where((event) => event["action"] == ChangedAction.ADDED)
        .map<String>((event) => event["packageName"]);
  }

  @override
  Stream<String> get onApkRemoved {
    _onChanged ??= eventChannel.receiveBroadcastStream().map((res) => Map<String, dynamic>.from(res));
    return _onChanged!
        .where((event) => event["action"] == ChangedAction.REMOVED)
        .map<String>((event) => event["packageName"]);
  }

  @override
  Stream<String> get onApkReplaced {
    _onChanged ??= eventChannel.receiveBroadcastStream().map((res) => Map<String, dynamic>.from(res));
    return _onChanged!
        .where((event) => event["action"] == ChangedAction.REPLACED)
        .map<String>((event) => event["packageName"]);
  }
}

class ChangedAction {
  // ignore: constant_identifier_names
  static const ADDED = "ADDED";

  // ignore: constant_identifier_names
  static const REMOVED = "REMOVED";

  // ignore: constant_identifier_names
  static const REPLACED = "REPLACED";
}
