//This is an implementation of a tab controller that appears at the top of the screen under the app bar.

import 'package:flutter/material.dart';
import '../screens/categories_screen.dart';
import '../screens/favourites_screen.dart';

class TabControllerTop extends StatelessWidget {
  const TabControllerTop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "RecipEZ",
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Categories",
                icon: Icon(
                  Icons.category,
                ),
              ),
              Tab(
                text: "Favourites",
                icon: Icon(
                  Icons.favorite,
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CategoriesScreen(),
            FavouritesScreen(
              availableMeals: [],
            )
          ], //if this widget is being used, the list of available meals need to be passed down to it
        ),
      ),
    );
  }
}
