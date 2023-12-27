import 'package:mealsapp/features/categories/domain/entities/meal_entity.dart';

class MealModel extends Meal {
  const MealModel(
      {required super.id,
      required super.categories,
      required super.title,
      required super.imageUrl,
      required super.ingredients,
      required super.steps,
      required super.duration,
      required super.complexity,
      required super.affordability,
      required super.isGlutenFree,
      required super.isLactoseFree,
      required super.isVegan,
      required super.isVegetarian});
}
