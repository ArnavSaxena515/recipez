//This is a screen to display a navigation tab at the bottom and display suitable screen widgets depending on the current screen user has selected

import 'package:flutter/material.dart';
import 'package:recipez/models/meal.dart';
import 'package:recipez/screens/categories_screen.dart';

import '../widgets/main_drawer.dart';
import 'favourites_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key, required this.availableMeals}) : super(key: key);
  static const routeName = '/tabs-screen';
  final List<Meal> availableMeals; //for passing on data down the widget tree wherever its needed.

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPage = 0; //index of the current selected page. by default its 0 so the categories screen must be displayed

  void _selectPage(int page) {
    //function to update the current page to be displayed according to the user
    setState(() => _selectedPage = page);
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _pages = [
      //list of maps to store all the potential screens wwe want to display along with their titles
      {'title': "Categories", 'screen': const CategoriesScreen()},
      {
        'title': "Favourites",
        'screen': FavouritesScreen(
          availableMeals: widget.availableMeals,
        )
      },
    ];
    AppBar appBar = AppBar(
      title: Text(
        _pages[_selectedPage]['title'],
      ),
    );
    return Scaffold(
      appBar: appBar,
      drawer: MainDrawer(
        appBarHeight: appBar.preferredSize.height,
      ),
      body: _pages[_selectedPage]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories", backgroundColor: Colors.pink),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favourites", backgroundColor: Colors.pink),
        ],
        onTap: _selectPage,
        currentIndex: _selectedPage,
        backgroundColor: Colors.pink,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.shifting,
      ),
    );
  }
}
