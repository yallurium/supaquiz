import 'package:flutter/material.dart';
import 'package:supaquiz/repositories/trivia_repository.dart';
import 'package:supaquiz/views/solo_game/solo_game_settings.dart';
import 'package:supaquiz/widgets/app_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AppButton.expanded(
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SoloGameSettings(),
              ),
            );
          },
          label: 'Play solo',
        ),
        AppButton.expanded(onPressed: () {}, label: 'Host game'),
        AppButton.expanded(onPressed: () {}, label: 'Join game'),
      ],
    );
  }
}
