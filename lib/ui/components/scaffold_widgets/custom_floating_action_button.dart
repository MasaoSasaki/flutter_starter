import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter/services/connectivity_plus.dart';

/// カスタムFAB
class CustomFloatingActionButton extends ConsumerWidget with ConnectivityPlus {
  /// Constructor
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {},
    );
  }
}
