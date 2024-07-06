import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 両OS対応BottomNavigationBar
class BothOSBottomNavigationBar extends StatelessWidget {
  /// コンストラクター
  const BothOSBottomNavigationBar({
    required this.selectedItemColor,
    required this.unselectedItemColor,
    required this.backgroundColor,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  /// selectedItemColor / activeColor
  final Color? selectedItemColor;

  /// unselectedItemColor / inactiveColor
  final Color? unselectedItemColor;

  /// backgroundColor
  final Color? backgroundColor;

  /// items
  final List<BottomNavigationBarItem> items;

  /// currentIndex
  final int currentIndex;

  /// onTap
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final isAndroid = Theme.of(context).platform == TargetPlatform.android;
    return isAndroid
        ? BottomNavigationBar(
            selectedItemColor: selectedItemColor,
            unselectedItemColor: unselectedItemColor,
            backgroundColor: backgroundColor,
            items: items,
            currentIndex: currentIndex,
            onTap: onTap,
          )
        : CupertinoTabBar(
            activeColor: selectedItemColor,
            inactiveColor: unselectedItemColor ?? Colors.grey[600]!,
            backgroundColor: backgroundColor,
            items: items,
            currentIndex: currentIndex,
            onTap: onTap,
          );
  }
}
