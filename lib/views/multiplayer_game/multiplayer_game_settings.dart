import 'package:flutter/material.dart';
import 'package:supaquiz/services.dart';
import 'package:supaquiz/views/multiplayer_game/multiplayer_game_host_intro.dart';
import 'package:supaquiz/widgets/app_button.dart';
import 'package:supaquiz/widgets/app_input_field.dart';
import 'package:supaquiz/widgets/app_screen.dart';
import 'package:supaquiz/widgets/setting_heading.dart';

class MultiplayerGameSettings extends StatelessWidget {
  final numOfQuestionsController = TextEditingController(text: '5');

  MultiplayerGameSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SettingHeading(text: 'Number of questions'),
          AppInputField.number(
            controller: numOfQuestionsController,
          ),
          const SizedBox(height: 8.0),
          AppButton.expanded(
            label: 'Start game',
            onPressed: () async {
              final numOfQuestions =
                  int.tryParse(numOfQuestionsController.text) ?? 5;
              // TODO make properly async
              final game = await Services.of(context)
                  .gameService
                  .newMultiplayerGame(numOfQuestions);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AppScreen(
                      child: MultiplayerGameHostIntro(game: game),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
