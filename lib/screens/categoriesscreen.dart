import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/models/category.dart';
import 'package:mealsapp/models/meal.dart';
import 'package:mealsapp/providers/categoriesProvider.dart';
import 'package:mealsapp/screens/mealscreen.dart';
import 'package:mealsapp/widgets/categorygriditem.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key, required this.meals});
  final List<Meal> meals;
  void onSelectCategory(
      BuildContext context, Category category, List<Meal> meals) {
    final filteredMeals =
        meals.where((meal) => meal.categories.contains(category.id)).toList();
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => MealScreen(
                title: category.title,
                meals: filteredMeals,
              )),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    return categories.when(
        data: (categories) => Scaffold(
              body: GridView(
                padding: const EdgeInsets.all(24),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                children: [
                  for (final category in categories)
                    CategoryGridItem(
                      category: category,
                      onSelectCategory: () {
                        onSelectCategory(context, category, meals);
                      },
                    )
                ],
              ),
            ),
        error: (error, _) => Text('Error: $error'),
        loading: () => const CircularProgressIndicator());
  }
}
