import 'package:flutter/material.dart';
import 'package:supaquiz/services.dart';
import 'package:supaquiz/services/player_name_generator.dart';
import 'package:supaquiz/views/title_screen.dart';
import 'package:supaquiz/widgets/app_button.dart';
import 'package:supaquiz/widgets/app_input_field.dart';
import 'package:supaquiz/widgets/app_screen.dart';
import 'package:supaquiz/widgets/setting_heading.dart';

class IntroScreen extends StatelessWidget {
  final _playerNameController =
      TextEditingController(text: PlayerNameGenerator.generate);

  IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SettingHeading(text: 'Select name'),
          AppInputField(controller: _playerNameController),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: 'Play',
                  onPressed: () {
                    Services.of(context).gameService.playerName =
                        _playerNameController.text;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TitleScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
