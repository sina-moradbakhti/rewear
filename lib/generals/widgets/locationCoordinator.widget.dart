import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/iconly_font_icons.dart';
import 'package:rewear/generals/widgets/loading.widget.dart';

class LocationCoordinatorWidget extends StatelessWidget {
  final bool active;
  final bool loading;
  final VoidCallback? onTapped;
  const LocationCoordinatorWidget(
      {Key? key, this.active = false, this.loading = false, this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapped,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: MyColors.mediumGrey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(
                  IconlyFont.location,
                  size: 19,
                  color: active ? MyColors.orange : MyColors.mediumGrey,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Coordinate your location',
                    style: Get.theme.textTheme.bodyText2,
                  ),
                )
              ],
            ),
            loading
                ? const MyLoading(
                    size: 15,
                  )
                : Icon(
                    active ? Icons.check : Icons.circle_outlined,
                    size: 19,
                    color: active ? MyColors.orange : MyColors.mediumGrey,
                  )
          ],
        ),
      ),
    );
  }
}
