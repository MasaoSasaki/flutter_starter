import 'package:flutter_starter/services/shared_preferences.dart';
import 'package:flutter_starter/utility/logger.dart';
import 'package:in_app_review/in_app_review.dart';

/// InAppReviewInstance
class InAppReviewInstance {
  /// インスタンス
  factory InAppReviewInstance() => _instance;

  InAppReviewInstance._internal();

  static final InAppReview _inAppReview = InAppReview.instance;

  /// InAppReview
  InAppReview get inAppReview => _inAppReview;

  static final InAppReviewInstance _instance = InAppReviewInstance._internal();

  late final bool _isAvailable;

  /// 初期化
  static Future<void> initialize() async {
    // InAppReviewが利用可能か
    _instance._isAvailable = await _inAppReview.isAvailable();
    if (!_instance._isAvailable) {
      return;
    }

    // 最後にレビュー依頼された日
    final lastReviewDate = SharedPreferencesInstance.getLastReviewRequestDate;

    // 最後にレビュー依頼されたビルド番号
    final lastReviewBuildNumber =
        SharedPreferencesInstance.getLastReviewRequestBuildNumber;

    // First launch
    if (lastReviewDate == null || lastReviewBuildNumber == null) {
      await SharedPreferencesInstance.setLastReviewRequestDate(DateTime.now());
      await SharedPreferencesInstance.setLastReviewRequestBuildNumber(0);
    }
  }

  /// レビュー依頼
  static Future<void> requestReview() async {
    if (!_instance._isAvailable) {
      return;
    }
    Log.finer('requestReview', 'InAppReviewInstance');
    // 90日経過またはビルド番号が変更されて7日経過
    if (_instance._isReviewRequestElapsed(90) ||
        (_instance._isReviewRequestBuildNumberChanged() &&
            _instance._isReviewRequestElapsed(7))) {
      await _inAppReview.requestReview();
      await SharedPreferencesInstance.setLastReviewRequestDate(DateTime.now());
      await SharedPreferencesInstance.setLastReviewRequestBuildNumber();
    }
  }

  /// 最後にレビュー依頼された日から[days]日経過しているか
  bool _isReviewRequestElapsed(int days) {
    // 最後にレビュー依頼された日 (initializeで設定済み)
    final lastReviewDate = SharedPreferencesInstance.getLastReviewRequestDate!;
    Log.finer('lastReviewDate: $lastReviewDate', 'InAppReviewInstance');
    return DateTime.now().difference(lastReviewDate).inDays >= days;
  }

  /// 最後にレビュー依頼されたビルド番号が異なるか
  bool _isReviewRequestBuildNumberChanged() {
    // 最後にレビュー依頼されたビルド番号 (initializeで設定済み)
    final lastReviewBuildNumber =
        SharedPreferencesInstance.getLastReviewRequestBuildNumber;
    // 現在のビルド番号
    final currentBuildNumber = SharedPreferencesInstance.currentBuildNumber;
    return lastReviewBuildNumber != currentBuildNumber;
  }
}
