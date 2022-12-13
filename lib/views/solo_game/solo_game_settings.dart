import 'package:flutter/material.dart';
import 'package:supaquiz/dependencies.dart';
import 'package:supaquiz/models/solo_game.dart';
import 'package:supaquiz/views/solo_game/solo_game_view.dart';
import 'package:supaquiz/widgets/app_button.dart';
import 'package:supaquiz/widgets/app_input_field.dart';
import 'package:supaquiz/widgets/app_screen.dart';
import 'package:supaquiz/widgets/screen_loader.dart';
import 'package:supaquiz/widgets/setting_heading.dart';

class SoloGameSettings extends StatelessWidget {
  final numOfQuestionsController = TextEditingController(text: '5');

  SoloGameSettings({Key? key}) : super(key: key);

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
            onPressed: () {
              final numOfQuestions =
                  int.tryParse(numOfQuestionsController.text) ?? 5;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => ScreenLoader<SoloGame>(
                      future: Dependencies.of(context)
                          .gameService
                          .newSoloGame(numOfQuestions),
                      builder: (context, game) {
                        return SoloGameView(game: game);
                      }),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
