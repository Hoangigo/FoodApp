import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mealsapp/features/categories/data/models/category_model.dart';
import 'package:mealsapp/features/categories/data/models/meal_model.dart';
import 'package:mealsapp/features/categories/domain/entities/meal_entity.dart';
import 'package:mealsapp/features/chat/domain/entities/chat_entiy.dart';

class RemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final FirebaseStorage storage;

  RemoteDataSource({
    required this.firestore,
    required this.auth,
    required this.storage,
  });
  Stream<List<CategoryModel>> getCategories() {
    final collection = firestore.collection('categories');
    return collection.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return CategoryModel.fromJson(data);
      }).toList();
    });
  }

  Stream<List<MealModel>> getMeals() {
    final firestore = FirebaseFirestore.instance;
    final collection = firestore.collection('meals');

    return collection.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return MealModel(
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
  }

  Future<void> addMeal(Meal meal) async {
    try {
      String fixedAffordability = meal.affordability.toString().split('.')[1];
      String fixedComplexity = meal.complexity.toString().split('.')[1];

      await firestore.collection('meals').add({
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

  Future<void> addChat(Chat chat) async {
    final userData =
        await firestore.collection('users').doc(chat.user.uid).get();
    FirebaseFirestore.instance.collection('chat').add({
      'message': chat.message,
      'userid': chat.user.uid,
      'createdAt': Timestamp.now(),
      'userName': userData.data()!['username'],
      'userImage': userData.data()!['image_url'],
    });
  }
}
