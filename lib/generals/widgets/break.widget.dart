import 'package:flutter/material.dart';

class BreakWidget extends StatelessWidget {
  final double size;
  const BreakWidget({Key? key, this.size = 15}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size);
  }
}
