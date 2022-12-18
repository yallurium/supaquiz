import 'package:flutter/material.dart';
import 'package:supaquiz/models/player_score.dart';
import 'package:supaquiz/theme.dart';

class MultiplayerGameScoreboard extends StatelessWidget {
  final List<PlayerScore> scores;
  final String userId;

  const MultiplayerGameScoreboard({
    Key? key,
    required this.scores,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentScore = -1;
    int rank = 0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Results', style: Theme.of(context).textTheme.headline4),
        ),
        ...scores.map(
          (score) {
            final lineStyle =
                TextStyle(color: score.userId == userId ? supabaseGreen : null);
            if (score.score != currentScore) {
              currentScore = score.score;
              rank++;
            }
            return ListTile(
              title: Text(
                '$rank. ${score.nickname}',
                style: lineStyle,
              ),
              trailing: Text(score.score.toString(), style: lineStyle),
            );
          },
        ),
      ],
    );
  }
}
