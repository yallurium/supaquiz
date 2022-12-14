class PlayerNameGenerator {
  static final _first = ['Trivia', 'Quiz'];
  static final _second = ['King', 'Queen', 'Titan', 'Diva', 'Wizard', 'Buff', 'Pro'];

  static String get generate {
    _first.shuffle();
    _second.shuffle();
    return _first.first + ' ' + _second.first;
  }
}