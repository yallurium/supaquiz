import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supaquiz/widgets/app_screen.dart';

class ScreenLoader<T> extends StatelessWidget {
  const ScreenLoader({
    Key? key,
    required this.future,
    required this.builder,
  }) : super(key: key);

  final Future<T> future;
  final Widget Function(BuildContext, T) builder;

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      child: FutureBuilder<T>(
        future: future,
        builder: (context, snapshot) {
          bool ready = snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null;
          if (snapshot.hasError) {
            log('Error loading screen', error: snapshot.error);
          }
          return ready
              ? builder(context, snapshot.data!)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: const CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('Loading...'),
                    )
                  ],
                );
        },
      ),
    );
  }
}
