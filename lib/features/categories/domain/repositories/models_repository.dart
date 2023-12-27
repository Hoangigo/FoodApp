import 'package:mealsapp/features/categories/domain/entities/category_entity.dart';
import 'package:mealsapp/features/categories/domain/entities/meal_entity.dart';
import 'package:mealsapp/features/chat/domain/entities/chat_entiy.dart';

abstract class ModelRepository {
  Stream<List<Category>> getCategories();
  Stream<List<Meal>> getMeals();
  Future<void> addMeal(Meal meal);
  Future<void> addChat(Chat chat);
  Future<void> getChats();
}
