import 'package:flutter/material.dart';
import 'package:supaquiz/models/trivia_question.dart';
import 'package:supaquiz/widgets/option_button.dart';

class Round extends StatelessWidget {
  final TriviaQuestion question;

  const Round({Key? key, required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            question.question,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        ...question.answers.map((answer) {
          return Row(
            children: [
              Expanded(child: OptionButton(onPressed: () {}, label: answer)),
            ],
          );
        })
      ],
    );
  }
}
