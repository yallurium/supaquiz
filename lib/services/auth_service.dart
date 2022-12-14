import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supaquiz/services/player_name_generator.dart';
import 'package:uuid/uuid.dart';

class AuthService {
  static const _userIdKey = 'user_id';
  static const _playerNameKey = 'player_name';
  static const _defaultPassword = '82eb32f2a3ef';

  final GoTrueClient _auth;
  final SharedPreferences _preferences;

  AuthService(this._auth, this._preferences);

  /// Creates an "anonymous" session by generating a random email
  /// and using the same password.
  /// User ID is persisted to avoid creating a new user every time
  /// the app is restarted.
  Future<AuthResponse> signIn(String playerName) async {
    _preferences.setString(_playerNameKey, playerName);
    if (_preferences.containsKey(_userIdKey)) {
      final userId = _preferences.getString(_userIdKey)!;
      return _auth.signInWithPassword(
          email: _email(userId), password: _defaultPassword);
    } else {
      final userId = Uuid().v4().toString();
      _preferences.setString(_userIdKey, userId);
      return _auth.signUp(email: _email(userId), password: _defaultPassword);
    }
  }

  String get playerName =>
      _preferences.getString(_playerNameKey) ?? PlayerNameGenerator.generate;

  static String _email(String userId) {
    return '$userId@dartling.dev';
  }
}
