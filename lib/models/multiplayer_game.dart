class MultiplayerGame {
  final int id;
  final String code;
  final String channel;
  final Duration timePerQuestion;

  MultiplayerGame(this.id, this.code, this.channel)
      : timePerQuestion = const Duration(seconds: 10);
}
