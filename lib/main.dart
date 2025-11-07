import 'package:edochub_b2b/screens/login_screen.dart';
import 'package:edochub_b2b/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:edochub_b2b/screens/main_app_screen.dart';
import 'package:edochub_b2b/screens/splash_screen.dart';
import 'package:edochub_b2b/utils/theme_manager.dart';

// Define a professional green color palette
class AppColors {
  static const Color primaryGreen = Color(0xFF4C6A4E); // A warm, earthy green
  static const Color accentGold = Color(0xFFDDAA55); // A warm, honey gold

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF1B1A17); // A deep, warm brown
  static const Color darkCard = Color(0xFF2A2924);
  static const Color textWhite = Color(0xFFE0E0E0);
  static const Color textGreyDark = Color(0xFF888888);

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFFFF8E1); // A warm, creamy off-white
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
    const colorScheme = ColorScheme.dark(
      primary: AppColors.primaryGreen,
      secondary: AppColors.accentGold,
      surface: AppColors.darkBackground,
      onSurface: AppColors.textWhite,
      onPrimary: AppColors.textWhite,
      onSecondary: AppColors.textBlack,
      error: Colors.redAccent,
    );

    return baseTheme.copyWith(
      primaryColor: AppColors.primaryGreen,
      scaffoldBackgroundColor: AppColors.darkBackground,
      cardColor: AppColors.darkCard,
      textTheme: textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.textWhite,
        elevation: 0,
      ),
      colorScheme: colorScheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: AppColors.textWhite,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.accentGold,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.accentGold,
        foregroundColor: AppColors.textBlack,
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkCard,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.textWhite,
      ),
    );
  }

  ThemeData _buildLightTheme(BuildContext context) {
    final baseTheme = ThemeData.light();
    final textTheme = GoogleFonts.interTextTheme(baseTheme.textTheme).apply(
      bodyColor: AppColors.textBlack,
      displayColor: AppColors.textBlack,
    );
    const colorScheme = ColorScheme.light(
      primary: AppColors.primaryGreen,
      secondary: AppColors.accentGold,
      surface: AppColors.lightBackground,
      onSurface: AppColors.textBlack,
      onPrimary: Colors.white,
      onSecondary: AppColors.textBlack,
      error: Colors.redAccent,
    );

    return baseTheme.copyWith(
      primaryColor: AppColors.primaryGreen,
      scaffoldBackgroundColor: AppColors.lightBackground,
      cardColor: AppColors.lightCard,
      textTheme: textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightBackground,
        foregroundColor: AppColors.textBlack,
        elevation: 0,
      ),
      colorScheme: colorScheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: Colors.white,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryGreen,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.accentGold,
        foregroundColor: AppColors.textBlack,
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightCard,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.textBlack,
      ),
    );
  }
}