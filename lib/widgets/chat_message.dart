import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mealsapp/widgets/message_bubble.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!chatSnapshot.hasData || chatSnapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No message found'));
          }
          if (chatSnapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          final loadedMessge = chatSnapshot.data!.docs;

          return ListView.builder(
              padding: const EdgeInsets.only(bottom: 40, left: 15, right: 15),
              reverse: true,
              itemCount: loadedMessge.length,
              itemBuilder: (ctx, index) {
                final chatMessage = loadedMessge[index].data();
                final nextMessage = index + 1 < loadedMessge.length
                    ? loadedMessge[index + 1].data()
                    : null;

                final currentMessageUserId = chatMessage['userid'];
                final nextMesageUserId =
                    nextMessage != null ? nextMessage['userid'] : null;

                final nextUserIsSame = nextMesageUserId == currentMessageUserId;
                if (nextUserIsSame) {
                  return MessageBubble.next(
                      message: chatMessage['message'],
                      isMe: user.uid == currentMessageUserId);
                } else {
                  return MessageBubble.first(
                      userImage: chatMessage['userImage'],
                      username: chatMessage['username'],
                      message: chatMessage['message'],
                      isMe: user.uid == currentMessageUserId);
                }
              });
        });
  }
}
