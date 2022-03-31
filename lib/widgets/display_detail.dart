//Simple UI widget to display certain meal info (enums) in an appealing way

import 'package:flutter/material.dart';

class DisplayDetail extends StatelessWidget {
  const DisplayDetail({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(
          width: 6,
        ),
        Text(
          text,
          style: const TextStyle(color: Colors.black),
        )
      ],
    );
  }
}
