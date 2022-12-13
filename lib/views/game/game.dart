import 'package:flutter/material.dart';
import 'package:supaquiz/models/trivia_question.dart';
import 'package:supaquiz/widgets/app_screen.dart';

class GameView extends StatelessWidget {
  final List<TriviaQuestion> questions;

  const GameView({Key? key, required this.questions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      child: const SizedBox(),
    );
  }
}
