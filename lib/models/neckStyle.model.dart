import 'package:rewear/models/neckStyle.enum.dart';

class NeckStyleModel {
  final NeckStyle style;
  final String image;
  final String clickedImage;

  NeckStyleModel(
      {required this.clickedImage, required this.image, required this.style});
}
