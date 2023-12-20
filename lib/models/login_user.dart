class LogInUser {
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
  factory LogInUser.fromJson(Map<String, dynamic> json) {
    return LogInUser(
      email: json['email'] ??
          '', // Replace 'id' with the actual field name from Firestore
      imageUrl: json['image_url'] ??
          '', // Replace 'name' with the actual field name from Firestore
      username: json['username'] ??
          0, // Replace 'age' with the actual field name from Firestore
    );
  }
}
