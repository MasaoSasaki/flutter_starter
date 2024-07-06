import 'dart:io' show Platform; // Added import for Platform

import 'package:flutter/material.dart';

/// Custom Dialog
class CustomDialog {
  CustomDialog._(); // Private constructor to prevent instantiation

  /// CustomAlertDialogの表示
  static Future<bool> showAlertDialog({
    required BuildContext context,
    required String title,
    required String content,
    required String positiveButtonText,
    required String negativeButtonText,
  }) async {
    // プラットフォームに応じたボタンの順序
    final actions = Platform.isAndroid
        ? [
            TextButton(
              onPressed: () => Navigator.of(context).pop<bool>(false),
              child: Text(
                negativeButtonText,
                style: const TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop<bool>(true),
              child: Text(positiveButtonText),
            ),
          ]
        : [
            TextButton(
              onPressed: () => Navigator.of(context).pop<bool>(true),
              child: Text(positiveButtonText),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop<bool>(false),
              child: Text(
                negativeButtonText,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ];

    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog.adaptive(
            title: Text(title),
            content: Text(content),
            actions: actions,
          ),
        ) ??
        false; // どのボタンも押されなかった場合はfalseを返す
  }
}
