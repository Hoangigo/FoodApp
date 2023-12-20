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
