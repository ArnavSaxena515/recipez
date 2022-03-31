import 'package:flutter/material.dart';
import 'package:recipez/dummy_data.dart';
import 'package:recipez/models/meal.dart';
import 'package:recipez/screens/filters_screen.dart';
import 'package:recipez/theme_data.dart';
import './screens/categories_meal_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  //initial filter data for when the app starts. no filters are set by default

  void _setFilters(Map<String, bool> filterData) {
    //this is the fxn defined to control the status of the available filters and change them if they are set/unset by the user
    setState(() {
      _filters = filterData; // the arg passed to it contains an updated map of the filters as changed by the users.
      availableMeals = DUMMY_MEALS.where((meal) {
        //here the DUMMY_MEALS is traversed and if the meal is found to have data/features conflicting to that of any set filters, it is
        // not added to the list of available meals
        if (!meal.isGlutenFree && _filters['gluten'] as bool) {
          return false;
        }
        if (!meal.isVegetarian && _filters['vegetarian'] as bool) {
          return false;
        }
        if (!meal.isLactoseFree && _filters['lactose'] as bool) {
          return false;
        }
        if (!meal.isVegan && _filters['vegan'] as bool) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  List<Meal> availableMeals = DUMMY_MEALS;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipEZ',
      theme: ThemeData(
        canvasColor: canvasColor,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink).copyWith(secondary: Colors.amber),
        textTheme: ThemeData().textTheme.copyWith(
              bodyLarge: const TextStyle(
                color: Colors.black,
              ),
              bodySmall: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: 'RobotoCondensed',
                color: Colors.black,
              ),
              bodyMedium: const TextStyle(
                color: Colors.black,
              ),
              titleMedium: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'RobotoCondensed',
                color: Colors.black,
              ),
              titleLarge: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                fontFamily: 'RobotoCondensed',
                color: Colors.white,
              ),
            ),
      ),
      home: TabsScreen(
        availableMeals: availableMeals,
      ),
      routes: {
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(
              availableMeals: availableMeals,
              setFilters: _setFilters,
            ),
        MealDetails.routeName: (ctx) => MealDetails(),
        TabsScreen.routeName: (ctx) => TabsScreen(
              availableMeals: availableMeals,
            ),
        FiltersScreen.routeName: (ctx) => FiltersScreen(
              setFilters: _setFilters,
              filterData: _filters,
            ),
        // CategoriesScreen.routeName:(ctx)=>const CategoriesScreen()
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          return const CategoriesScreen();
        });
      },
    );
  }
}
//TODO serialise the model classes to make it possible to store recipe data in shared preferebces
//TODO with the serialised model classes, implement functionality to add more categories and features
//TODO Liked the simplicity and straightforwardness of the app
// The favorite thing is very useful and smart thing to add, knowing users like to see recipe once in a while without having pain to scroll whole catalog
//
// Obviously aesthetics are something which their is no roof bar for, more you learn, more better color palates as well as UI you can design
//
// Well the app and UI looks solid 7.5 for me
//
// Feedback i can give is only on content and not on development part xD
//
// I'd say make 4 bigger tiles (4 categories)- Started, Main Course, Dessert, Appetizer/Beverage something and then distribute contents respectively cause Meals category mei their is a lot of content which seems unorganized at first glance
