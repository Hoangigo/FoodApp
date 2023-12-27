import 'package:mealsapp/features/authentication/domain/entities/login_user.dart';

class AuthUserModel extends LogInUser {
  const AuthUserModel(
      {required super.email, required super.imageUrl, required super.username});
  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      email: json['email'] ?? '',
      imageUrl: json['image_url'] ?? '',
      username: json['username'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {'email': email, 'image_url': imageUrl, 'username': username};
  }
}
