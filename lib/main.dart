import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:edochub_b2b/screens/welcome_screen.dart';
import 'package:edochub_b2b/screens/login_screen.dart';
import 'package:edochub_b2b/screens/main_app_screen.dart';
import 'package:edochub_b2b/screens/splash_screen.dart';
import 'package:edochub_b2b/utils/theme_manager.dart';

// Define a professional green color palette
class AppColors {
  static const Color primaryGreen = Color(0xFF006D3B); // A deep, professional green
  static const Color accentGold = Color(0xFFE3B341); // A warm, inviting accent

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkCard = Color(0xFF1E1E1E);
  static const Color textWhite = Color(0xFFE0E0E0);
  static const Color textGreyDark = Color(0xFF888888);

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color textBlack = Color(0xFF212121);
  static const Color textGreyLight = Color(0xFF616161);
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
      bodyColor: AppColors.textWhite,
      displayColor: AppColors.textWhite,
    );

    return baseTheme.copyWith(
      primaryColor: AppColors.primaryGreen,
      scaffoldBackgroundColor: AppColors.darkBackground,
      cardColor: AppColors.darkCard,
      textTheme: textTheme,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryGreen,
        secondary: AppColors.accentGold,
        background: AppColors.darkBackground,
        surface: AppColors.darkCard,
        onPrimary: AppColors.textWhite,
        onSecondary: AppColors.textBlack,
        onBackground: AppColors.textWhite,
        onSurface: AppColors.textWhite,
        error: Colors.redAccent,
      ),
    );
  }

  ThemeData _buildLightTheme(BuildContext context) {
    final baseTheme = ThemeData.light();
    final textTheme = GoogleFonts.interTextTheme(baseTheme.textTheme).apply(
      bodyColor: AppColors.textBlack,
      displayColor: AppColors.textBlack,
    );

    return baseTheme.copyWith(
      primaryColor: AppColors.primaryGreen,
      scaffoldBackgroundColor: AppColors.lightBackground,
      cardColor: AppColors.lightCard,
      textTheme: textTheme,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryGreen,
        secondary: AppColors.accentGold,
        background: AppColors.lightBackground,
        surface: AppColors.lightCard,
        onPrimary: Colors.white,
        onSecondary: AppColors.textBlack,
        onBackground: AppColors.textBlack,
        onSurface: AppColors.textBlack,
        error: Colors.redAccent,
      ),
    );
  }
}