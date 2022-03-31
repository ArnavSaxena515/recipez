//Container widget to display data inside of

import 'package:flutter/material.dart';

class MealDetailContainer extends StatelessWidget {
  const MealDetailContainer({
    Key? key,
    required this.child,
    required this.height,
  }) : super(key: key);

  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey)),
      height: height,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: child,
    );
  }
}
