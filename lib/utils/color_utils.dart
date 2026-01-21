import 'package:flutter/material.dart';

Color getContrastingTextColor(Color backgroundColor) {
  // Calculate the luminance of the background color
  final double luminance = backgroundColor.computeLuminance();

  // Return black for light backgrounds, white for dark backgrounds
  return luminance > 0.5 ? Colors.black : Colors.white;
}
