import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supaquiz/repositories/trivia_repository.dart';
import 'package:supaquiz/secrets.dart';
import 'package:supaquiz/services/auth_service.dart';
import 'package:supaquiz/services/game_service.dart';

class Dependencies {
  final AuthService authService;
  final GameService gameService;

  Dependencies._(this.authService, this.gameService);

  static Future<Dependencies> get init async {
    final supabase = await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
    final sharedPreferences = await SharedPreferences.getInstance();
    final authService = AuthService(supabase.client.auth, sharedPreferences);
    final gameService = GameService(TriviaRepository(), supabase.client);
    return Dependencies._(authService, gameService);
  }
}
