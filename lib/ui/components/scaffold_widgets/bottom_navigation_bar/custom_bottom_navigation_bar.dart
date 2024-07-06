import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter/states/bottom_nav_bar_selected_index_notifier.dart';
import 'package:flutter_starter/ui/components/both_os_widgets/bottom_navigation_bar.dart';

/// BottomNavigationBar
class CustomBottomNavigationBar extends ConsumerWidget {
  /// Constructor
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavBarSelectedIndexNotifierProvider);

    return BothOSBottomNavigationBar(
      selectedItemColor: Colors.grey[200],
      unselectedItemColor: Colors.grey[600],
      backgroundColor: Colors.grey[800],
      items: _bottomNavigationBarItems(ref),
      currentIndex: selectedIndex,
      onTap: (index) => ref
          .read(bottomNavBarSelectedIndexNotifierProvider.notifier)
          .update(index),
    );
  }

  /// BottomNavigationBarItems
  List<BottomNavigationBarItem> _bottomNavigationBarItems(WidgetRef ref) {
    const iconSize = 24.0;

    return [
      const BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.info, size: iconSize),
        ),
        label: 'Tab1',
      ),
      const BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.info, size: iconSize),
        ),
        label: 'Tab2',
      ),
      const BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.all(8),
          child: Badge(child: Icon(Icons.info, size: iconSize)),
        ),
        label: 'Tab3',
      ),
    ];
  }
}
