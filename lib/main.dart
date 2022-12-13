import 'package:flutter/material.dart';
import 'package:supaquiz/dependencies.dart';
import 'package:supaquiz/theme.dart';
import 'package:supaquiz/views/home.dart';
import 'package:supaquiz/widgets/app_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Dependencies.init(
      child: MaterialApp(
        title: 'Supaquiz',
        theme: theme,
        home: AppScreen(
          child: const HomeView(),
        ),
      ),
    );
  }
}
