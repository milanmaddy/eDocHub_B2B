import 'dart:ui';

extension ColorOpacitySafe on Color {
  /// Replacement for deprecated `withOpacity`.
  /// Creates a new color with the specified opacity.
  Color withOpacitySafe(double opacity) {
    final clamped = opacity.clamp(0.0, 1.0);
    return Color.fromARGB(
      (clamped * 255).round(),
      red,
      green,
      blue,
    );
  }
}

