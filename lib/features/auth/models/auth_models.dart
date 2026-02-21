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
  final String? role;
  final String? firstName;
  final String? lastName;

  AuthData({
    this.accessToken,
    this.refreshToken,
    this.id,
    this.role,
    this.firstName,
    this.lastName,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      id: json['id'],
      role: json['role'],
      firstName: json['firstName'],
      lastName: json['lastName'],
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
