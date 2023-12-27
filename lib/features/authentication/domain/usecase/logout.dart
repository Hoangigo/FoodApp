import 'package:mealsapp/features/authentication/domain/repositories/auth_repositories.dart';

class Logout {
  final AuthRepository authRepository;
  Logout({required this.authRepository});
  Future<void> logOut() {
    return authRepository.logOut();
  }
}
