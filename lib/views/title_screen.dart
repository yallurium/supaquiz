import 'package:flutter/material.dart';
import 'package:supaquiz/views/multiplayer_game/multiplayer_game_search.dart';
import 'package:supaquiz/views/multiplayer_game/multiplayer_game_settings.dart';
import 'package:supaquiz/views/solo_game/solo_game_settings.dart';
import 'package:supaquiz/widgets/app_button.dart';
import 'package:supaquiz/widgets/app_screen.dart';

class TitleScreen extends StatelessWidget {
  const TitleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'SUPAQUIZ',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          AppButton.expanded(
            label: 'Join game',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MultiplayerGameSearch(),
                ),
              );
            },
          ),
          AppButton.expanded(
            label: 'Host game',
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MultiplayerGameSettings(),
                ),
              );
            },
          ),
          AppButton.expanded(
            label: 'Play solo',
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SoloGameSettings(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
