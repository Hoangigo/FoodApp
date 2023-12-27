import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/features/authentication/domain/entities/login_user.dart';
import 'package:mealsapp/features/categories/domain/entities/meal_entity.dart';
import 'package:mealsapp/features/categories/presentation/pages/category.dart';
import 'package:mealsapp/features/categories/presentation/providers/filter_provider.dart';
import 'package:mealsapp/features/categories/presentation/widgets/meal.dart';
import 'package:mealsapp/features/chat/presentation/pages/chat.dart';
import 'package:mealsapp/widgets/main_drawer.dart';

class TabsWidget extends StatelessWidget {
  final AsyncValue<List<Meal>> mealsProvider;
  final AsyncValue<LogInUser> user;
  final Map<Filter, bool> activeFilters;
  final int currentIndex;
  final Function(int) onSelectPage;
  final List<Meal> favoriteMeals;

  const TabsWidget({
    super.key,
    required this.mealsProvider,
    required this.user,
    required this.activeFilters,
    required this.favoriteMeals,
    required this.currentIndex,
    required this.onSelectPage,
  });

  @override
  Widget build(BuildContext context) {
    return mealsProvider.when(
      data: (meals) {
        return Scaffold(
          appBar: AppBar(
            title: _buildTitle(),
            actions: _buildActions(),
          ),
          drawer: const MainDrawer(),
          body: _buildBody(meals),
          bottomNavigationBar: BottomNavigationBar(
            onTap: onSelectPage,
            currentIndex: currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.set_meal),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Messages',
              ),
            ],
          ),
        );
      },
      error: (error, _) => Text('Error: $error'),
      loading: () => const CircularProgressIndicator(),
    );
  }

  Widget _buildTitle() {
    if (currentIndex == 1) {
      return const Text('Favorites');
    } else if (currentIndex == 2) {
      return const Text('Messages');
    }
    return const Text('Categories');
  }

  List<Widget> _buildActions() {
    return [
      user.when(
        data: (userData) {
          return Text(
            userData.username,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          );
        },
        error: (error, _) => Text('Error: $error'),
        loading: () => const CircularProgressIndicator(),
      ),
      IconButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
        },
        icon: const Icon(Icons.exit_to_app),
      ),
    ];
  }

  Widget _buildBody(List<Meal> meals) {
    if (currentIndex == 1) {
      return MealScreen(meals: favoriteMeals);
    } else if (currentIndex == 2) {
      return const ChatScreen();
    }
    return CategoriesScreen(meals: meals);
  }
}
