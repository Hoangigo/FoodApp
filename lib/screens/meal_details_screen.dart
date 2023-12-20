import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/models/meal.dart';
import 'package:mealsapp/providers/favorite_meals_provider.dart';
import 'package:mealsapp/providers/mealsprovider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });
  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(mealsStreamProvider);
    return favoriteMeals.when(
        data: (meals) {
          final isFavoriteMeal = meals.contains(meal);
          return Scaffold(
              appBar: AppBar(
                title: Text(meal.title),
                actions: [
                  IconButton(
                      onPressed: () {
                        final isFavorite = ref
                            .read(favoriteMealsProvider.notifier)
                            .toggleMealFavoriteMeal(meal);
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(!isFavorite
                                ? 'Recipe has been add to Favorites'
                                : 'Recipe is deleted from Favorites'),
                          ),
                        );
                      },
                      icon:
                          Icon(isFavoriteMeal ? Icons.star : Icons.star_border))
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.network(
                      meal.imageUrl,
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Ingredients',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 14),
                    for (final ingredient in meal.ingredients)
                      Text(
                        ingredient,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),
                    const SizedBox(height: 24),
                    Text(
                      'Steps',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 14),
                    for (final step in meal.steps)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Text(
                          step,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                      ),
                  ],
                ),
              ));
        },
        error: (error, _) => Text('Error: $error'),
        loading: () => const CircularProgressIndicator());
  }
}
