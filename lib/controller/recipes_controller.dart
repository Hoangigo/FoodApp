import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealsapp/models/meal.dart';
import 'package:mealsapp/providers/mealsprovider.dart';

class MealController {
  Future<void> addMeal(Meal meal) async {
    try {
      String fixedAffordability = meal.affordability.toString().split('.')[1];
      String fixedComplexity = meal.complexity.toString().split('.')[1];

      await FirebaseFirestore.instance.collection('meals').add({
        'affordability': fixedAffordability,
        'categories': meal.categories,
        'complexity': fixedComplexity,
        'duration': meal.duration,
        'id': meal.id,
        'ingredients': meal.ingredients,
        'steps': meal.steps,
        'isGlutenFree': meal.isGlutenFree,
        'isLactoseFree': meal.isLactoseFree,
        'isVegetarian': meal.isVegetarian,
        'isVegan': meal.isVegan,
        'imageUrl': meal.imageUrl,
        'title': meal.title,
      });
    } catch (error) {
      print('Error adding meal: $error');
    }
  }
}
