import 'package:flutter/widgets.dart';
import 'package:supaquiz/repositories/trivia_repository.dart';
import 'package:supaquiz/services/game_service.dart';

class Dependencies extends InheritedWidget {
  final GameService gameService;

  factory Dependencies.init({required Widget child}) {
    return Dependencies._(
      gameService: GameService(TriviaRepository()),
      child: child,
    );
  }

  const Dependencies._({
    Key? key,
    required this.gameService,
    required Widget child,
  }) : super(key: key, child: child);

  static Dependencies of(BuildContext context) {
    final Dependencies? result =
        context.dependOnInheritedWidgetOfExactType<Dependencies>();
    assert(result != null, 'No Dependencies found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(Dependencies oldWidget) {
    return false;
  }
}
