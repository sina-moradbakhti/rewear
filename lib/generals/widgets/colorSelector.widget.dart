import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/config/app_init.dart';

class ColorSelectorWidget extends StatefulWidget {
  final Color? selectedColor;
  final Function(Color)? onChanged;
  const ColorSelectorWidget({Key? key, this.selectedColor, this.onChanged})
      : super(key: key);

  @override
  State<ColorSelectorWidget> createState() => _ColorSelectorWidgetState();
}

class _ColorSelectorWidgetState extends State<ColorSelectorWidget> {
  Color? _selectedColor;

  @override
  void initState() {
    _selectedColor = widget.selectedColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: SizedBox(
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.5, left: 2.5),
                  child: Text(
                    'Color',
                    style: Get.theme.textTheme.bodyText2
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    for (var color in AppInit().colors)
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              if (widget.onChanged != null) {
                                widget.onChanged!(color);
                              }
                              setState(() {
                                _selectedColor = color;
                              });
                            },
                            icon: color == Colors.white
                                ? CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 20,
                                    child:
                                        _colorWg(color: color, hasBorder: true),
                                  )
                                : _colorWg(color: color)),
                      )
                  ],
                )
              ]),
        ));
  }

  Widget _colorWg({required Color color, bool hasBorder = false}) {
    return CircleAvatar(
      backgroundColor: color,
      radius: hasBorder ? 19 : 20,
      child: CircleAvatar(
        backgroundColor: _selectedColor == null
            ? color
            : (_selectedColor == color)
                ? hasBorder
                    ? Colors.black
                    : Colors.white
                : color,
        radius: 9,
      ),
    );
  }
}
