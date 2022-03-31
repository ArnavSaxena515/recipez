//Model class for storing the data about the different categories of food

import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color color;

  const Category({required this.color, required this.title, required this.id});
}
