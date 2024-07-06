import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_starter/services/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bottom_nav_bar_selected_index_notifier.g.dart';

/// BottomNavigationBarの選択中のIndex
@riverpod
class BottomNavBarSelectedIndexNotifier
    extends _$BottomNavBarSelectedIndexNotifier {
  final _prefs = SharedPreferencesInstance().prefs;
  final _key = SharedPreferencesInstance.bottomNavBarSelectedIndexKey;

  @override
  int build() {
    return _prefs.getInt(_key) ?? 0;
  }

  /// BottomNavigationBarの選択中のIndex 更新
  Future<void> update(int selectedIndex) async {
    if (selectedIndex == state) {
      return;
    }

    // HapticFeedback
    unawaited(HapticFeedback.selectionClick());

    state = selectedIndex;
    await _prefs.setInt(_key, state);
  }
}
