import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/buttons.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/widgets/loading.widget.dart';

class ConfirmTailoryDialog extends StatefulWidget {
  final VoidCallback onYepClicked;
  const ConfirmTailoryDialog({Key? key, required this.onYepClicked})
      : super(key: key);

  @override
  State<ConfirmTailoryDialog> createState() => _ConfirmTailoryDialogState();
}

class _ConfirmTailoryDialogState extends State<ConfirmTailoryDialog> {
  bool _loading = false;

  onClicked() {
    setState(() {
      _loading = true;
    });
    widget.onYepClicked();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: AlertDialog(
          content: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Confirm Order",
                    style: Get.theme.textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.bold, color: MyColors.darkGrey),
                  ),
                  Padding(
                    padding: MyConstants.topPadding,
                    child: Text(
                      "Are you sure to choose this Tailory?",
                      textAlign: TextAlign.center,
                      style: Get.theme.textTheme.bodyText1!
                          .copyWith(color: MyColors.darkGrey),
                    ),
                  ),
                  Padding(
                      padding: MyConstants.topDoublePadding,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _loading
                              ? const Center(
                                  child: MyLoading(),
                                )
                              : MyPrimaryButton(
                                  onPressed: () => onClicked(),
                                  title: 'Yep!',
                                ),
                          _loading ? Container() : Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextButton(
                              child: Text('No',
                                  style: Get.theme.textTheme.bodyText1!
                                      .copyWith(color: MyColors.darkGrey)),
                              onPressed: () => Get.back(),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async => _loading ? false : true);
  }
}
