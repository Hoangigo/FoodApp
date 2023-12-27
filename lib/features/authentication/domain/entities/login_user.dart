import 'package:equatable/equatable.dart';

class LogInUser extends Equatable {
  const LogInUser({
    required this.email,
    required this.imageUrl,
    required this.username,
  });

  final String email;
  final String imageUrl;
  final String username;
  String get getUserName => username;

  String get getEmail => email;

  String get getImageUrl => imageUrl;

  @override
  List<Object?> get props => [email, username, imageUrl];
}
