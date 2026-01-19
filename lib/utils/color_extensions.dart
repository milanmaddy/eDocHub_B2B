import 'dart:ui';

extension ColorOpacitySafe on Color {
  /// Replacement for deprecated `withOpacity`.
  /// Uses integer alpha to avoid precision loss warnings.
  Color withOpacitySafe(double opacity) {
    final clamped = opacity.clamp(0.0, 1.0);
    return withValues(alpha: (clamped * 255).round().toDouble());
  }
}

