import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/buttons.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/widgets/break.widget.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String? caption;
  final VoidCallback? onYepTapped;
  final String? okButton;

  const ConfirmDialog(
      {Key? key,
      required this.title,
      this.caption,
      this.onYepTapped,
      this.okButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.left,
                    style: Get.theme.textTheme.headline6!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  if (caption != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        caption ?? '',
                        textAlign: TextAlign.left,
                        style: Get.theme.textTheme.bodyText2!
                            .copyWith(fontWeight: FontWeight.normal),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
                padding: MyConstants.topDoublePadding,
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: MyPrimaryButton(
                          designViceVersa: true,
                          onPressed: () => Get.back(),
                          title: 'Cancel',
                        )),
                    BreakWidget(size: 15, vertical: false),
                    Expanded(
                        flex: 1,
                        child: MyPrimaryButton(
                          onPressed: () {
                            Get.back();
                            if (onYepTapped != null) onYepTapped!();
                          },
                          title: okButton ?? 'Yep!',
                        ))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
