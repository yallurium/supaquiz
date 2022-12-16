import 'package:flutter/material.dart';
import 'package:supaquiz/models/trivia_question.dart';
import 'package:supaquiz/theme.dart';
import 'package:supaquiz/widgets/app_button.dart';

class SoloGameAnswerSelection extends StatelessWidget {
  static const red = Color(0xFFCE5152);

  final TriviaQuestion question;
  final Function(String) onAnswerSelected;
  final String? selected;

  const SoloGameAnswerSelection({
    Key? key,
    required this.question,
    required this.onAnswerSelected,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const SizedBox(height: 48.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            question.question,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        ...question.shuffledAnswers.map(
          (answer) {
            return Row(
              children: [
                Expanded(
                  child: AppButton(
                    onPressed: selected == null
                        ? () {
                            onAnswerSelected(answer);
                          }
                        : null,
                    label: answer,
                    backgroundColor: getColor(answer),
                  ),
                ),
              ],
            );
          },
        )
      ],
    );
  }

  Color? getColor(String answer) {
    if (selected == null) {
      return null;
    }
    if (answer == question.correctAnswer) {
      return supabaseGreen;
    }
    if (answer != selected) {
      return Colors.grey.shade700;
    }
    return red;
  }
}
