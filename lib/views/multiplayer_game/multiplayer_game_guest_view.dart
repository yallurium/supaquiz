import 'package:flutter/material.dart';
import 'package:supaquiz/widgets/app_screen.dart';

class MultiplayerGameGuestView extends StatelessWidget {
  final String code;
  final String channel;

  const MultiplayerGameGuestView(
      {Key? key, required this.code, required this.channel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Waiting for host to start the game...',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
