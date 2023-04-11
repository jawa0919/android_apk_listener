import 'android_apk_listener_platform_interface.dart';

class AndroidApkListener {
  Future<String?> getPlatformVersion() {
    return AndroidApkListenerPlatform.instance.getPlatformVersion();
  }

  Future<Map<String, dynamic>> searchPackageInfo(String packageName) async {
    return AndroidApkListenerPlatform.instance.searchPackageInfo(packageName);
  }

  Future<void> launchPackageInfo(String packageName) async {
    return AndroidApkListenerPlatform.instance.launchPackageInfo(packageName);
  }

  Stream<Map<String, dynamic>> get onChanged =>
      AndroidApkListenerPlatform.instance.onChanged;
  Stream<String> get onApkAdded =>
      AndroidApkListenerPlatform.instance.onApkAdded;
  Stream<String> get onApkRemoved =>
      AndroidApkListenerPlatform.instance.onApkRemoved;
  Stream<String> get onApkReplaced =>
      AndroidApkListenerPlatform.instance.onApkReplaced;
}

class ChangedAction {
  // ignore: constant_identifier_names
  static const ADDED = "ADDED";

  // ignore: constant_identifier_names
  static const REMOVED = "REMOVED";

  // ignore: constant_identifier_names
  static const REPLACED = "REPLACED";
}
