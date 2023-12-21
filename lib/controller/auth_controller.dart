import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthController {
  final _firebase = FirebaseAuth.instance;
  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
  }

  Future<void> submitUserCredentials(
      String enteredEmail,
      String enteredPassword,
      String enteredUserName,
      File? selectedImage,
      bool isLogin,
      BuildContext context) async {
    try {
      if (isLogin) {
        await _firebase.signInWithEmailAndPassword(
            email: enteredEmail, password: enteredPassword);
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: enteredEmail, password: enteredPassword);

        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCredentials.user!.uid}.jpg');
        await storageRef.putFile(selectedImage!);
        final imageUrl = await storageRef.getDownloadURL();
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
          'username': enteredUserName,
          'email': userCredentials.user?.email,
          'image_url': imageUrl
        });
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {}
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Authentication failed')));
    }
  }
}
