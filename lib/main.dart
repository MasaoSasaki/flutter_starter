import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter/services/connectivity_plus.dart';
import 'package:flutter_starter/services/firebase/analytics.dart';
import 'package:flutter_starter/services/firebase/firebase_storage.dart';
import 'package:flutter_starter/services/firebase/messaging.dart';
import 'package:flutter_starter/services/firebase/remote_config.dart';
import 'package:flutter_starter/services/in_app_review.dart';
import 'package:flutter_starter/services/shared_preferences.dart';
import 'package:flutter_starter/ui/pages/home.dart';
import 'package:flutter_starter/utility/logger.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  // パッケージの初期化
  await _initialize();

  runApp(const ProviderScope(child: MyApp()));
}

/// MyApp
class MyApp extends ConsumerWidget with ConnectivityPlus {
  /// Constructor
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      // アプリストアのスクリーンショットを更新する時にバナーを非表示にする
      // debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(useMaterial3: true),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: AnalyticsInstance().analytics),
      ],
      home: Builder(
        builder: (context) {
          // 全てのWidgetのビルドが完了後に呼び出される
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            if (!await isOnline()) {
              await EasyLoading.showError(
                'ネットワークエラー\n'
                    '\n'
                    'インターネットの接続が確認できませんでした。',
              );
              return;
            }
            // アプリ内設定の読み込み
            await _loadSettings(context, ref);
          });

          return const Home();
        },
      ),
      builder: EasyLoading.init(),
    );
  }
}

/// アプリ起動時の初期化処理
Future<void> _initialize() async {
  Log.initialize();

  Log.config('App initialize', 'Flutter');
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // スプラッシュスクリーン表示
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // SharedPreferences 初期化
  Log.config('SharedPreferences initialize', 'SharedPreferences');
  await SharedPreferencesInstance.initialize();

  // AdMob 初期化
  Log.config('AdMob initialize', 'AdMob');
  await MobileAds.instance.initialize();

  // InAppReview 初期化
  Log.config('InAppReview initialize', 'InAppReview');
  await InAppReviewInstance.initialize();

  // Firebase 初期化
  Log.config('Firebase initialize', 'Firebase');
  await Firebase.initializeApp(
    // firebase command で生成された google-services.json のパスを指定
    // options: DefaultFirebaseOptions.currentPlatform,
  );

  // Firebase Storage 初期化
  Log.config('Firebase Storage initialize', 'FirebaseStorage');
  await FirebaseStorageInstance.initialize();

  // FirebaseRemoteConfig 初期化
  Log.config('FirebaseRemoteConfig initialize', 'Firebase');
  await RemoteConfigInstance.initialize();

  // FirebaseAnalytics 初期化
  Log.config('FirebaseAnalytics initialize', 'FirebaseAnalytics');
  await AnalyticsInstance.initialize();

  // スプラッシュスクリーン非表示
  FlutterNativeSplash.remove();
}

/// 設定の読み込み
Future<void> _loadSettings(BuildContext context, WidgetRef ref) async {
  // ローディング表示
  await EasyLoading.show(status: '最新の音声データを確認しています。');

  // Firebase Messaging 初期化
  Log.config('Firebase Messaging initialize', 'FirebaseMessaging');
  final messaging = FirebaseMessaging.instance;
  await messaging.requestPermission();
  final fcmToken = await messaging.getToken();
  Log.info('FCM TOKEN: $fcmToken');
  await FirebaseMessaging.instance.subscribeToTopic('production');
  if (kDebugMode) {
    await FirebaseMessaging.instance.subscribeToTopic('development');
  }
  FirebaseMessaging.onBackgroundMessage(
        (message) => handleNotification(message, ref),
  );
  // バックグラウンドからフォアグラウンドに戻る際のリスナー設定
  FirebaseMessaging.onMessageOpenedApp.listen(
        (message) => handleNotification(message, ref),
  );
  // キル状態からフォアグラウンドに戻る際のリスナー設定
  final message = await FirebaseMessaging.instance.getInitialMessage();
  if (message != null) {
    await handleNotification(message, ref);
  }

  await EasyLoading.dismiss();
}
