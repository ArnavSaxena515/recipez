//This is a screen used to display the details of a meal like its ingredients and steps to make

import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../models/favorites.dart';
import '../models/meal.dart';
import '../widgets/meal_detail_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class MealDetails extends StatefulWidget {
  static const routeName = "/meal-screen";

  List<String> _favMealIds = []; //used to maintain if a particular meal is favorite or not

  MealDetails({
    Key? key,
  }) : super(key: key);
  bool _isFavorite = false; //used to maintain the status of this meal. if its favorite, then its set to true

  @override
  State<MealDetails> createState() => _MealDetailsState();
}

class _MealDetailsState extends State<MealDetails> {
  void getFavorites() async {
    //method to populate favMealIDs with the list of meals that are marked as user's favorites
    final favorite = Favorites(prefs: await SharedPreferences.getInstance());
    setState(() {
      widget._favMealIds = favorite.getFavoriteIDs(); //set state called to populate the screen as soon as the favMeals get updated
      // with the necessary data. makes sure the data is displayed in the ui after the data is fetched from local shared preferences
    });
  }

  void writeFavorites() async {
    final favorite = Favorites(prefs: await SharedPreferences.getInstance());
    favorite.storeFavoritesToMemory(widget._favMealIds);
    //whenever the current meal is marked as favorite or not favorite, local storage must be updated with this fxn
  }

  @override
  void initState() {
    getFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final id = ModalRoute.of(context)?.settings.arguments as String;
    final Meal selectedMeal = DUMMY_MEALS.firstWhere((element) => element.id == id);

    widget._isFavorite = widget._favMealIds.contains(selectedMeal.id); //check if the current meal is a favorite or not. The icon for favorite is updated accordingly

    final AppBar appBar = AppBar(
      title: Text(selectedMeal.title),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              widget._isFavorite = !widget._isFavorite;
            });
            if (widget._isFavorite) {
              if (!widget._favMealIds.contains(selectedMeal.id)) {
                widget._favMealIds.add(selectedMeal.id);
              }
            } else {
              if (widget._favMealIds.contains(selectedMeal.id)) {
                widget._favMealIds.remove(selectedMeal.id);
              }
            }
            writeFavorites();
          },
          icon: Icon(
            widget._favMealIds.contains(selectedMeal.id) ? Icons.favorite : Icons.favorite_border,
            color: Colors.white,
          ),
        )
      ],
    );
    //DUMMY_MEALS.where((element) => element.id == routeArgs['id']);
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          ClipRRect(
            // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
            child: Image.network(
              selectedMeal.imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
              height: (mediaQueryData.size.height - appBar.preferredSize.height - mediaQueryData.padding.top) * 0.3,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Ingredients",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          MealDetailContainer(
              height: (mediaQueryData.size.height - appBar.preferredSize.height - mediaQueryData.padding.top) * 0.2,
              child: ListView.builder(
                itemBuilder: (context, index) => Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                    child: Text(
                      selectedMeal.ingredients[index],
                    ),
                  ),
                ),
                itemCount: selectedMeal.ingredients.length,
              )),
          MealDetailContainer(
              height: (mediaQueryData.size.height - appBar.preferredSize.height - mediaQueryData.padding.top) * 0.3,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Card(
                        //color: Theme.of(context).colorScheme.secondary,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.pink,
                              child: Text(
                                "#${index + 1}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(
                              selectedMeal.steps[index],
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            // selectedMeal.ingredients[index],
                          ),
                        ),
                      ),
                    ],
                  );
                },
                itemCount: selectedMeal.steps.length,
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.delete),
        onPressed: () {
          Navigator.of(context).pop(id);
          //deleteItem(selectedMeal.id);
        },
      ),
    );
  }
}
