import 'package:flutter/material.dart';

class BreakWidget extends StatelessWidget {
  final double size;
  bool vertical = true;
  BreakWidget({Key? key, this.size = 15, this.vertical = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return vertical ? SizedBox(height: size) : SizedBox(width: size);
  }
}
