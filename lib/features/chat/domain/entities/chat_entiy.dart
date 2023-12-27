import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Chat {
  final String message;
  final User user = FirebaseAuth.instance.currentUser!;
  final Timestamp createdAt;

  Chat(this.message, this.createdAt);
}
