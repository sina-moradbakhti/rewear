import 'package:flutter/material.dart';

class CatalogItemWidget extends StatelessWidget {
  final String image;
  final VoidCallback? onPressed;
  bool fullWidth = true;
  bool fullHeight = false;
  CatalogItemWidget(
      {Key? key,
      required this.image,
      this.fullWidth = true,
      this.onPressed,
      this.fullHeight = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return fullWidth
        ? Container(
            clipBehavior: Clip.antiAlias,
            width: double.infinity,
            height: fullHeight ? double.infinity : 150,
            decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: onPressed,
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          )
        : Container(
            clipBehavior: Clip.antiAlias,
            height: fullHeight ? double.infinity : 150,
            decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: onPressed,
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          );
  }
}
