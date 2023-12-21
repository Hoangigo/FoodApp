import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/models/meal.dart';

final mealsStreamProvider = StreamProvider<List<Meal>>((ref) {
  final firestore = FirebaseFirestore.instance;
  final collection = firestore.collection('meals');

  return collection.snapshots().map((querySnapshot) {
    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      return Meal(
        id: doc.id,
        categories: List<String>.from(data['categories'] ?? []),
        title: data['title'] ?? '',
        imageUrl: data['imageUrl'] ?? '',
        ingredients: List<String>.from(data['ingredients'] ?? []),
        steps: List<String>.from(data['steps'] ?? []),
        duration: data['duration'] ?? 0,
        complexity: Complexity.values.firstWhere(
          (e) => e.toString().split('.').last == data['complexity'],
          orElse: () => Complexity.simple,
        ),
        affordability: Affordability.values.firstWhere(
          (e) => e.toString().split('.').last == data['affordability'],
          orElse: () => Affordability.affordable,
        ),
        isGlutenFree: data['isGlutenFree'] ?? false,
        isLactoseFree: data['isLactoseFree'] ?? false,
        isVegan: data['isVegan'] ?? false,
        isVegetarian: data['isVegetarian'] ?? false,
      );
    }).toList();
  });
});

class SelectedMeal extends StateNotifier<Meal?> {
  SelectedMeal() : super(null);
  void setMeal(Meal meal) {
    state = meal;
  }
}

final selectedMealProvider =
    StateNotifierProvider<SelectedMeal, Meal?>((ref) => SelectedMeal());
