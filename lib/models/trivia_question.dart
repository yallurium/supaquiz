class TriviaQuestion {
  final String category;
  final String correctAnswer;
  final List<String> incorrectAnswers;
  final String question;
  final List<String> shuffledAnswers;

  TriviaQuestion._(
      this.category, this.correctAnswer, this.incorrectAnswers, this.question)
      : shuffledAnswers = List.of(incorrectAnswers)
          ..add(correctAnswer)
          ..shuffle();

  factory TriviaQuestion.fromJson(Map<String, dynamic> json) {
    return TriviaQuestion._(
      json['category'] as String,
      json['correctAnswer'] as String,
      (json['incorrectAnswers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      json['question'] as String,
    );
  }
}
