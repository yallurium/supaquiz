import 'package:flutter/material.dart';
import 'package:supaquiz/services.dart';
import 'package:supaquiz/widgets/heading.dart';

class PlayersInGame extends StatelessWidget {
  final int gameId;

  const PlayersInGame({Key? key, required this.gameId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
      stream: Services.of(context).gameService.getCurrentPlayers(gameId),
      initialData: const [],
      builder: (context, snapshot) {
        final players = snapshot.data ?? [];
        return Column(
          children: [
            const SizedBox(height: 12.0),
            Heading(text: 'Players'),
            const SizedBox(height: 12.0),
            ...players.map((nickname) => Text(
                  nickname,
                  style: Theme.of(context).textTheme.bodySmall,
                )),
            Text(
              '...?',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        );
      },
    );
  }
}
