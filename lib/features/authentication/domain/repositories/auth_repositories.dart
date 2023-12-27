import 'dart:io';

import 'package:mealsapp/features/authentication/domain/entities/login_user.dart';

abstract class AuthRepository {
  Future<void> submitUserCredentials(
    String enteredEmail,
    String enteredPassword,
    String enteredUserName,
    File? selectedImage,
    bool isLogin,
  );
  Future<void> logOut();
  Stream<LogInUser> getUser();
}
