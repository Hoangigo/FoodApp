import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/features/categories/domain/entities/meal_entity.dart';
import 'package:mealsapp/features/categories/presentation/providers/categoryProvider.dart';
import 'package:mealsapp/features/categories/presentation/widgets/category_grid_item.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key, required this.meals});
  final List<Meal> meals;

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
                      meals: meals,
                    )
                ],
              ),
            ),
        error: (error, _) => Text('Error: $error'),
        loading: () => const CircularProgressIndicator());
  }
}
