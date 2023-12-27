import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/features/categories/presentation/providers/remote_provider.dart';
import 'package:mealsapp/features/chat/domain/entities/chat_entiy.dart';

class NewMessage extends ConsumerStatefulWidget {
  const NewMessage({super.key});

  @override
  ConsumerState<NewMessage> createState() {
    return _NewMessage();
  }
}

class _NewMessage extends ConsumerState<NewMessage> {
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
    Chat chat = Chat(enteredText, Timestamp.now());
    final repository = ref.watch(repositoryProvider);
    await repository.addChat(chat);
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
              fillColor: Colors.white,
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
