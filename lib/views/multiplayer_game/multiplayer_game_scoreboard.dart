import 'package:flutter/material.dart';
import 'package:supaquiz/widgets/heading.dart';

// TODO Calculate score.
class MultiplayerGameScoreboard extends StatelessWidget {
  final int gameId;

  const MultiplayerGameScoreboard({Key? key, required this.gameId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Heading(text: 'Results'),
      ],
    );
  }
}
