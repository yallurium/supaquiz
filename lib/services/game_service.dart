import 'package:supaquiz/models/solo_game.dart';
import 'package:supaquiz/repositories/trivia_repository.dart';

class GameService {
  final TriviaRepository triviaRepository;

  GameService(this.triviaRepository);

  Future<SoloGame> newSoloGame(int numOfQuestions) async {
    final questions = await triviaRepository.getQuestions(numOfQuestions);
    return SoloGame(questions);
  }
}