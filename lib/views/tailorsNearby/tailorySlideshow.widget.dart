import 'package:flutter/material.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/widgets/tailoryMapItem.widget.dart';
import 'package:rewear/models/tailor.dart';

class TailorySlideshowWidget extends StatefulWidget {
  Function(Tailor)? onTappedItem;
  Function(Tailor)? onChangedItem;
  TailorySlideshowWidget({Key? key, this.onTappedItem, this.onChangedItem})
      : super(key: key);

  @override
  State<TailorySlideshowWidget> createState() => _TailorySlideshowWidgetState();
}

class _TailorySlideshowWidgetState extends State<TailorySlideshowWidget>
    with TickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    _controller = TabController(length: AppInit().tailors.length, vsync: this);
    if (widget.onChangedItem != null) {
      _controller!.addListener(() {
        widget.onChangedItem!(AppInit().tailors[_controller!.index]);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
        viewportFraction: 0.9,
        controller: _controller,
        children: [
          for (final tailory in AppInit().tailors)
            TailoryMapItem(
                tailory: tailory,
                onTapped: widget.onTappedItem != null
                    ? () => widget.onTappedItem!(tailory)
                    : null)
        ]);
  }
}
