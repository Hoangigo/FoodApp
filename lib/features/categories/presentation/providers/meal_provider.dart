import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/features/categories/domain/entities/meal_entity.dart';
import 'package:mealsapp/features/categories/presentation/providers/remote_provider.dart';

final mealsStreamProvider = StreamProvider<List<Meal>>((ref) {
  final repository = ref.watch(repositoryProvider);
  return repository.getMeals();
});

class SelectedMeal extends StateNotifier<Meal?> {
  SelectedMeal() : super(null);
  void setMeal(Meal meal) {
    state = meal;
  }
}

final selectedMealProvider =
    StateNotifierProvider<SelectedMeal, Meal?>((ref) => SelectedMeal());
