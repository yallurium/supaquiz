import 'package:hashids2/hashids2.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supaquiz/models/multiplayer_game.dart';
import 'package:supaquiz/models/solo_game.dart';
import 'package:supaquiz/repositories/trivia_repository.dart';

class GameService {
  final TriviaRepository triviaRepository;
  final SupabaseClient supabaseClient;
  final HashIds hashIds;

  GameService(this.triviaRepository, this.supabaseClient) : hashIds = HashIds();

  Future<SoloGame> newSoloGame(int numOfQuestions) async {
    final questions = await triviaRepository.getQuestions(numOfQuestions);
    return SoloGame(questions);
  }

  Future<MultiplayerGame> newMultiplayerGame(int numOfQuestions) async {
    final game =
        await supabaseClient.from('games').insert({}).select().single();
    final joinCode = _toJoinCode(game['id']);
    final channel = game['channel'] as String;
    final questions = await triviaRepository.getQuestions(numOfQuestions);
    return MultiplayerGame(joinCode, channel, questions);
  }

  String _toJoinCode(int gameId) {
    return hashIds.encode(gameId).padLeft(4, 'a');
  }
}
