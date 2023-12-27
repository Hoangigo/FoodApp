import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Category extends Equatable {
  const Category({
    required this.id,
    required this.title,
    //required this.color = Colors.orange,
    required this.color,
  });

  final String id;
  final String title;
  final Color color;

  @override
  List<Object?> get props => [id, title, color];
}
