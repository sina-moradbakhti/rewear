import 'package:flutter/material.dart';
import 'package:rewear/config/mock_data.dart';
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
    _controller = TabController(length: 5, vsync: this);
    if (widget.onChangedItem != null) {
      _controller!.addListener(() {
        widget.onChangedItem!(MockData().tailories[_controller!.index]);
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
          for (final tailory in MockData().tailories)
            TailoryMapItem(
                tailory: tailory,
                onTapped: widget.onTappedItem != null
                    ? () => widget.onTappedItem!(tailory)
                    : null)
        ]);
  }
}
