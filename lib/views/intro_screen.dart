import 'package:flutter/material.dart';
import 'package:supaquiz/navigation.dart';
import 'package:supaquiz/services.dart';
import 'package:supaquiz/services/player_name_generator.dart';
import 'package:supaquiz/views/title_screen.dart';
import 'package:supaquiz/widgets/app_button.dart';
import 'package:supaquiz/widgets/app_input_field.dart';
import 'package:supaquiz/widgets/app_screen.dart';
import 'package:supaquiz/widgets/heading.dart';

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
          Heading(text: 'Select name'),
          AppInputField(controller: _playerNameController),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: 'Play',
                  onPressed: () async {
                    await Services.of(context)
                        .authService
                        .signIn(_playerNameController.text);
                    switchScreen(context, const TitleScreen());
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
