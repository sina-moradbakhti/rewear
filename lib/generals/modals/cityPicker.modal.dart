import 'package:flutter/material.dart';

class CityPickerDialog extends StatelessWidget {
  const CityPickerDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        color: Colors.white,
        child: Wrap(
          spacing: 20,
          runSpacing: 20,
          children: const [
            Text('Toronto'),
            Text('Montreal'),
            Text('New York'),
            Text('Los Angeles')
          ],
        ),
      ),
    );
  }
}
