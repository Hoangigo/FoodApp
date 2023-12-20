import 'package:flutter/material.dart';

class Category {
  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange,
  });
  factory Category.fromJson(Map<String, dynamic> data) {
    return Category(
      id: data['id'],
      title: data['title'],
      color: Color(data['color'] as int),
    );
  }

  final String id;
  final String title;
  final Color color;
}
