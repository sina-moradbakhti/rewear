import 'dart:math';
import 'dart:ui';
import 'package:rewear/config/app_init.dart';

extension ColorToString on Color {
  String? asString() {
    final Color color = this;
    return '${color.red},${color.green},${color.blue}';
  }
}

extension StringToColor on String {
  String avatarURL(String userId) {
    final rand = Random();
    final str = this;
    return AppInit.BASE_URL +
        '/images/avatar/' +
        userId +
        '/' +
        str.replaceAll('.jpg', '') +
        '?rand=' +
        rand.nextInt(9999).toString();
  }

  String coverURL(String userId) {
    final rand = Random();
    final str = this;
    return AppInit.BASE_URL +
        '/images/cover/' +
        userId +
        '/' +
        str.replaceAll('.jpg', '') +
        '?rand=' +
        rand.nextInt(9999).toString();
  }

  String resURL(String reqId) {
    final str = this;
    return AppInit.BASE_URL +
        '/images/request/' +
        'userId' +
        '/' +
        reqId +
        '/' +
        str.replaceAll('.jpg', '');
  }

  Color? toColor() {
    if (this == '') return null;
    final String strColor = this;
    final rgb = strColor.split(',');
    return Color.fromRGBO(
        int.parse(rgb[0]), int.parse(rgb[1]), int.parse(rgb[2]), 1);
  }

  bool validatePassword() {
    String pattern = r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(this);
  }
}

extension DateBeautifier on DateTime {
  String beautify() {
    final DateTime? current = this;
    if (current == null) return '';
    final time =
        '${current.hour < 10 ? '0${current.hour}' : current.hour}:${current.minute < 10 ? '0${current.minute}' : current.minute}';
    if (current.year == DateTime.now().year) {
      return '${current.day} ${_getMonth(current.month)}, $time';
    } else {
      return '${current.day} ${_getMonth(current.month)} ${current.year}, $time';
    }
  }

  String _getMonth(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return 'Jan';
    }
  }
}
