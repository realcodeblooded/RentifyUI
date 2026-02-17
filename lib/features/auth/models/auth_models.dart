class GeneralResponse {
  final bool success;
  final String message;
  final dynamic data;

  GeneralResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory GeneralResponse.fromJson(Map<String, dynamic> json) {
    return GeneralResponse(
      success: json['success'],
      message: json['message'] ?? '',
      data: json['data'],
    );
  }
}

class AuthData {
  final String? accessToken;
  final String? refreshToken;
  final String? id;

  AuthData({
    this.accessToken,
    this.refreshToken,
    this.id,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      id: json['id'],
    );
  }
}

class AuthRequest {
  final String email;
  final String password;

  AuthRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }
}
