import 'dart:ui';

import 'package:mealsapp/features/categories/domain/entities/category_entity.dart';

class CategoryModel extends Category {
  const CategoryModel(
      {required super.id, required super.title, required super.color});
  factory CategoryModel.fromJson(Map<String, dynamic> data) {
    return CategoryModel(
      id: data['id'],
      title: data['title'],
      color: Color(data['color'] as int),
    );
  }
}
