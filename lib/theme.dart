import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const supabaseGreen = Color.fromRGBO(101, 217, 165, 1.0);

ThemeData get theme {
  final theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: supabaseGreen,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );
  return theme.copyWith(
    textTheme: GoogleFonts.pressStart2pTextTheme(theme.textTheme),
    primaryTextTheme: GoogleFonts.pressStart2pTextTheme(theme.primaryTextTheme),
  );
}
