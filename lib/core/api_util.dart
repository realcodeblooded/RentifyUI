import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiUtil {
  final String baseUrl = "http://localhost:3000/api";
  final storage = const FlutterSecureStorage();

  Future<Map<String, String>> _getHeaders() async {
    String? token = await storage.read(key: "token");
    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  Future<dynamic> get(String endpoint) async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse("$baseUrl$endpoint"),
      headers: headers,
    );
    return _handleResponse(response);
  }

  Future<dynamic> post(String endpoint,
      {required Map<String, dynamic> body}) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse("$baseUrl$endpoint"),
      headers: headers,
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<dynamic> put(String endpoint,
      {required Map<String, dynamic> body}) async {
    final headers = await _getHeaders();
    final response = await http.put(
      Uri.parse("$baseUrl$endpoint"),
      headers: headers,
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<dynamic> delete(String endpoint) async {
    final headers = await _getHeaders();
    final response = await http.delete(
      Uri.parse("$baseUrl$endpoint"),
      headers: headers,
    );
    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return jsonDecode(response.body);
    } else {
      String errorMessage = "Server Error: ${response.statusCode}";
      try {
        final body = jsonDecode(response.body);
        if (body is Map<String, dynamic> && body.containsKey('message')) {
          errorMessage = body['message'];
        }
      } catch (_) {
        // Fallback if parsing fails
        errorMessage += " ${response.body}";
      }
      throw Exception(errorMessage);
    }
  }
}
