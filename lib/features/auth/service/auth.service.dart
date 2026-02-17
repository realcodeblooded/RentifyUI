import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rentifyui/core/api_util.dart';
import 'package:rentifyui/features/auth/models/auth_models.dart';

class AuthService {
  final ApiUtil _apiUtil = ApiUtil();
  final storage = const FlutterSecureStorage();

  Future<void> login(String email, String password) async {
    try {
      final request = AuthRequest(email: email, password: password);
      final rawResponse =
          await _apiUtil.post("/auth/login", body: request.toJson());
      final response = GeneralResponse.fromJson(rawResponse);

      if (response.success && response.data != null) {
        final authData = AuthData.fromJson(response.data);

        if (authData.accessToken != null) {
          await storage.write(key: "token", value: authData.accessToken);

          if (authData.refreshToken != null) {
            await storage.write(
                key: "refreshToken", value: authData.refreshToken);
          }
          if (authData.id != null) {
            await storage.write(key: "userId", value: authData.id);
          }
        } else {
          throw Exception("Access token missing in response");
        }
      } else {
        throw Exception(
            response.message.isNotEmpty ? response.message : "Login failed");
      }
    } catch (e) {
      rethrow;
    }
  }
}
