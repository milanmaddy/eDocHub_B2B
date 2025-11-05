import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:edochub_b2b/welcome_screen.dart';
import 'package:edochub_b2b/login_screen.dart';
import 'package:edochub_b2b/main_app_screen.dart';
import 'package:edochub_b2b/splash_screen.dart';
import 'package:edochub_b2b/theme_manager.dart';

// Define App Colors for Dark Theme
class DarkThemeColors {
  static const Color primaryGreen = Color(0xFF28A745);
  static const Color darkBackground = Color(0xFF1A1C20);
  static const Color darkCard = Color(0xFF2C2F36);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textGrey = Color(0xFFB0B2B8);
  static const Color accentRed = Color(0xFFDC3545);
}

// Define App Colors for Light Theme
class LightThemeColors {
  static const Color primaryGreen = Color(0xFF28A745);
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF0F2F5);
  static const Color textBlack = Color(0xFF1A1C20);
  static const Color textGrey = Color(0xFF65676B);
  static const Color accentRed = Color(0xFFDC3545);
}

void main() {
  runApp(const EdocHubApp());
}

class EdocHubApp extends StatelessWidget {
  const EdocHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        return MaterialApp(
          title: 'eDoc Hub B2B',
          debugShowCheckedModeBanner: false,
          theme: _buildLightTheme(context),
          darkTheme: _buildDarkTheme(context),
          themeMode: currentMode,
          initialRoute: '/splash',
          routes: {
            '/splash': (context) => const SplashScreen(),
            '/welcome': (context) => const WelcomeScreen(),
            '/login': (context) => const LoginScreen(),
            '/main': (context) => const MainAppScreen(),
          },
        );
      },
    );
  }

  ThemeData _buildDarkTheme(BuildContext context) {
    final baseTheme = ThemeData.dark();
    final textTheme = GoogleFonts.interTextTheme(baseTheme.textTheme).apply(
      bodyColor: DarkThemeColors.textWhite,
      displayColor: DarkThemeColors.textWhite,
    );

    return baseTheme.copyWith(
      primaryColor: DarkThemeColors.primaryGreen,
      scaffoldBackgroundColor: DarkThemeColors.darkBackground,
      cardColor: DarkThemeColors.darkCard,
      textTheme: textTheme,
      colorScheme: const ColorScheme.dark(
        primary: DarkThemeColors.primaryGreen,
        secondary: DarkThemeColors.primaryGreen,
        background: DarkThemeColors.darkBackground,
        surface: DarkThemeColors.darkCard,
        onPrimary: DarkThemeColors.textWhite,
        onSecondary: DarkThemeColors.textWhite,
        onBackground: DarkThemeColors.textWhite,
        onSurface: DarkThemeColors.textWhite,
        error: DarkThemeColors.accentRed,
      ),
      // ... (rest of the dark theme definition)
    );
  }

  ThemeData _buildLightTheme(BuildContext context) {
    final baseTheme = ThemeData.light();
    final textTheme = GoogleFonts.interTextTheme(baseTheme.textTheme).apply(
      bodyColor: LightThemeColors.textBlack,
      displayColor: LightThemeColors.textBlack,
    );

    return baseTheme.copyWith(
      primaryColor: LightThemeColors.primaryGreen,
      scaffoldBackgroundColor: LightThemeColors.lightBackground,
      cardColor: LightThemeColors.lightCard,
      textTheme: textTheme,
      colorScheme: const ColorScheme.light(
        primary: LightThemeColors.primaryGreen,
        secondary: LightThemeColors.primaryGreen,
        background: LightThemeColors.lightBackground,
        surface: LightThemeColors.lightCard,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onBackground: LightThemeColors.textBlack,
        onSurface: LightThemeColors.textBlack,
        error: LightThemeColors.accentRed,
      ),
      // ... (rest of the light theme definition)
    );
  }
}