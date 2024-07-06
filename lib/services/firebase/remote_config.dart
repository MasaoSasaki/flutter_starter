import 'package:firebase_remote_config/firebase_remote_config.dart';

/// RemoteConfig
class RemoteConfigInstance {
  /// インスタンス
  factory RemoteConfigInstance() => _instance;

  RemoteConfigInstance._internal();

  static final FirebaseRemoteConfig _remoteConfig =
      FirebaseRemoteConfig.instance;

  /// FirebaseRemoteConfig
  FirebaseRemoteConfig get remoteConfig => _remoteConfig;

  static final RemoteConfigInstance _instance =
      RemoteConfigInstance._internal();

  /// RemoteConfigの初期化
  static Future<void> initialize() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1), // キャッシュ, 0: 毎回取得
      ),
    );

    // Remote Config で使用されているキーとその初期値
    await _remoteConfig.setDefaults(const {});

    // Remote Config の設定を取得
    await _remoteConfig.fetchAndActivate();
  }
}
