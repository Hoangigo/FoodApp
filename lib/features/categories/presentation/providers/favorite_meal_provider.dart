import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/features/categories/domain/entities/meal_entity.dart';

class FavoritiesMealNotifier extends StateNotifier<List<Meal>> {
  FavoritiesMealNotifier() : super([]);
  bool toggleMealFavoriteMeal(Meal meal) {
    final mealIsFavorite = state.contains(meal);
    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return true;
    } else {
      state = [...state, meal];
      return false;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoritiesMealNotifier, List<Meal>>(
        (ref) => FavoritiesMealNotifier());
