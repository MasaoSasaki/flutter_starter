import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_starter/services/shared_preferences.dart';
import 'package:flutter_starter/utility/logger.dart';

/// Analytics
class AnalyticsInstance {
  /// インスタンス
  factory AnalyticsInstance() => _instance;

  AnalyticsInstance._internal();

  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  /// FirebaseAnalytics
  FirebaseAnalytics get analytics => _analytics;

  static final AnalyticsInstance _instance = AnalyticsInstance._internal();

  /// Analyticsの初期化
  static Future<void> initialize() async {
    // デバッグモードの場合はAnalyticsを有効にする
    // if (kDebugMode) {
    //   await _analytics.setAnalyticsCollectionEnabled(true);
    // }

    // 共通のパラメータを設定
    final versionNumber = SharedPreferencesInstance.currentVersion;
    final buildNumber = SharedPreferencesInstance.currentBuildNumber;
    final params = <String, dynamic>{
      'app_version': versionNumber,
      'app_build_number': buildNumber,
    };
    await _analytics.setDefaultEventParameters(params);

    Log.info('initialize', 'AnalyticsInstance');
    Log.config('defaultEventParameters: $params', 'AnalyticsInstance');
  }

  /// ログの送信
  Future<void> logVoiceSettings() async {
    final params = <String, Object>{
      'testKey': 'testValue',
    };

    await _analytics.logEvent(name: 'testName', parameters: params);

    Log.info('sendVoiceSettings', 'AnalyticsInstance');
    Log.config('voiceSettings: $params', 'AnalyticsInstance');
  }
}
