import 'package:flutter/material.dart';
import 'package:supaquiz/navigation.dart';
import 'package:supaquiz/services.dart';
import 'package:supaquiz/services/nickname_generator.dart';
import 'package:supaquiz/views/title_screen.dart';
import 'package:supaquiz/widgets/app_button.dart';
import 'package:supaquiz/widgets/app_input_field.dart';
import 'package:supaquiz/widgets/app_screen.dart';
import 'package:supaquiz/widgets/heading.dart';

class IntroScreen extends StatelessWidget {
  final _nicknameController =
      TextEditingController(text: NicknameGenerator.generate);

  IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Heading(text: 'Choose nickname'),
          AppInputField(controller: _nicknameController),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: 'Play',
                  onPressed: () async {
                    await Services.of(context)
                        .authService
                        .signIn(_nicknameController.text);
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
