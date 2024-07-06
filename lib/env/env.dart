import 'package:envied/envied.dart';

part 'env.g.dart';

/// See: https://pub.dev/packages/envied
///
/// 注: 自動生成ファイルの`final class`記述はXcodeでエラーになるため、
/// `final class`を`class`に変更している
///
/// 環境変数を管理するクラス
@Envied(path: '.env', useConstantCase: true)
abstract class Env {
  Env._(); // Private constructor

  /// AdMob Banner Ad App ID for Android
  @EnviedField(obfuscate: true)
  static final String bannerAdAppIdAndroid = _Env.bannerAdAppIdAndroid;

  /// AdMob Banner Ad App ID for iOS
  @EnviedField(obfuscate: true)
  static final String bannerAdAppIdIos = _Env.bannerAdAppIdIos;

  /// AdMob Interstitial Ad App ID for Android
  @EnviedField(obfuscate: true)
  static final String interstitialAdAppIdAndroid = _Env.interstitialAdAppIdAndroid;

  /// AdMob Interstitial Ad App ID for iOS
  @EnviedField(obfuscate: true)
  static final String interstitialAdAppIdIos = _Env.interstitialAdAppIdIos;
}
