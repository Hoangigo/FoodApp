import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/features/categories/data/datasources/RemoteDataSource.dart';
import 'package:mealsapp/features/categories/data/repositories/remote_repository.dart';

final repositoryProvider = Provider<RemoteRepository>((ref) {
  final dataSource = RemoteDataSource(
      firestore: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance,
      storage: FirebaseStorage.instance);
  return RemoteRepository(dataSource: dataSource);
});
