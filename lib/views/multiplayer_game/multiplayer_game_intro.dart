import 'package:flutter/material.dart';
import 'package:supaquiz/models/multiplayer_game.dart';
import 'package:supaquiz/theme.dart';

class MultiplayerGameIntro extends StatelessWidget {
  final MultiplayerGame game;

  const MultiplayerGameIntro({Key? key, required this.game}) : super(key: key);

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
            game.joinCode,
            style: Theme.of(context)
                .textTheme
                .headline1
                ?.copyWith(color: supabaseGreen),
          ),
        ),
      ],
    );
  }
}
