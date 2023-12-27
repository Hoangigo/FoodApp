import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mealsapp/features/authentication/domain/repositories/auth_repositories.dart';

class Login {
  final AuthRepository authRepository;
  Login({required this.authRepository});
  Future<void> submitUserCredentials(
      String enteredEmail,
      String enteredPassword,
      String enteredUserName,
      File? selectedImage,
      bool isLogin,
      BuildContext context) {
    return authRepository.submitUserCredentials(
        enteredEmail, enteredPassword, enteredUserName, selectedImage, isLogin);
  }
}
