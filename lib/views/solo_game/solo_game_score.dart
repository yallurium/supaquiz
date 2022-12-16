import 'package:flutter/material.dart';
import 'package:supaquiz/theme.dart';
import 'package:supaquiz/widgets/app_button.dart';

class SoloGameScore extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;

  const SoloGameScore({
    Key? key,
    required this.correctAnswers,
    required this.totalQuestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'QUIZ COMPLETED',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$correctAnswers',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1?.copyWith(
                      color: supabaseGreen,
                    ),
              ),
              Text(
                '/$totalQuestions',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24.0),
        AppButton(
          label: 'Back',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
