import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  SecureStorageHelper._();

  static SecureStorageHelper secureStoreageHelper = SecureStorageHelper._();
  FlutterSecureStorage? flutterSecureStorage;
  void init() {
    flutterSecureStorage = const FlutterSecureStorage();
  }

  Future<void> saveToken(String token) async {
    await flutterSecureStorage!.write(key: 'token', value: token);
  }

  Future<String?> readToken(String token) async {
    String? token = await flutterSecureStorage!.read(key: 'token');
    return token;
  }

  Future deleteToken(String token) async {
    await flutterSecureStorage!.delete(key: 'token');
    log('deleted');
  }
}
