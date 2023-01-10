import 'package:flutter/material.dart';

import 'default_input_border.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: const Color(0xFFEEF1F8),
    primarySwatch: Colors.blue,
    fontFamily: "Intel",
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      errorStyle: TextStyle(height: 0),
      border: defaultInputBorder,
      enabledBorder: defaultInputBorder,
      focusedBorder: defaultInputBorder,
      errorBorder: defaultInputBorder,
    ),
  );
}
