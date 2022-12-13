import 'package:flutter/material.dart';
import 'package:supaquiz/models/trivia_question.dart';
import 'package:supaquiz/views/game/round.dart';

class GameView extends StatelessWidget {
  final List<TriviaQuestion> questions;

  const GameView({Key? key, required this.questions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          alignment: Alignment.center,
          child: Round(question: questions.first),
        ),
      ),
    );
  }
}
