
import 'package:dio/dio.dart';
import 'package:edochub_b2b/utils/api_endpoints.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Response> login(String email, String password) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      return response;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  Future<Response> register(String name, String email, String password) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
      return response;
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }

  Future<dynamic> get(String endpoint) async {
    try {
      final response = await _dio.get('${ApiEndpoints.baseUrl}/$endpoint');
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch data from $endpoint: $e');
    }
  }
}
