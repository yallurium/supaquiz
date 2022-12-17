enum GameStatus {
  pending,
  started,
  complete;

  static GameStatus fromString(String status) {
    return GameStatus.values.firstWhere((e) => e.name == status);
  }
}
