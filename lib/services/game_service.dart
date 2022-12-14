import 'dart:developer';

import 'package:hashids2/hashids2.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supaquiz/models/multiplayer_game.dart';
import 'package:supaquiz/models/solo_game.dart';
import 'package:supaquiz/repositories/trivia_repository.dart';
import 'package:supaquiz/services/player_name_generator.dart';

class _Fields {
  static const id = 'id';
  static const channel = 'channel';
  static const status = 'status';
}

class GameService {
  static const _gamesTable = 'games';

  final TriviaRepository _triviaRepository;
  final SupabaseClient _supabaseClient;
  final HashIds _hashIds;
  var playerName = PlayerNameGenerator.generate;

  GameService(this._triviaRepository, this._supabaseClient)
      : _hashIds = HashIds(minHashLength: 4);

  Future<SoloGame> newSoloGame(int numOfQuestions) async {
    final questions = await _triviaRepository.getQuestions(numOfQuestions);
    return SoloGame(questions);
  }

  Future<MultiplayerGame> newMultiplayerGame(int numOfQuestions) async {
    final game =
        await _supabaseClient.from(_gamesTable).insert({}).select().single();
    final gameId = game[_Fields.id];
    final gameCode = _toGameCode(gameId);
    final channel = game[_Fields.channel] as String;
    final questions = await _triviaRepository.getQuestions(numOfQuestions);
    log('Created game with code $gameCode (ID $gameId) and channel $channel');
    return MultiplayerGame(gameCode, channel, questions);
  }

  Future<String> joinMultiplayerGame(String gameCode) async {
    final gameId = _toGameId(gameCode);
    log('Searching for game with code $gameCode (ID $gameId)');
    if (gameId == null) {
      throw InvalidGameCodeException('Invalid code');
    }
    final game = await _supabaseClient
        .from(_gamesTable)
        .select('${_Fields.status},${_Fields.channel}')
        .eq(_Fields.id, gameId)
        .maybeSingle();
    if (game == null) {
      throw InvalidGameCodeException('Invalid code');
    }
    final status = game[_Fields.status];
    log('Found game with status $status');
    if (status != 'pending') {
      throw InvalidGameCodeException('Game has already started');
    }
    return game['channel'];
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
