import 'package:flutter/material.dart';

class StarWidget extends StatelessWidget {
  final int rate;
  const StarWidget({Key? key, required this.rate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < rate; i++)
          Icon(Icons.star, size: 16, color: Colors.yellow.shade700),
        for (int i = 0; i < 5 - rate; i++)
          Icon(Icons.star, size: 16, color: Colors.grey.shade400),
      ],
    );
  }
}
