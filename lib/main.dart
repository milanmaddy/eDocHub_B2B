
import 'dart:async';

import 'package:edochub_b2b/screens/animated_splash_screen.dart';
import 'package:edochub_b2b/screens/location_handler_screen.dart';
import 'package:edochub_b2b/screens/login_screen.dart';
import 'package:edochub_b2b/screens/main_app_screen.dart';
import 'package:edochub_b2b/screens/registration_screen.dart';
import 'package:edochub_b2b/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      FlutterError.onError = (FlutterErrorDetails details) {
        debugPrint('Flutter Error: ${details.exceptionAsString()}');
        debugPrintStack(stackTrace: details.stack);
      };
      try {
        await dotenv.load(fileName: ".env");
      } catch (e) {
        debugPrint('Warning: Could not load .env file: $e');
      }
      runApp(const MyApp());
    },
    (Object error, StackTrace stackTrace) {
      debugPrint('Uncaught error: $error');
      debugPrintStack(stackTrace: stackTrace);
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eDoc Hub B2B',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFADD8E6),
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF483D8B),
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).primaryTextTheme),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const AnimatedSplashScreen(),
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/main': (context) => const MainAppScreen(),
        '/location':(context) => const LocationHandlerScreen(),
      },
    );
  }
}
