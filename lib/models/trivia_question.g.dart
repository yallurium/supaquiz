// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trivia_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TriviaQuestion _$TriviaQuestionFromJson(Map<String, dynamic> json) =>
    TriviaQuestion(
      json['category'] as String,
      json['correctAnswer'] as String,
      (json['incorrectAnswers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      json['question'] as String,
    );

Map<String, dynamic> _$TriviaQuestionToJson(TriviaQuestion instance) =>
    <String, dynamic>{
      'category': instance.category,
      'correctAnswer': instance.correctAnswer,
      'incorrectAnswers': instance.incorrectAnswers,
      'question': instance.question,
    };
