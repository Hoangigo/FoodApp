import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/models/login_user.dart';

final userProvider = StreamProvider.autoDispose<LogInUser>((ref) {
  final firestore = FirebaseFirestore.instance;
  final collection = firestore.collection('users');
  final userId = FirebaseAuth.instance.currentUser?.uid;
  return collection.doc(userId).snapshots().map((docSnapshot) {
    if (docSnapshot.exists) {
      return LogInUser.fromJson(docSnapshot.data() as Map<String, dynamic>);
    } else {
      return const LogInUser(
          email: 'email',
          imageUrl:
              'https://cdn.pixabay.com/photo/2013/07/13/12/07/avatar-159236_640.png',
          username: 'username');
    }
  });
});
