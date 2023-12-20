import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/screens/chat.dart';
import 'package:mealsapp/providers/favorite_meals_provider.dart';
import 'package:mealsapp/providers/filter_provider.dart';
import 'package:mealsapp/providers/mealsprovider.dart';
import 'package:mealsapp/providers/userProvider.dart';
import 'package:mealsapp/screens/categoriesscreen.dart';
import 'package:mealsapp/screens/filter.dart';
import 'package:mealsapp/screens/mealscreen.dart';
import 'package:mealsapp/widgets/main_drawer.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _TabScreen();
  }
}

class _TabScreen extends ConsumerState<TabScreen> {
  int index = 0;
  void _selectPage(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  void setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
    } else if (identifier == 'messages') {
      await Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => const ChatScreen(
                title: 'Messages',
              )));
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final activeFilters = ref.watch(filterProvider);
    final mealsProvider = ref.watch(mealsStreamProvider);
    return mealsProvider.when(
        data: (meals) {
          final availableMeals = meals.where((meal) {
            if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
              return false;
            }
            if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
              return false;
            }
            if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
              return false;
            }
            if (activeFilters[Filter.vegan]! && !meal.isVegan) {
              return false;
            }
            return true;
          }).toList();
          String activePageTitle = 'Categories';
          Widget activePage = CategoriesScreen(
            meals: availableMeals,
          );
          if (index == 1) {
            final favoriteMeals = ref.watch(favoriteMealsProvider);
            activePage = MealScreen(meals: favoriteMeals);
            activePageTitle = 'Favorites';
          } else if (index == 2) {
            activePage = const ChatScreen();
            activePageTitle = 'Messages';
          }
          final user = ref.watch(userProvider);
          return Scaffold(
            appBar: AppBar(
              title: Text(activePageTitle),
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
                      FirebaseAuth.instance.signOut();
                    },
                    icon: const Icon(Icons.exit_to_app))
              ],
            ),
            body: activePage,
            drawer: MainDrawer(
              onSelectScreen: setScreen,
            ),
            bottomNavigationBar: BottomNavigationBar(
                onTap: _selectPage,
                currentIndex: index,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.set_meal), label: 'Categories'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.star), label: 'Favories'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.chat), label: 'Messages'),
                ]),
          );
        },
        error: (error, _) => Text('Error: $error'),
        loading: () => const CircularProgressIndicator());
  }
}
