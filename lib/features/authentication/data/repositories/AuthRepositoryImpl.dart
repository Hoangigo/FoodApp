import 'dart:io';

import 'package:mealsapp/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:mealsapp/features/authentication/domain/entities/login_user.dart';
import 'package:mealsapp/features/authentication/domain/repositories/auth_repositories.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource dataSource;

  AuthRepositoryImpl({
    required this.dataSource,
  });

  @override
  Stream<LogInUser> getUser() {
    return dataSource.getUser();
  }

  @override
  Future<void> logOut() {
    return dataSource.logOut();
  }

  @override
  Future<void> submitUserCredentials(
      String enteredEmail,
      String enteredPassword,
      String enteredUserName,
      File? selectedImage,
      bool isLogin) {
    return dataSource.submitUserCredentials(
        enteredEmail, enteredPassword, enteredUserName, selectedImage, isLogin);
  }
}
