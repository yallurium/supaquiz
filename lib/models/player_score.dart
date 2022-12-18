class PlayerScore {
  final String userId;
  final String nickname;
  final int score;

  PlayerScore(this.userId, this.nickname, this.score);

  PlayerScore.fromJson(Map<String, dynamic> json)
      : userId = json['user_id'],
        nickname = json['nickname'],
        score = json['score'];

  @override
  String toString() {
    return 'PlayerScore{userId: $userId, nickname: $nickname, score: $score}';
  }
}
