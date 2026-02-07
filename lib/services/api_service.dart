
import 'package:dio/dio.dart';
import 'package:edochub_b2b/utils/api_endpoints.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  void setAuthToken(String? token) {
    if (token == null || token.isEmpty) {
      _dio.options.headers.remove('Authorization');
    } else {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

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
      final response = await _dio.get('/$endpoint');
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch data from $endpoint: $e');
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/$endpoint', data: data);
      return response.data;
    } catch (e) {
      throw Exception('Failed to post to $endpoint: $e');
    }
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('/$endpoint', data: data);
      return response.data;
    } catch (e) {
      throw Exception('Failed to update $endpoint: $e');
    }
  }
}
