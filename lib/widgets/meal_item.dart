//Widget to display the meals belonging to a certain category with some brief information

import 'package:flutter/material.dart';
import 'package:recipez/widgets/display_detail.dart';

import '../models/meal.dart';
import '../screens/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.id,
    required this.removeItem,
    required this.isFavourite,
  }) : super(key: key);
  final String title, imageUrl, id;
  final int duration;
  final Function removeItem;
  final bool isFavourite;

  // ignore: prefer_typing_uninitialized_variables
  final complexity;

  // ignore: prefer_typing_uninitialized_variables
  final affordability;

  String get complexityText {
    switch (complexity) {
      case Complexity.Simple:
        return "Simple";

      case Complexity.Challenging:
        return "Challenging";

      case Complexity.Hard:
        return "Hard";

      default:
        return "Unknown";
    }
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.Affordable:
        return "Affordable";

      case Affordability.Luxurious:
        return "Luxurious";

      case Affordability.Pricey:
        return "Pricey";

      default:
        return "Unknown";
    }
  }

  void selectMeal(BuildContext categoryScreenContext) {
    Navigator.pushNamed(categoryScreenContext, MealDetails.routeName, arguments: id).then((result) {
      if (result.toString().isNotEmpty) {
        removeItem(result.toString());
      }
    }); //if user taps this. they are taken to a screen where all the details (steps and ingredients) are displayed for that meal
    //Using MaterialPageRoute   Navigator.push(categoryScreenContext, MaterialPageRoute(builder: (ctx) => MealDetails()));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        //color: Colors.pink,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(
                      15,
                    ),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    width: 300,
                    child: Text(
                      title,
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 26, color: Colors.white),
                      softWrap: true,
                      textScaleFactor: 1,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DisplayDetail(
                    icon: Icons.access_time,
                    text: "${duration.toString()} minutes",
                  ),
                  DisplayDetail(
                    icon: Icons.account_balance_wallet_outlined,
                    text: affordabilityText,
                  ),
                  DisplayDetail(
                    icon: Icons.build,
                    text: complexityText,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
