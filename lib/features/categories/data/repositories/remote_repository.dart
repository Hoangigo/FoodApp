import 'package:mealsapp/features/categories/data/datasources/RemoteDataSource.dart';
import 'package:mealsapp/features/categories/data/models/category_model.dart';
import 'package:mealsapp/features/categories/data/models/meal_model.dart';
import 'package:mealsapp/features/categories/domain/entities/meal_entity.dart';
import 'package:mealsapp/features/categories/domain/repositories/models_repository.dart';
import 'package:mealsapp/features/chat/domain/entities/chat_entiy.dart';

class RemoteRepository implements ModelRepository {
  final RemoteDataSource dataSource;

  RemoteRepository({required this.dataSource});
  @override
  Stream<List<CategoryModel>> getCategories() {
    return dataSource.getCategories();
  }

  @override
  Stream<List<MealModel>> getMeals() {
    return dataSource.getMeals();
  }

  @override
  Future<void> addMeal(Meal meal) {
    return dataSource.addMeal(meal);
  }

  @override
  Future<void> addChat(Chat chat) {
    // TODO: implement addChat
    throw UnimplementedError();
  }

  @override
  Future<void> getChats() {
    // TODO: implement getChats
    throw UnimplementedError();
  }
}
