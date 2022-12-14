import 'package:supaquiz/models/trivia_question.dart';

class MultiplayerGame {
  final String joinCode;
  final String channel;

  final Iterator<TriviaQuestion> _iterator;
  final int totalQuestions;

  MultiplayerGame(this.joinCode, this.channel, List<TriviaQuestion> questions)
      : _iterator = questions.iterator,
        totalQuestions = questions.length;

  TriviaQuestion? get nextQuestion {
    final hasNext = _iterator.moveNext();
    if (hasNext) {
      return _iterator.current;
    }
    return null;
  }
}
