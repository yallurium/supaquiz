import 'package:flutter/material.dart';
import 'package:supaquiz/repositories/trivia_repository.dart';
import 'package:supaquiz/views/game/game.dart';
import 'package:supaquiz/widgets/option_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            Expanded(
              child: OptionButton(
                onPressed: () async {
                  final questions = await TriviaRepository().getQuestions();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GameView(questions: questions),
                    ),
                  );
                },
                label: 'Play solo',
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(child: OptionButton(onPressed: () {}, label: 'New game')),
          ],
        ),
        Row(
          children: [
            Expanded(child: OptionButton(onPressed: () {}, label: 'Join game')),
          ],
        ),
      ],
    );
  }
}
