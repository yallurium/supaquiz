import 'package:flutter/material.dart';
import 'package:supaquiz/navigation.dart';
import 'package:supaquiz/services.dart';
import 'package:supaquiz/views/multiplayer_game/multiplayer_game_host_intro.dart';
import 'package:supaquiz/widgets/app_button.dart';
import 'package:supaquiz/widgets/app_input_field.dart';
import 'package:supaquiz/widgets/app_screen.dart';
import 'package:supaquiz/widgets/heading.dart';
import 'package:supaquiz/widgets/screen_loader.dart';

class MultiplayerGameSettings extends StatelessWidget {
  final numOfQuestionsController = TextEditingController(text: '5');
  final secondsPerQuestionController = TextEditingController(text: '5');

  MultiplayerGameSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Heading(text: 'Number of questions'),
          AppInputField.number(
            controller: numOfQuestionsController,
          ),
          const SizedBox(height: 8.0),
          Heading(text: 'Seconds to answer'),
          AppInputField.number(
            controller: secondsPerQuestionController,
          ),
          const SizedBox(height: 8.0),
          AppButton.expanded(
            label: 'Create game',
            onPressed: () async {
              final numOfQuestions =
                  int.tryParse(numOfQuestionsController.text) ?? 5;
              final secondsToAnswer =
                  int.tryParse(secondsPerQuestionController.text) ?? 5;
              switchScreen(
                context,
                ScreenLoader(
                  future: Services.of(context)
                      .gameService
                      .newMultiplayerGame(numOfQuestions, secondsToAnswer),
                  builder: (context, game) =>
                      MultiplayerGameHostIntro(game: game),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
