import 'package:connectivity_plus/connectivity_plus.dart';

/// mixin
mixin ConnectivityPlus {

  /// ネットワークに接続されているかどうか
  Future<bool> isOnline() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
  }
}
