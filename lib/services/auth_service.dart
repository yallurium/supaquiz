import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supaquiz/services/nickname_generator.dart';
import 'package:uuid/uuid.dart';

class AuthService {
  static const _emailKey = 'email';
  static const _nicknameKey = 'nickname';
  static const _defaultPassword = '82eb32f2a3ef';

  final GoTrueClient _auth;
  final SharedPreferences _preferences;

  AuthService(this._auth, this._preferences);

  /// Creates an "anonymous" session by generating a random email
  /// and using the same password.
  /// Email persisted to avoid creating a new user every time
  /// the app is restarted.
  /// NOTE: Email confirmation must be disabled for this to work.
  Future<AuthResponse> signIn(String nickname) async {
    _preferences.setString(_nicknameKey, nickname);
    if (_preferences.containsKey(_emailKey)) {
      return _auth.signInWithPassword(
        email: _preferences.getString(_emailKey)!,
        password: _defaultPassword,
      );
    } else {
      final email = _randomEmail;
      final response =
          await _auth.signUp(email: email, password: _defaultPassword);
      log('User signed up with random email $email');
      _preferences.setString(_emailKey, email);
      return response;
    }
  }

  String get userId => _auth.currentUser!.id;

  String get nickname =>
      _preferences.getString(_nicknameKey) ?? NicknameGenerator.generate;

  static String get _randomEmail {
    return '${Uuid().v4().toString()}@test.dartling.dev';
  }
}
