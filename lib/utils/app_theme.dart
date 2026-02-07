import 'package:flutter/material.dart';

class AppTheme {
  static final ValueNotifier<ThemeMode> mode = ValueNotifier(ThemeMode.system);

  static void toggle() {
    mode.value = mode.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }
}

