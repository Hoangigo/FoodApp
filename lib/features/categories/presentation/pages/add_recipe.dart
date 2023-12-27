import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/features/categories/domain/entities/meal_entity.dart';
import 'package:mealsapp/features/categories/presentation/providers/categoryProvider.dart';
import 'package:mealsapp/features/categories/presentation/providers/remote_provider.dart';
import 'package:mealsapp/features/categories/presentation/widgets/multi_select_drop_down.dart';
import 'package:uuid/uuid.dart';

import '../../../authentication/presentation/widgets/imagePicker.dart';

class AddRecipe extends ConsumerStatefulWidget {
  const AddRecipe({super.key});

  @override
  ConsumerState<AddRecipe> createState() {
    return _AddRecipe();
  }
}

class _AddRecipe extends ConsumerState<AddRecipe> {
  var titleController = TextEditingController();
  var durationController = TextEditingController();

  final _form = GlobalKey<FormState>();
  File? _selectedImage;
  Complexity? _complexity;
  Affordability? _affordability;
  final List<String> _ingredients = [''];
  final List<String> _steps = [''];
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;

  @override
  void dispose() {
    titleController.dispose();
    durationController.dispose();

    super.dispose();
  }

  String generateUniqueId() {
    const uuid = Uuid();
    return uuid.v4();
  }

  void _submit(BuildContext context) async {
    final chosenCategories = ref.watch(selectedCategoriesProvider);

    final isValid = _form.currentState!.validate();

    if (!isValid ||
        _complexity == null ||
        _selectedImage == null ||
        _affordability == null ||
        _ingredients.isEmpty ||
        titleController.text.trim().isEmpty ||
        durationController.text.trim().isEmpty ||
        _steps.isEmpty) {
      return;
    }

    _form.currentState!.save();

    final newMeal = Meal(
        id: generateUniqueId(),
        categories: chosenCategories.toList(),
        title: titleController.text,
        imageUrl: _selectedImage!.path,
        ingredients: _ingredients,
        steps: _steps,
        duration: int.parse(durationController.text),
        complexity: _complexity!,
        affordability: _affordability!,
        isGlutenFree: _isGlutenFree,
        isLactoseFree: _isLactoseFree,
        isVegan: _isVegan,
        isVegetarian: _isVegetarian);
    final repository = ref.watch(repositoryProvider);

    await repository.addMeal(newMeal);
    titleController.clear();
    durationController.clear();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Add Recipe',
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
      )),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
            child: Form(
          key: _form,
          child: Column(
            children: [
              const Text('Title',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Title cannot be empty';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter the title',
                  hintStyle: TextStyle(color: Colors.grey),
                  labelText: 'Title',
                ),
              ),
              const SizedBox(height: 30),
              UserImagePicker(pickImage: (pickedImage) {
                _selectedImage = pickedImage;
              }),
              const SizedBox(height: 8),
              MultiSelectDropdown(),
              const SizedBox(height: 8),
              const Text('Ingredients',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _ingredients.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'ingredient cannot be empty'; // Error message when the field is empty
                            }
                            return null; // Return null when the input is valid
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter ingredient ${index + 1}',
                            hintStyle: const TextStyle(color: Colors.grey),
                            labelText: 'Ingredient ${index + 1}',
                            labelStyle: const TextStyle(color: Colors.white),
                          ),
                          onChanged: (value) {
                            _ingredients[index] = value;
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            _ingredients.add('');
                          });
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 8),
              const Text('Steps',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _steps.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Step cannot be empty'; // Error message when the field is empty
                            }
                            return null; // Return null when the input is valid
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter step ${index + 1}',
                            hintStyle: const TextStyle(color: Colors.grey),
                            labelText: 'Step ${index + 1}',
                            labelStyle: const TextStyle(color: Colors.white),
                          ),
                          onChanged: (value) {
                            _steps[index] = value;
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            _steps.add('');
                          });
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: durationController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Duration cannot be empty';
                  }
                  return null;
                },
                decoration:
                    const InputDecoration(labelText: 'Duration (minutes)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              const Text('Complexity',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              const SizedBox(height: 16),
              Wrap(
                spacing: 20,
                children: [
                  for (Complexity value in Complexity.values)
                    ChoiceChip(
                      label: Text(
                        value.toString().split('.').last,
                        style: const TextStyle(color: Colors.white),
                      ),
                      selected: _complexity == value,
                      onSelected: (isSelected) {
                        if (isSelected) {
                          setState(() {
                            _complexity = value;
                          });
                        }
                      },
                    ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Affordability',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 20,
                children: [
                  for (final affordability in Affordability.values)
                    ChoiceChip(
                      label: Text(
                        affordability.toString().split('.').last,
                        style: const TextStyle(color: Colors.white),
                      ),
                      selected: _affordability == affordability,
                      onSelected: (isSelected) {
                        if (isSelected) {
                          setState(() {
                            _affordability = affordability;
                          });
                        }
                      },
                    ),
                ],
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: const Text('Gluten-Free'),
                value: _isGlutenFree,
                onChanged: (newValue) {
                  setState(() {
                    _isGlutenFree = newValue ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Lactose-Free'),
                value: _isLactoseFree,
                onChanged: (newValue) {
                  setState(() {
                    _isLactoseFree = newValue ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Vegan'),
                value: _isVegan,
                onChanged: (newValue) {
                  setState(() {
                    _isVegan = newValue ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Vegetarian'),
                value: _isVegetarian,
                onChanged: (newValue) {
                  setState(() {
                    _isVegetarian = newValue ?? false;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  _submit(context);
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
