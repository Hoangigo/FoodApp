import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/models/category.dart';
import 'package:mealsapp/models/meal.dart';
import 'package:mealsapp/providers/categoriesProvider.dart';
import 'package:mealsapp/screens/mealscreen.dart';

class CategoryGridItem extends ConsumerWidget {
  const CategoryGridItem(
      {super.key, required this.category, required this.meals});
  final Category category;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
        onTap: () {
          final filteredMeals = meals
              .where((meal) => meal.categories.contains(category.id))
              .toList();
          ref.read(selectedCategoryProvider.notifier).setCategory(category);
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => MealScreen(
                      title: category.title,
                      meals: filteredMeals,
                    )),
          );
        },
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(colors: [
                category.color.withOpacity(0.55),
                category.color.withOpacity(0.9),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: Text(
            category.title,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ));
  }
}
