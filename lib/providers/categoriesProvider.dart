import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/models/category.dart';

final categoriesProvider = StreamProvider.autoDispose<List<Category>>((ref) {
  final firestore = FirebaseFirestore.instance;
  final collection = firestore.collection('categories');
  return collection.snapshots().map((querySnapshot) {
    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      return Category.fromJson(data);
    }).toList();
  });
});
final selectedCategoriesProvider =
    StateNotifierProvider<SelectedCategoriesNotifier, Set<String>>((ref) {
  return SelectedCategoriesNotifier();
});

class SelectedCategoriesNotifier extends StateNotifier<Set<String>> {
  SelectedCategoriesNotifier() : super(<String>{});

  void setSelectedCategories(Set<String> selectedCategories) {
    state = selectedCategories;
  }

  void addSelectedCategory(String category) {
    state = {...state, category};
  }

  void removeSelectedCategory(String category) {
    state = {...state}..remove(category);
  }
}

class SelectedCategory extends StateNotifier<Category?> {
  SelectedCategory() : super(null);

  void setCategory(Category category) {
    state = category;
  }
}

final selectedCategoryProvider =
    StateNotifierProvider<SelectedCategory, Category?>((ref) {
  return SelectedCategory();
});
