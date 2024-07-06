import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter/states/bottom_nav_bar_selected_index_notifier.dart';
import 'package:flutter_starter/ui/components/ad/banner_ad.dart';
import 'package:flutter_starter/ui/components/scaffold_widgets/bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:flutter_starter/ui/components/scaffold_widgets/bottom_navigation_bar/tab1.dart';
import 'package:flutter_starter/ui/components/scaffold_widgets/bottom_navigation_bar/tab2.dart';
import 'package:flutter_starter/ui/components/scaffold_widgets/bottom_navigation_bar/tab3.dart';
import 'package:flutter_starter/ui/components/scaffold_widgets/custom_floating_action_button.dart';

/// Home
class Home extends ConsumerWidget {
  /// Constructor
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavBarSelectedIndexNotifierProvider);
    final isSettings = selectedIndex == 1;

    return SafeArea(
      child: Container(
        color: Colors.grey[900],
        child: Scaffold(
          body: IndexedStack(
            index: selectedIndex,
            children: const [
              Tab1(),
              Tab2(),
              Tab3(),
            ],
          ),
          bottomNavigationBar: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BannerAdWidget(),
              CustomBottomNavigationBar(),
            ],
          ),
          floatingActionButton:
              isSettings ? const CustomFloatingActionButton() : null,
        ),
      ),
    );
  }
}
