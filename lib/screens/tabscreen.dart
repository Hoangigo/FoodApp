import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mealsapp/screens/chat.dart';
import 'package:mealsapp/providers/favorite_meals_provider.dart';
import 'package:mealsapp/providers/filter_provider.dart';
import 'package:mealsapp/providers/mealsprovider.dart';
import 'package:mealsapp/providers/userProvider.dart';
import 'package:mealsapp/screens/filter.dart';
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

  void setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
    } else if (identifier == 'messages') {
      await Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => const ChatScreen(
                title: 'Messages',
              )));
    }
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
