import 'dart:io';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

/// UrlLauncher
class UrlLauncher {
  static const _lineUrl = 'https://lin.ee/******';
  static const _appStoreUrl = 'https://apps.apple.com/us/app/****/id**********';
  static const _googlePlayUrl = 'https://play.google.com/store/apps/details?id=com.example';

  /// URL for LINE
  String get lineUrl => _lineUrl;

  /// URL for AppStore
  String get appStoreUrl => _appStoreUrl;

  /// URL for GooglePlay
  String get googlePlayUrl => _googlePlayUrl;

  /// Launch URL
  static Future<void> launchUrl() async {
    final url = Platform.isAndroid ? _googlePlayUrl : _appStoreUrl;
    await url_launcher.launchUrl(Uri.parse(url));
  }
}
