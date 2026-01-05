import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../utils/hash_utils.dart';

class AuthService {
  static const String _usersKey = 'users';
  static const String _currentUserKey = 'current_user';

  Future<Map<String, String>> _loadUsers(SharedPreferences prefs) async {
    final raw = prefs.getString(_usersKey);
    if (raw == null || raw.isEmpty) {
      return {};
    }
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return decoded.map((key, value) => MapEntry(key, value as String));
  }

  Future<void> _saveUsers(SharedPreferences prefs, Map<String, String> users) async {
    await prefs.setString(_usersKey, jsonEncode(users));
  }

  Future<bool> register({required String phone, required String password}) async {
    final prefs = await SharedPreferences.getInstance();
    final users = await _loadUsers(prefs);
    if (users.containsKey(phone)) {
      return false;
    }
    users[phone] = simpleHash(password);
    await _saveUsers(prefs, users);
    await prefs.setString(_currentUserKey, phone);
    return true;
  }

  Future<bool> login({required String phone, required String password}) async {
    final prefs = await SharedPreferences.getInstance();
    final users = await _loadUsers(prefs);
    final storedHash = users[phone];
    if (storedHash == null) {
      return false;
    }
    if (storedHash != simpleHash(password)) {
      return false;
    }
    await prefs.setString(_currentUserKey, phone);
    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
  }

  Future<String?> currentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currentUserKey);
  }
}
