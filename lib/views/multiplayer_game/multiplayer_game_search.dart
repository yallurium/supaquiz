import 'package:flutter/material.dart';
import 'package:supaquiz/services.dart';
import 'package:supaquiz/services/game_service.dart';
import 'package:supaquiz/views/multiplayer_game/multiplayer_game_player_intro.dart';
import 'package:supaquiz/widgets/app_button.dart';
import 'package:supaquiz/widgets/app_input_field.dart';
import 'package:supaquiz/widgets/app_screen.dart';
import 'package:supaquiz/widgets/setting_heading.dart';

class MultiplayerGameSearch extends StatelessWidget {
  final _gameCodeController = TextEditingController();

  MultiplayerGameSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SettingHeading(text: 'Enter game code'),
          AppInputField(controller: _gameCodeController),
          const SizedBox(height: 8.0),
          AppButton.expanded(
            label: 'Join game',
            onPressed: () async {
              try {
                final game = await Services.of(context)
                    .gameService
                    .joinMultiplayerGame(_gameCodeController.text);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return MultiplayerGamePlayerIntro(game: game);
                    },
                  ),
                );
              } on InvalidGameCodeException catch (ex) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      ex.message.toUpperCase() + '.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
