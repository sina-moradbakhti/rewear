import 'dart:ui';

extension ColorToString on Color {
  String? asString() {
    final Color color = this;
    return '${color.red},${color.green},${color.blue}';
  }
}

extension StringToColor on String {
  Color? toColor() {
    if (this == '') return null;
    final String strColor = this;
    final rgb = strColor.split(',');
    return Color.fromRGBO(
        int.parse(rgb[0]), int.parse(rgb[1]), int.parse(rgb[2]), 1);
  }
}
