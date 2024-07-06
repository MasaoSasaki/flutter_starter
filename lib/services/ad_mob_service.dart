import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_starter/env/env.dart';
import 'package:flutter_starter/utility/logger.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// AdMobService
class AdMobService {
  /// ロード失敗時のリトライ制限
  int countLoadAttempt = 0;

  /// バナー広告に使用する広告ID
  String get bannerAdUnitId {
    if (kDebugMode) {
      // テスト用広告ID
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716';
    } else {
      // 本番用広告ID
      return Platform.isAndroid
          ? Env.bannerAdAppIdAndroid
          : Env.bannerAdAppIdIos;
    }
  }

  /// インタースティシャル広告に使用する広告ID
  String get interstitialAdUnitId {
    if (kDebugMode) {
      // テスト用広告ID
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/1033173712'
          : 'ca-app-pub-3940256099942544/4411468910';
    } else {
      // 本番用広告ID
      return Platform.isAndroid
          ? Env.interstitialAdAppIdAndroid
          : Env.interstitialAdAppIdIos;
    }
  }

  /// バナー広告の読み込み
  BannerAd getBannerAd() {
    return BannerAd(
      size: AdSize.banner,
      adUnitId: bannerAdUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          Log.info('バナー広告がロードされました。', 'AdMob');
          countLoadAttempt = 0;
        },
        onAdFailedToLoad: (ad, error) async {
          await ad.dispose();
          Log.severe('バナー広告の読み込みが次の理由で失敗しました。: $error', 'AdMob');
          if (countLoadAttempt < 5) {
            countLoadAttempt++;
            getBannerAd();
          }
        },
        onAdOpened: (ad) => Log.info('バナー広告が開かれました。', 'AdMob'),
        onAdClosed: (ad) => Log.info('バナー広告が閉じられました。', 'AdMob'),
      ),
    );
  }

  /// インタースティシャル広告の読み込み
  ///
  /// 広告読み込み失敗時のループに使用
  Future<void> showLoadInterstitialAd() async {
    await InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) async {
          Log.info('インタースティシャル広告がロードされました', 'AdMob');
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {},
            onAdImpression: (ad) {},
            onAdFailedToShowFullScreenContent: (ad, err) async {
              Log.severe('$ad loaded.', 'AdMob');
              await ad.dispose();
            },
            onAdDismissedFullScreenContent: (ad) async {
              await ad.dispose();
            },
            onAdClicked: (ad) {},
          );
          Log.info('$ad loaded.', 'AdMob');
          await ad.show();
        },
        onAdFailedToLoad: (error) async {
          countLoadAttempt++;
          Log.severe(
            'インタースティシャル広告の読み込みが次の理由で失敗しました: $error',
            'AdMob',
          );

          if (countLoadAttempt < 5) {
            // 5回までは広告を再読み込み
            await showLoadInterstitialAd();
          }
        },
      ),
    );
  }
}
