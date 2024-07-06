import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreferencesInstance
class SharedPreferencesInstance {
  /// インスタンス
  factory SharedPreferencesInstance() => _instance;

  SharedPreferencesInstance._internal();

  static late final SharedPreferences _prefs;

  /// SharedPreferences
  SharedPreferences get prefs => _prefs;

  static final SharedPreferencesInstance _instance =
      SharedPreferencesInstance._internal();

  /* >>> keys >>> */

  /// BottomNavBar
  static const String bottomNavBarSelectedIndexKey =
      'bottom_nav_bar_selected_index';

  /// 端末のバージョン番号
  static const String _currentVersionKey = 'current_version';

  /// 端末のビルド番号
  static const String _currentBuildNumberKey = 'current_build_number';

  /// 最後にレビュー依頼された日
  static const String lastReviewRequestDateKey = 'last_review_request_date';

  /// 最後にレビュー依頼されたビルド番号
  static const String lastReviewRequestBuildNumberKey =
      'last_review_request_build_number';

  /* <<< keys <<< */

  /// 初期化
  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();

    /// バージョン情報を保存
    final packageInfo = await PackageInfo.fromPlatform();
    await _prefs.setString(_currentVersionKey, packageInfo.version);
    await _prefs.setInt(
      _currentBuildNumberKey,
      int.parse(packageInfo.buildNumber),
    );
  }

  /// バージョン番号
  static String get currentVersion =>
      _prefs.getString(_currentVersionKey) ?? '';

  /// ビルド番号
  static int get currentBuildNumber =>
      _prefs.getInt(_currentBuildNumberKey) ?? 0;

  /// 最後にレビュー依頼された日
  static DateTime? get getLastReviewRequestDate {
    final lastReviewRequestDate = _prefs.getString(lastReviewRequestDateKey);
    return lastReviewRequestDate != null
        ? DateTime.parse(lastReviewRequestDate)
        : null;
  }

  /// 最後にレビュー依頼された日
  static Future<void> setLastReviewRequestDate(
    DateTime lastReviewRequestDate,
  ) async {
    await _prefs.setString(
      lastReviewRequestDateKey,
      lastReviewRequestDate.toString(),
    );
  }

  /// 最後にレビュー依頼されたビルド番号
  static int? get getLastReviewRequestBuildNumber =>
      _prefs.getInt(lastReviewRequestBuildNumberKey);

  /// 最後にレビュー依頼されたビルド番号
  static Future<void> setLastReviewRequestBuildNumber([
    int? currentBuildNumber,
  ]) async {
    currentBuildNumber ??= SharedPreferencesInstance.currentBuildNumber;
    await _prefs.setInt(lastReviewRequestBuildNumberKey, currentBuildNumber);
  }
}
