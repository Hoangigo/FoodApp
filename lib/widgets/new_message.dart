import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() {
    return _NewMessage();
  }
}

class _NewMessage extends State<NewMessage> {
  var messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void submit() async {
    final enteredText = messageController.text;
    if (enteredText.trim().isEmpty) return;
    FocusScope.of(context).unfocus();
    messageController.clear();

    final user = FirebaseAuth.instance.currentUser!;

    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'message': enteredText,
      'userid': user.uid,
      'createdAt': Timestamp.now(),
      'userName': userData.data()!['username'],
      'userImage': userData.data()!['image_url'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white, // Background color of the TextField
              hintText: 'Enter your message',
              hintStyle: const TextStyle(
                  color: Colors.grey), // Style for the hint text
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            style: const TextStyle(color: Colors.white),
            controller: messageController,
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
          )),
          IconButton(onPressed: submit, icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
