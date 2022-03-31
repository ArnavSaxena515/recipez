//Simple stateless widget to display the available categories to choose from as a grid of tiles

import 'package:flutter/material.dart';

import 'package:recipez/screens/categories_meal_screen.dart';
import '../models/category.dart';

class CategoryItem extends StatelessWidget {
  final Category category; //to receive the inforrmation about a particular category

  const CategoryItem({Key? key, required this.category}) : super(key: key);

  void selectCategory(BuildContext currentScreenContext) {
    Navigator.of(currentScreenContext).pushNamed(CategoryMealsScreen.routeName, arguments: {'title': category.title, 'id': category.id});
  } //Function to push to the navigator a screen that will show all the available meals that are available under a
  // certain category. The category is passed on to the categorymealsscreen so that it can load all the meals that come under that particular category

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        selectCategory(context);
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Text(
            category.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [category.color.withOpacity(0.7), category.color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
