import 'dart:developer';

import 'package:hashids2/hashids2.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supaquiz/models/multiplayer_game.dart';
import 'package:supaquiz/models/solo_game.dart';
import 'package:supaquiz/repositories/trivia_repository.dart';
import 'package:supaquiz/services/auth_service.dart';

class _GameFields {
  static const id = 'id';
  static const channel = 'channel';
  static const status = 'status';
}

class _PlayerFields {
  static const playerName = 'player_name';
}

class GameService {
  static const _gamesTable = 'games';
  static const _playerTable = 'players';

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
        await _supabaseClient.from(_gamesTable).insert({}).select().single();
    final gameId = game[_GameFields.id];
    final gameCode = _toGameCode(gameId);
    final channel = game[_GameFields.channel] as String;
    final questions = await _triviaRepository.getQuestions(numOfQuestions);
    log('Created game with code $gameCode (ID $gameId) and channel $channel');
    await _joinGame(gameId);
    return MultiplayerGame(gameId, gameCode, channel, questions);
  }

  Future<MultiplayerGame> joinMultiplayerGame(String gameCode) async {
    final gameId = _toGameId(gameCode);
    log('Searching for game with code $gameCode (ID $gameId)');
    if (gameId == null) {
      throw InvalidGameCodeException('Invalid code');
    }
    final game = await _supabaseClient
        .from(_gamesTable)
        .select('${_GameFields.status},${_GameFields.channel}')
        .eq(_GameFields.id, gameId)
        .maybeSingle();
    if (game == null) {
      throw InvalidGameCodeException('Invalid code');
    }
    final status = game[_GameFields.status];
    log('Found game with status $status');
    if (status != 'pending') {
      throw InvalidGameCodeException('Game has already started');
    }
    await _joinGame(gameId);
    return MultiplayerGame(gameId, gameCode, game['channel'], []);
  }

  Stream<List<String>> getCurrentPlayers(int gameId) {
    return _supabaseClient
        .from(_playerTable)
        .stream(primaryKey: ['id'])
        .eq('game_id', gameId)
        .map((event) {
          return event
            .map((e) => e[_PlayerFields.playerName] as String)
            .toList();
        });
  }

  Future<void> _joinGame(int gameId) async {
    final playerName = _authService.playerName;
    log('Adding $playerName as player in game $gameId');
    await _supabaseClient.from(_playerTable).upsert(
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
