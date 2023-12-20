import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mealsapp/auth/screen.dart/auth.dart';
import 'package:mealsapp/auth/screen.dart/splash.dart';
import 'package:mealsapp/screens/tabscreen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'config/firebase_options.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  /*
  final result = await storeCategoriesInFirestore();
  final result2 = await storeMealsInFirestore();
  print(result);
  print(result2);*/
  runApp(const ProviderScope(child: App()));
}
/*
Future<bool> storeCategoriesInFirestore() async {
  final CollectionReference categoriesRef =
      FirebaseFirestore.instance.collection('categories');

  for (var category in availableCategories) {
    await categoriesRef.doc(category.id).set({
      'title': category.title,
      'color': category.color.value,
      'id': category.id,
    });
  }
  return true;
}

Future<bool> storeMealsInFirestore() async {
  final CollectionReference mealsRef =
      FirebaseFirestore.instance.collection('meals');

  for (var meal in dummyMeals) {
    await mealsRef.doc(meal.id).set({
      'id': meal.id,
      'categories': meal.categories,
      'title': meal.title,
      'affordability': meal.affordability.name,
      'complexity': meal.complexity.name,
      'imageUrl': meal.imageUrl,
      'duration': meal.duration,
      'ingredients': meal.ingredients,
      'steps': meal.steps,
      'isGlutenFree': meal.isGlutenFree,
      'isVegan': meal.isVegan,
      'isVegetarian': meal.isVegetarian,
      'isLactoseFree': meal.isLactoseFree,
    });
  }
  return true;
}*/

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: theme,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }
            if (snapshot.hasData) {
              return const TabScreen();
            }
            return const AuthScreen();
          },
        ));
  }
}
