import 'package:flutter/material.dart';
import 'package:supaquiz/models/multiplayer_game.dart';
import 'package:supaquiz/widgets/app_screen.dart';
import 'package:supaquiz/widgets/players_in_game.dart';

class MultiplayerGamePlayerIntro extends StatelessWidget {
  final MultiplayerGame game;

  const MultiplayerGamePlayerIntro({Key? key, required this.game})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Waiting for host to start the game...',
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LinearProgressIndicator(),
          ),
          PlayersInGame(gameId: game.id),
        ],
      ),
    );
  }
}
