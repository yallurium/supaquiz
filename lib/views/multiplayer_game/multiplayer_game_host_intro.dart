import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supaquiz/models/game_status.dart';
import 'package:supaquiz/models/multiplayer_game.dart';
import 'package:supaquiz/navigation.dart';
import 'package:supaquiz/services.dart';
import 'package:supaquiz/theme.dart';
import 'package:supaquiz/views/multiplayer_game/multiplayer_game_view.dart';
import 'package:supaquiz/widgets/app_button.dart';
import 'package:supaquiz/widgets/players_in_game.dart';

class MultiplayerGameHostIntro extends StatelessWidget {
  final MultiplayerGame game;

  const MultiplayerGameHostIntro({Key? key, required this.game})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'GAME CODE',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            game.code,
            style: Theme.of(context)
                .textTheme
                .headline1
                ?.copyWith(color: supabaseGreen),
          ),
        ),
        PlayersInGame(gameId: game.id),
        const SizedBox(height: 24.0),
        AppButton.expanded(
          label: 'Start game',
          onPressed: () async {
            final gameService = Services.of(context).gameService;
            await gameService.updateGameStatus(game.id, GameStatus.started);
            log('Game ${game.id} started');
            final questions = await gameService.getQuestions(game.id);
            switchScreen(
                context, MultiplayerGameView(game: game, questions: questions));
          },
        ),
      ],
    );
  }
}
