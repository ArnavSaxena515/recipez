//Model class for the information required for a single meal

// ignore: constant_identifier_names
enum Complexity { Simple, Challenging, Hard }

// ignore: constant_identifier_names
enum Affordability { Affordable, Pricey, Luxurious }

class Meal {
  final String title, id;
  final String imageUrl;
  final List<String> ingredients, steps, categories;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree, isLactoseFree, isVegetarian, isVegan;
  bool isFavourite;

  Meal(
      {required this.id,
      required this.categories,
      required this.title,
      required this.ingredients,
      required this.steps,
      required this.duration,
      required this.complexity,
      required this.isGlutenFree,
      required this.isLactoseFree,
      required this.isVegetarian,
      required this.affordability,
      this.isFavourite = false,
      this.imageUrl = '',
      required this.isVegan});
}
