import 'package:flutter/widgets.dart';
import 'package:supaquiz/dependencies.dart';
import 'package:supaquiz/services/auth_service.dart';
import 'package:supaquiz/services/game_service.dart';

class Services extends InheritedWidget {
  final AuthService authService;
  final GameService gameService;

  Services({
    Key? key,
    required Dependencies dependencies,
    required Widget child,
  })  : authService = dependencies.authService,
        gameService = dependencies.gameService,
        super(key: key, child: child);

  static Services of(BuildContext context) {
    final Services? result =
        context.dependOnInheritedWidgetOfExactType<Services>();
    assert(result != null, 'No Dependencies found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(Services oldWidget) {
    return false;
  }
}
