import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supaquiz/models/game_question.dart';
import 'package:supaquiz/models/multiplayer_game.dart';
import 'package:supaquiz/navigation.dart';
import 'package:supaquiz/services.dart';
import 'package:supaquiz/views/multiplayer_game/multiplayer_game_answer_selection.dart';
import 'package:supaquiz/views/multiplayer_game/multiplayer_game_scoreboard.dart';
import 'package:supaquiz/widgets/screen_loader.dart';

class MultiplayerGameManager {
  final Iterator<GameQuestion> _iterator;

  MultiplayerGameManager(List<GameQuestion> questions)
      : _iterator = questions.iterator;

  GameQuestion? get nextQuestion {
    final hasNext = _iterator.moveNext();
    if (hasNext) {
      return _iterator.current;
    }
    return null;
  }
}

// TODO Implement time limit.
class MultiplayerGameView extends StatefulWidget {
  final MultiplayerGame game;
  final MultiplayerGameManager manager;

  MultiplayerGameView({
    Key? key,
    required this.game,
    required List<GameQuestion> questions,
  })  : manager = MultiplayerGameManager(questions),
        super(key: key);

  @override
  State<MultiplayerGameView> createState() => _MultiplayerGameViewState();
}

class _MultiplayerGameViewState extends State<MultiplayerGameView> {
  GameQuestion? question;
  String? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    question = question ?? widget.manager.nextQuestion!;
    return MultiplayerGameAnswerSelection(
      question: question!,
      selected: selectedAnswer,
      onAnswerSelected: (answer) async {
        setState(() {
          selectedAnswer = answer;
        });
        log('Answered "$answer"');
        await Services.of(context)
            .gameService
            .answerQuestion(widget.game.id, question!.id, answer);
        await Future.delayed(Duration(seconds: 1));
        next();
      },
    );
  }

  void next() {
    setState(() {
      final nextQuestion = widget.manager.nextQuestion;
      if (nextQuestion != null) {
        setState(() {
          question = nextQuestion;
          selectedAnswer = null;
        });
      } else {
        switchScreen(
          context,
          ScreenLoader(
            loadingText: 'Calculating...',
            future: Services.of(context).gameService.getScores(widget.game.id),
            builder: (context, scores) => MultiplayerGameScoreboard(
              scores: scores,
              userId: Services.of(context).authService.userId,
            ),
          ),
        );
      }
    });
  }
}
