import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final GoTrueClient auth;

  AuthService(this.auth);

  // TODO random emails, persisted. Only sign up once.
  Future<AuthResponse> logIn() async {
    final email = 'christos@dartling.dev';
    final password = 'password123456';
    try {
      await auth.signUp(email: email, password: password);
    } finally {
      return auth.signInWithPassword(
        email: email,
        password: password,
      );
    }
  }
}
