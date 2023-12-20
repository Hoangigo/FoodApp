import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/providers/userProvider.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key, required this.onSelectScreen});
  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return user.when(
        data: (data) => Drawer(
              child: Column(
                children: [
                  DrawerHeader(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primaryContainer,
                        Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                              50), // Adjust the radius to your preference
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    Colors.grey, // Set the color of the border
                                width: 2, // Set the width of the border
                              ),
                            ),
                            child: Image.network(
                              data.imageUrl,
                              width: 75, // Set width as needed
                              height: 75, // Set height as needed
                              fit: BoxFit
                                  .cover, // Adjust the image fit as needed
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Text(data.email,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                      ],
                    ),
                  ),
                  ListTile(
                      leading: Icon(
                        Icons.restaurant,
                        size: 26,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      onTap: () {
                        onSelectScreen('meals');
                      },
                      title: Text(
                        'Meals',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 24),
                      )),
                  ListTile(
                      leading: Icon(
                        Icons.settings,
                        size: 26,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      onTap: () {
                        onSelectScreen('filters');
                      },
                      title: Text(
                        'Filters',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 24),
                      )),
                  ListTile(
                      leading: Icon(
                        Icons.message,
                        size: 26,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      onTap: () {
                        onSelectScreen('messages');
                      },
                      title: Text(
                        'Messages',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 24),
                      ))
                ],
              ),
            ),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
        error: (error, _) => Text('Error: $error'));
  }
}
