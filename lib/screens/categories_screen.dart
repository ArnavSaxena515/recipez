// This is a screen to display all the categories that are available in the app data

import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);
  static const routeName = '/categories-screen';

//todo optimize using builder on the GridView
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(25),
        children: dummyCategories
            .map(
              (item) => CategoryItem(category: item),
            )
            .toList(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200, childAspectRatio: 3 / 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
      ),
    );
  }
}
