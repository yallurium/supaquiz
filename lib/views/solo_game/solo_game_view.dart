import 'package:flutter/material.dart';
import 'package:supaquiz/models/solo_game.dart';
import 'package:supaquiz/models/trivia_question.dart';
import 'package:supaquiz/views/solo_game/solo_game_answer_selection.dart';
import 'package:supaquiz/views/solo_game/solo_game_score.dart';
import 'package:supaquiz/widgets/app_screen.dart';

class SoloGameView extends StatefulWidget {
  final SoloGame game;

  const SoloGameView({Key? key, required this.game}) : super(key: key);

  @override
  State<SoloGameView> createState() => _SoloGameViewState();
}

class _SoloGameViewState extends State<SoloGameView> {
  TriviaQuestion? question;
  String? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    question = question ?? widget.game.nextQuestion!;
    return SoloGameAnswerSelection(
      question: question!,
      selected: selectedAnswer,
      onAnswerSelected: (answer) async {
        setState(() {
          selectedAnswer = answer;
        });
        await Future.delayed(Duration(seconds: 2));
        widget.game.validateAnswer(answer, question!);
        next();
      },
    );
  }

  void next() {
    setState(() {
      final nextQuestion = widget.game.nextQuestion;
      if (nextQuestion != null) {
        setState(() {
          question = nextQuestion;
          selectedAnswer = null;
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => AppScreen(
              child: SoloGameScore(
                correctAnswers: widget.game.correctAnswers,
                totalQuestions: widget.game.totalQuestions,
              ),
            ),
          ),
        );
      }
    });
  }
}
