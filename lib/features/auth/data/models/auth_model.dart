// ignore_for_file: public_member_api_docs, sort_constructors_first
class AuthModel {
  final String accessToken;
  final String refreshToken;
  final String email;

  AuthModel({
    required this.accessToken,
    required this.refreshToken,
    required this.email,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      email: '');

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
        'refresh_token': refreshToken,
      };
}
