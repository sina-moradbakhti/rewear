import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/buttons.dart';
import 'package:rewear/generals/modals/requestStatus.model.dart';
import 'package:rewear/generals/widgets/break.widget.dart';
import 'package:rewear/generals/widgets/hr.widget.dart';
import 'package:rewear/generals/widgets/requestStatus.widget.dart';

class RequestHelpDialog extends StatelessWidget {
  const RequestHelpDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: Get.size.width - 100,
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Status guideline",
                    textAlign: TextAlign.center,
                    style: Get.theme.textTheme.headline5!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Hr(),
                  ),
                  ..._guidItems
                ],
              ),
            ),
             const Padding(
               padding: EdgeInsets.symmetric(vertical: 15),
               child: Hr(),
             ),
            Row(
              children: [
                Expanded(
                    child: MyPrimaryButton(
                  designViceVersa: true,
                  onPressed: Get.back,
                  title: 'Close',
                )),
              ],
            )
          ],
        ),
      ),
    );
  }

  List<Widget> get _guidItems => [
        getGuidWidget(RequestStatus.pendingSellerSeen, "Order hasn't seen yet"),
        BreakWidget(size: 5, vertical: true),
        getGuidWidget(
            RequestStatus.pendingSellerApproval, "Order is pending approval"),
        BreakWidget(size: 5, vertical: true),
        getGuidWidget(
            RequestStatus.pendingUserApproval, "Pending your approval"),
        BreakWidget(size: 5, vertical: true),
        getGuidWidget(RequestStatus.approved, 'Order is approved'),
        BreakWidget(size: 5, vertical: true),
        getGuidWidget(RequestStatus.canceled, 'Order is canceled')
      ];

  Widget getGuidWidget(RequestStatus status, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RequestStatusWidget(status: status),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(title, style: Get.theme.textTheme.bodyText1),
        )
      ],
    );
  }
}
