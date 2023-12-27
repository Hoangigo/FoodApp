import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mealsapp/features/authentication/data/models/auth_user_model.dart';
import 'package:mealsapp/features/authentication/domain/entities/login_user.dart';

import '../../domain/repositories/auth_repositories.dart';

class AuthRemoteDataSource implements AuthRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final FirebaseStorage storage;

  AuthRemoteDataSource({
    required this.firestore,
    required this.auth,
    required this.storage,
  });
  @override
  Future<void> submitUserCredentials(
    String enteredEmail,
    String enteredPassword,
    String enteredUserName,
    File? selectedImage,
    bool isLogin,
  ) async {
    try {
      if (isLogin) {
        await auth.signInWithEmailAndPassword(
            email: enteredEmail, password: enteredPassword);
      } else {
        final userCredentials = await auth.createUserWithEmailAndPassword(
            email: enteredEmail, password: enteredPassword);

        final storageRef = storage
            .ref()
            .child('user_images')
            .child('${userCredentials.user!.uid}.jpg');
        await storageRef.putFile(selectedImage!);
        final imageUrl = await storageRef.getDownloadURL();
        firestore.collection('users').doc(userCredentials.user!.uid).set({
          'username': enteredUserName,
          'email': userCredentials.user?.email,
          'image_url': imageUrl
        });
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {}
      print('Authentication failed');
    }
  }

  @override
  Future<void> logOut() {
    return auth.signOut();
  }

  @override
  Stream<LogInUser> getUser() {
    final userId = auth.currentUser?.uid;
    final collection = firestore.collection('users');

    return collection.doc(userId).snapshots().map((docSnapshot) {
      if (docSnapshot.exists) {
        return AuthUserModel.fromJson(
            docSnapshot.data() as Map<String, dynamic>);
      } else {
        return const LogInUser(
          email: 'email',
          imageUrl:
              'https://cdn.pixabay.com/photo/2013/07/13/12/07/avatar-159236_640.png',
          username: 'username',
        );
      }
    });
  }
}
