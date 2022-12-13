import 'package:flutter/material.dart';
import 'package:supaquiz/theme.dart';
import 'package:supaquiz/views/home.dart';
import 'package:supaquiz/widgets/option_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supaquiz',
      theme: theme,
      home: const MyHomePage(title: 'Supaquiz'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: const HomeView(),
        ),
      ),
    );
  }
}
