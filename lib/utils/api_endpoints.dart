import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  // Use a default if BASE_URL is not set
  static final String baseUrl = dotenv.env['BASE_URL'] ?? 'https://api.example.com';

  static String get login => '$baseUrl/login';
  static String get register => '$baseUrl/register';
  static String get appointments => '$baseUrl/appointments';
}
