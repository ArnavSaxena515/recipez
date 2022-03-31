// This screen is used to display all the meals belonging to a particular category. The category title is passed as an argument when this screen is pushed into the Navigator's stack

import 'package:flutter/material.dart';
import 'package:recipez/models/meal.dart';

import '../widgets/main_drawer.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  const CategoryMealsScreen({Key? key, required this.availableMeals, required this.setFilters}) : super(key: key);
  final List<Meal> availableMeals;
  static const routeName = '/category-meal'; //route name for this screen for the navigator set up
  final Function setFilters; // map of filters to adjust what meals should be visible across diff screens

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  void _removeMeal(String mealID) {
    setState(() => displayedMeals.removeWhere((meal) => meal.id == mealID)); //function to remove a particular meal temporarily from the list of displayed meals.
    // The meals are all reloaded once this particular screen is pushed back into the navigator stack
  }

  String? title = '', id = ''; //this is initialised with values later on whenever the dependencies of the state end up changing or being created
  List<Meal> displayedMeals =
      []; //list to store all the meals that should actually be displayed (some meals are removed from the available ones depending on the filters set
  bool _loadedInitialData =
      false; // bool variable to check if the state and data has been loaded intiallly at least once or not. if its not loaded (false) then we load the displayed meals list

  @override
  void didChangeDependencies() {
    if (!_loadedInitialData) {
      //if data has not been loaded even once, we enter the block
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>; //get the arguments that were passed in a map via the navigator when pushing this screen
      title = routeArgs['title'];
      id = routeArgs['id'];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(id);
      }).toList(); // from all the available meals (meals that still remain after filters), display those meals whose category matches the category which we are currently in
      _loadedInitialData = true; // to tell the app that the data has been loaded at least once
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      title: Text(title!),
    );
    return Scaffold(
      drawer: MainDrawer(
        appBarHeight: _appBar.preferredSize.height,
      ),
      appBar: _appBar,
      body: ListView.builder(
        //build a list of all meals available in this category
        itemBuilder: (categoriesMealScreenContext, index) {
          final Meal currentMeal = displayedMeals[index];
          return MealItem(
            imageUrl: currentMeal.imageUrl,
            complexity: currentMeal.complexity,
            affordability: currentMeal.affordability,
            duration: currentMeal.duration,
            title: displayedMeals[index].title,
            id: currentMeal.id,
            removeItem: _removeMeal,
            isFavourite: false,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
