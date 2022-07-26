import 'package:flutter/material.dart';

class TailorySlideshowWidget extends StatefulWidget {
  const TailorySlideshowWidget({Key? key}) : super(key: key);

  @override
  State<TailorySlideshowWidget> createState() => _TailorySlideshowWidgetState();
}

class _TailorySlideshowWidgetState extends State<TailorySlideshowWidget>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      viewportFraction: 0.9,
      controller: TabController(length: 3, vsync: this),
      children: [
      Container(
        margin: const EdgeInsets.all(5),
        color: Colors.yellow,
      ),
      Container(
        margin: const EdgeInsets.all(5),
        color: Colors.green,
      ),
      Container(
        margin: const EdgeInsets.all(5),
        color: Colors.blue,
      ),
    ]);
  }
}
