import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/features/categories/data/models/category_model.dart';
import 'package:mealsapp/features/categories/domain/entities/category_entity.dart';
import 'package:mealsapp/features/categories/presentation/providers/remote_provider.dart';

final categoriesProvider =
    StreamProvider.autoDispose<List<CategoryModel>>((ref) {
  final repository = ref.watch(repositoryProvider);
  return repository.getCategories();
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
