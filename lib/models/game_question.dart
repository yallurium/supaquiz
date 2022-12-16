class GameQuestion {
  final int id;
  final String text;
  final String correctAnswer;
  final List<String> incorrectAnswers;
  final List<String> shuffledAnswers;

  GameQuestion(this.id, this.text, this.correctAnswer, this.incorrectAnswers)
      : shuffledAnswers = List.of(incorrectAnswers)
          ..add(correctAnswer)
          ..shuffle();
}
