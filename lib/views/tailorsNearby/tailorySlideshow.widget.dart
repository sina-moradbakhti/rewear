import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rewear/generals/widgets/tailoryMapItem.widget.dart';

class TailorySlideshowWidget extends StatefulWidget {
  Function(LatLng)? onTappedItem;
  TailorySlideshowWidget({Key? key, this.onTappedItem})
      : super(key: key);

  @override
  State<TailorySlideshowWidget> createState() => _TailorySlideshowWidgetState();
}

class _TailorySlideshowWidgetState extends State<TailorySlideshowWidget>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
        viewportFraction: 0.9,
        controller: TabController(length: 5, vsync: this),
        children: [
          TailoryMapItem(
              onTapped: widget.onTappedItem != null
                  ? () => widget
                      .onTappedItem!(const LatLng(45.5616284, -73.6056387))
                  : null),
          TailoryMapItem(),
          TailoryMapItem(),
          TailoryMapItem(),
          TailoryMapItem()
        ]);
  }
}
