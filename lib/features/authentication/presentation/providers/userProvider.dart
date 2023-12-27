import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:mealsapp/features/authentication/data/repositories/AuthRepositoryImpl.dart';
import 'package:mealsapp/features/authentication/domain/entities/login_user.dart';

final userRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  final dataSource =
      AuthRemoteDataSource(firestore: firestore, auth: auth, storage: storage);
  return AuthRepositoryImpl(dataSource: dataSource);
});
final userProvider = StreamProvider.autoDispose<LogInUser>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return userRepository.getUser();
});
