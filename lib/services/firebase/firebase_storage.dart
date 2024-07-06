import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_starter/services/connectivity_plus.dart';

/// Firebase Storage
class FirebaseStorageInstance with ConnectivityPlus {
  /// Constructor
  factory FirebaseStorageInstance() => _instance;

  FirebaseStorageInstance._internal();

  static late final FirebaseStorage _firebaseStorage;

  /// Firebase Storage
  FirebaseStorage get storage => _firebaseStorage;

  static final FirebaseStorageInstance _instance =
      FirebaseStorageInstance._internal();

  /// 初期化
  static Future<void> initialize() async {
    _firebaseStorage = FirebaseStorage.instance;
  }
}
