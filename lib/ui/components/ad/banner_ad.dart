import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter/services/ad_mob_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// バナー広告
class BannerAdWidget extends ConsumerWidget {
  /// コンストラクター
  const BannerAdWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO(owner): あらかじめRemoteConfigでAdType(AdMob / Facebook Ad)を保存, refで取得
    final bannerAd = AdMobService().getBannerAd()..load();
    return Container(
      alignment: Alignment.center,
      height: bannerAd.size.height.toDouble(),
      color: Colors.black,
      child: AdWidget(ad: bannerAd),
    );
  }
}
