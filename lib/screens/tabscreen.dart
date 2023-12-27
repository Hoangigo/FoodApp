import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/features/authentication/presentation/providers/userProvider.dart';
import 'package:mealsapp/features/categories/presentation/providers/favorite_meal_provider.dart';

import 'package:mealsapp/features/categories/presentation/providers/filter_provider.dart';
import 'package:mealsapp/features/categories/presentation/providers/meal_provider.dart';
import 'package:mealsapp/widgets/tabs.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _TabScreen();
  }
}

class _TabScreen extends ConsumerState<TabScreen> {
  int index = 0;
  void _selectPage(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final activeFilters = ref.watch(filterProvider);
    final mealsProvider = ref.watch(mealsStreamProvider);
    final user = ref.watch(userProvider);
    final favoriteMeals = ref.watch(favoriteMealsProvider);

    return TabsWidget(
      mealsProvider: mealsProvider,
      activeFilters: activeFilters,
      favoriteMeals: favoriteMeals,
      user: user,
      currentIndex: index,
      onSelectPage: _selectPage,
    );
  }
}
