import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/providers/categoriesProvider.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class MultiSelectDropdown extends ConsumerWidget {
  final List<String> selectedCategories = [];
  final List<String> categories = [
    'c1',
    'c2',
    'c3',
    'c4',
    'c5',
    'c6',
    'c7',
    'c8',
    'c9',
    'c10',
  ];

  MultiSelectDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MultiSelectDialogField(
      items: categories
          .map((category) => MultiSelectItem<String>(category, category))
          .toList(),
      listType: MultiSelectListType.CHIP,
      selectedColor: Colors.blue,
      buttonText: const Text(
        'Select Categories',
        style: TextStyle(color: Colors.white),
      ),
      itemsTextStyle: const TextStyle(color: Colors.white),
      onConfirm: (values) {
        ref
            .read(selectedCategoriesProvider.notifier)
            .setSelectedCategories(Set<String>.from(values));
      },
    );
  }
}
