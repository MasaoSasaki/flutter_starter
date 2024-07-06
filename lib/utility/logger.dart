import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

/// シングルトン カスタムログ
class Log {
  /// インスタンス
  factory Log() => _instance;

  Log._internal();

  static late final Logger _log;

  /// Logger
  Logger get log => _log;

  static final Log _instance = Log._internal();

  /// 初期化
  static void initialize() {
    _log = Logger('Original');

    // デバッグモードの場合は全てのログを出力
    if (kDebugMode) {
      Logger.root.level = Level.ALL;
    }

    // ログの出力設定
    Logger.root.onRecord.listen((record) {
      final loggerName = record.loggerName;
      final levelName = record.level.name;
      final time = DateFormat('yyyy-MM-dd HH:mm:ss').format(record.time);
      final message = record.message;
      debugPrint('[$loggerName] $time: $levelName: $message');
    });
  }

  /// finer
  static void finer(
    Object? message, [
    String? name,
    Object? error,
    StackTrace? stackTrace,
  ]) {
    final fullMessage = (name != null) ? '[$name] $message' : message;
    _log.finer(fullMessage, error, stackTrace);
  }

  /// fine
  static void fine(
    Object? message, [
    String? name,
    Object? error,
    StackTrace? stackTrace,
  ]) {
    final fullMessage = (name != null) ? '[$name] $message' : message;
    _log.fine(fullMessage, error, stackTrace);
  }

  /// config
  static void config(
    Object? message, [
    String? name,
    Object? error,
    StackTrace? stackTrace,
  ]) {
    final fullMessage = (name != null) ? '[$name] $message' : message;
    _log.config(fullMessage, error, stackTrace);
  }

  /// info
  static void info(
    Object? message, [
    String? name,
    Object? error,
    StackTrace? stackTrace,
  ]) {
    final fullMessage = (name != null) ? '[$name] $message' : message;
    _log.info(fullMessage, error, stackTrace);
  }

  /// warning
  static void warning(
    Object? message, [
    String? name,
    Object? error,
    StackTrace? stackTrace,
  ]) {
    final fullMessage = (name != null) ? '[$name] $message' : message;
    _log.warning(fullMessage, error, stackTrace);
  }

  /// severe
  static void severe(
    Object? message, [
    String? name,
    Object? error,
    StackTrace? stackTrace,
  ]) {
    final fullMessage = (name != null) ? '[$name] $message' : message;
    _log.severe(fullMessage, error, stackTrace);
    // TODO(MasaoSasaki): 外部にエラー通知追加
  }

  /// shout
  static void shout(
    Object? message, [
    String? name,
    Object? error,
    StackTrace? stackTrace,
  ]) {
    final fullMessage = (name != null) ? '[$name] $message' : message;
    _log.shout(fullMessage, error, stackTrace);
    // TODO(MasaoSasaki): 外部にエラー通知追加
  }
}
