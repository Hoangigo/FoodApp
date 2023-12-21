import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter { glutenFree, lactoseFree, vegan, vegetarian }

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });
  void setFilter(Filter filter, bool isActve) {
    state = {...state, filter: isActve};
  }
}

final filterProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());
