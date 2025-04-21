import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<void> saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  static Future<String?> readToken() async {
    return _storage.read(key: 'token');
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: "token");
  }

  static Future<void> saveEmail(String email) async {
    await _storage.write(key: 'currentUserEmail', value: email);
  }

  static Future<String?> readEmail() async {
    return await _storage.read(key: 'currentUserEmail');
  }

  static Future<String?> readTokenForUser(String email) async {
    return await _storage.read(key: 'token_$email');
  }

  static Future<void> saveUserCredentials(
      {required String email, required String password}) async {
    await _storage.write(key: email, value: password);
  }

  static Future<String?> getUserPassword(String email) async {
    return await _storage.read(key: email);
  }

  static Future<void> saveSelectedUser(String email) async {
    await _storage.write(key: 'selectedUser', value: email);
  }

  static Future<String?> getSelectedUser() async {
    return await _storage.read(key: 'selectedUser');
  }

  static Future<void> saveUserId(int userId) async {
    await _storage.write(key: 'userId', value: userId.toString());
  }

  static Future<int?> readUserId() async {
    String? userId = await _storage.read(key: 'userId');
    return userId != null ? int.tryParse(userId) : null;
  }

  static Future<void> deleteUserId() async {
    await _storage.delete(key: 'userId');
  }

  static Future<void> savePinCodeForUser(int userId, String pinCode) async {
    await _storage.write(key: 'pinCode_$userId', value: pinCode);
  }

  static Future<String?> readPinCodeForUser(int userId) async {
    return await _storage.read(key: 'pinCode_$userId');
  }

  static Future<void> deletePinCodeForUser(int userId) async {
    await _storage.delete(key: 'pinCode_$userId');
  }
}
