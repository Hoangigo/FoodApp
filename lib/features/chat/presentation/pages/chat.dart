import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/features/authentication/presentation/providers/userProvider.dart';
import 'package:mealsapp/features/chat/presentation/widgets/chat_message.dart';
import 'package:mealsapp/features/chat/presentation/widgets/new_message.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key, this.title});
  final String? title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    var defaultScreen = const Scaffold(
        body: Column(
      children: [
        Expanded(
          child: ChatMessage(),
        ),
        NewMessage(),
      ],
    ));
    if (title != null) {
      defaultScreen = Scaffold(
          appBar: AppBar(
            title: Text(title!),
            actions: [
              user.when(
                  data: (userData) {
                    return Text(
                      userData.username,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    );
                  },
                  error: (error, _) => Text('Error: $error'),
                  loading: () => const CircularProgressIndicator()),
              IconButton(
                  onPressed: () {
                    final userRepository = ref.watch(userRepositoryProvider);
                    userRepository.logOut();
                  },
                  icon: const Icon(Icons.exit_to_app))
            ],
          ),
          body: const Column(
            children: [
              Expanded(
                child: ChatMessage(),
              ),
              NewMessage(),
            ],
          ));
    }
    return defaultScreen;
  }
}
