import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'android_apk_listener_method_channel.dart';

abstract class AndroidApkListenerPlatform extends PlatformInterface {
  /// Constructs a AndroidApkListenerPlatform.
  AndroidApkListenerPlatform() : super(token: _token);

  static final Object _token = Object();

  static AndroidApkListenerPlatform _instance = MethodChannelAndroidApkListener();

  /// The default instance of [AndroidApkListenerPlatform] to use.
  ///
  /// Defaults to [MethodChannelAndroidApkListener].
  static AndroidApkListenerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AndroidApkListenerPlatform] when
  /// they register themselves.
  static set instance(AndroidApkListenerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<Map<String, dynamic>> searchPackageInfo(String packageName) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> launchPackageInfo(String packageName) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Stream<Map<String, dynamic>> get onChanged;

  Stream<String> get onApkAdded;
  Stream<String> get onApkRemoved;
  Stream<String> get onApkReplaced;
}
