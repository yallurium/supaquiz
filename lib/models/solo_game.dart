import 'package:supaquiz/models/trivia_question.dart';

class SoloGame {
  final Iterator<TriviaQuestion> _iterator;
  final int totalQuestions;

  int _correctAnswers = 0;

  SoloGame(List<TriviaQuestion> questions)
      : _iterator = questions.iterator,
        totalQuestions = questions.length;

  int get correctAnswers => _correctAnswers;

  TriviaQuestion? get nextQuestion {
    final hasNext = _iterator.moveNext();
    if (hasNext) {
      return _iterator.current;
    }
    return null;
  }

  bool validateAnswer(String answer, TriviaQuestion question) {
    if (question.correctAnswer != answer) {
      return false;
    }
    _correctAnswers += 1;
    return true;
  }
}
