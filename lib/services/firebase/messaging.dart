import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter/utility/logger.dart';

/// リモートプッシュ通知が開かれた際の処理
Future<void> handleNotification(RemoteMessage message, WidgetRef ref) async {
  Log.finer('Handling a background message: ${message.data['type']}');
  await FlutterAppBadger.removeBadge();
  switch (message.data['type']) {
    default:
      Log.finer('Unknown notification type');
  }
}
