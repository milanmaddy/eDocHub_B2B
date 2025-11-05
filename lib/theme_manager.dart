import 'package:flutter/material.dart';

// A simple global ValueNotifier to hold the current theme mode.
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);