//This is a screen to display all the meals that the user marked as favorite

import 'package:flutter/material.dart';
import 'package:recipez/models/favorites.dart';
import 'package:recipez/models/meal.dart';
import 'package:recipez/widgets/meal_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key, required this.availableMeals}) : super(key: key);
  final List<Meal> availableMeals; //list to store the meals that are available depending on the status of the filters

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {


  void _removeMeal(String mealID) {
    setState(() => _favMeals.removeWhere((meal) => meal.id == mealID));
  } //function to remove a meal from the list of meals being displayed. The meals are reloaded again if this screen is pushed back on to the navigator stack


  @override
  void initState() {
    getFavorites();
    super.initState();
  }

  List<Meal> _favMeals = [];

  void getFavorites() async { // async fxn to populate _favMeals list with all the meals that were marked as favorite by the user and stored in local shared preferences
    Favorites favorites = Favorites(prefs: await SharedPreferences.getInstance());
    List<String> storedFavorites = favorites.getFavoriteIDs(); //Fetches the IDs of all the favorite meals using the favorites object

    setState(() {
      _favMeals = widget.availableMeals.where((element) {
        return storedFavorites.contains(element.id);
      }).toList(); //function to add all those meals in_favMeals whose IDs are in the storeFavorites list
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView.builder(
        itemBuilder: (categoriesMealScreenContext, index) {
          final Meal currentMeal = _favMeals[index];
          return MealItem(
            imageUrl: currentMeal.imageUrl,
            complexity: currentMeal.complexity,
            affordability: currentMeal.affordability,
            duration: currentMeal.duration,
            title: _favMeals[index].title,
            id: currentMeal.id,
            removeItem: _removeMeal,
            isFavourite: false,
          );
        },
        itemCount: _favMeals.length,
      ),
    );
  }
}
