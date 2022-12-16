import 'package:json_annotation/json_annotation.dart';

part 'trivia_question.g.dart';

@JsonSerializable()
class TriviaQuestion {
  final String category;
  final String correctAnswer;
  final List<String> incorrectAnswers;
  final String question;
  final List<String> shuffledAnswers;

  TriviaQuestion(
      this.category, this.correctAnswer, this.incorrectAnswers, this.question)
      : shuffledAnswers = List.of(incorrectAnswers)
          ..add(correctAnswer)
          ..shuffle();

  factory TriviaQuestion.fromJson(Map<String, dynamic> json) =>
      _$TriviaQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$TriviaQuestionToJson(this);
}
