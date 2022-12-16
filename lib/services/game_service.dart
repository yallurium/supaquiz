import 'dart:developer';

import 'package:hashids2/hashids2.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supaquiz/models/game_question.dart';
import 'package:supaquiz/models/multiplayer_game.dart';
import 'package:supaquiz/models/solo_game.dart';
import 'package:supaquiz/models/trivia_question.dart';
import 'package:supaquiz/repositories/trivia_repository.dart';
import 'package:supaquiz/services/auth_service.dart';

class GameService {
  final AuthService _authService;
  final TriviaRepository _triviaRepository;
  final SupabaseClient _supabaseClient;
  final HashIds _hashIds;

  GameService(this._authService, this._triviaRepository, this._supabaseClient)
      : _hashIds = HashIds(minHashLength: 4);

  Future<SoloGame> newSoloGame(int numOfQuestions) async {
    final questions = await _triviaRepository.getQuestions(numOfQuestions);
    return SoloGame(questions);
  }

  Future<MultiplayerGame> newMultiplayerGame(int numOfQuestions) async {
    final game =
        await _supabaseClient.from('games').insert({}).select().single();
    final gameId = game['id'];
    final gameCode = _toGameCode(gameId);
    final channel = game['channel'] as String;
    final questions = await _triviaRepository.getQuestions(numOfQuestions);
    await _insertGameQuestions(gameId, questions);
    log('Created game with code $gameCode (ID $gameId) and channel $channel');
    await _joinGame(gameId);
    return MultiplayerGame(gameId, gameCode, channel);
  }

  Future<void> _insertGameQuestions(
      int gameId, List<TriviaQuestion> questions) async {
    final List<Map<String, dynamic>> values = questions.map((q) {
      return {
        'game_id': gameId,
        'question': q.question,
        'correct_answer': q.correctAnswer,
        'wrong_answer_1': q.incorrectAnswers[0],
        'wrong_answer_2': q.incorrectAnswers[1],
        'wrong_answer_3': q.incorrectAnswers[2],
      };
    }).toList();
    await _supabaseClient.from('questions').insert(values);
  }

  Future<MultiplayerGame> joinMultiplayerGame(String gameCode) async {
    final gameId = _toGameId(gameCode);
    log('Searching for game with code $gameCode (ID $gameId)');
    if (gameId == null) {
      throw InvalidGameCodeException('Invalid code');
    }
    final game = await _supabaseClient
        .from('games')
        .select('status,channel')
        .eq('id', gameId)
        .maybeSingle();
    if (game == null) {
      throw InvalidGameCodeException('Invalid code');
    }
    final status = game['status'];
    log('Found game with status $status');
    if (status != 'pending') {
      throw InvalidGameCodeException('Game has already started');
    }
    await _joinGame(gameId);
    return MultiplayerGame(gameId, gameCode, game['channel']);
  }

  Future<List<GameQuestion>> getQuestions(int gameId) async {
    final questions = await _supabaseClient
        .from('questions')
        .select<List<Map<String, dynamic>>>()
        .eq('game_id', gameId);
    return questions.map((q) {
      final incorrectAnswers = <String>[
        q['wrong_answer_1'],
        q['wrong_answer_2'],
        q['wrong_answer_3'],
      ];
      return GameQuestion(
          q['id'], q['question'], q['correct_answer'], incorrectAnswers);
    }).toList();
  }

  Future<void> answerQuestion(int gameId, int questionId, String answer) async {
    await _supabaseClient.from('answers').insert({
      'game_id': gameId,
      'question_id': questionId,
      'answer': answer,
    });
  }

  Stream<List<String>> getCurrentPlayers(int gameId) {
    return _supabaseClient
        .from('players')
        .stream(primaryKey: ['id'])
        .eq('game_id', gameId)
        .map((event) {
          return event.map((e) => e['player_name'] as String).toList();
        });
  }

  Future<void> _joinGame(int gameId) async {
    final playerName = _authService.playerName;
    log('Adding $playerName as player in game $gameId');
    await _supabaseClient.from('players').upsert(
      {'player_name': playerName, 'game_id': gameId},
      onConflict: 'game_id,user_id',
    );
  }

  String _toGameCode(int gameId) {
    return _hashIds.encode(gameId).padLeft(4, 'a');
  }

  int? _toGameId(String gameCode) {
    final decoded = _hashIds.decode(gameCode);
    return decoded.isNotEmpty ? decoded.first : null;
  }
}

class InvalidGameCodeException implements Exception {
  final String message;

  InvalidGameCodeException(this.message);
}
