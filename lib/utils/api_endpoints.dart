import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  static final String baseUrl = dotenv.env['BASE_URL']!;

  static final String login = '$baseUrl/login';
  static final String register = '$baseUrl/register';
  static final String appointments = '$baseUrl/appointments';
}
