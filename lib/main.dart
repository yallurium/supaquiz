import 'package:flutter/material.dart';
import 'package:supaquiz/dependencies.dart';
import 'package:supaquiz/services.dart';
import 'package:supaquiz/theme.dart';
import 'package:supaquiz/views/intro_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dependencies = await Dependencies.init;
  runApp(SupaquizApp(dependencies: dependencies));
}

class SupaquizApp extends StatelessWidget {
  final Dependencies dependencies;

  const SupaquizApp({super.key, required this.dependencies});

  @override
  Widget build(BuildContext context) {
    return Services(
      dependencies: dependencies,
      child: MaterialApp(
        title: 'Supaquiz',
        theme: theme,
        home: IntroScreen(),
      ),
    );
  }
}
