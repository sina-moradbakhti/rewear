import 'package:flutter/material.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/modals/requestStatus.model.dart';

class RequestStatusWidget extends StatelessWidget {
  final RequestStatus status;
  const RequestStatusWidget({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double fontSize = 27;
    const double icon1xffset = -3.5;
    const double icon2xffset = 3.5;
    Widget child = Container();

    switch (status) {
      case RequestStatus.canceled:
        child = Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.warning_rounded,
              size: fontSize,
              color: MyColors.orange,
            ),
          ],
        );
        break;
      case RequestStatus.pendingSellerApproval:
        child = Stack(
          alignment: Alignment.center,
          children: [
            Transform.translate(
              offset: const Offset(icon1xffset, 0),
              child: Icon(
                Icons.check_rounded,
                size: fontSize,
                color: MyColors.grey,
              ),
            ),
            Transform.translate(
              offset: const Offset(icon2xffset, 0),
              child: Icon(
                Icons.check_rounded,
                size: fontSize,
                color: MyColors.grey,
              ),
            )
          ],
        );
        break;
      case RequestStatus.pendingSellerSeen:
        child = Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.check_rounded,
              size: fontSize,
              color: MyColors.grey,
            ),
          ],
        );
        break;
      case RequestStatus.pendingUserApproval:
        child = Stack(
          alignment: Alignment.center,
          children: [
            Transform.translate(
              offset: const Offset(icon1xffset, 0),
              child: Icon(
                Icons.check_rounded,
                size: fontSize,
                color: MyColors.orange,
              ),
            ),
            Transform.translate(
              offset: const Offset(icon2xffset, 0),
              child: Icon(
                Icons.check_rounded,
                size: fontSize,
                color: MyColors.orange,
              ),
            )
          ],
        );
        break;
      case RequestStatus.approved:
        child = Stack(
          alignment: Alignment.center,
          children: [
            Transform.translate(
              offset: const Offset(icon1xffset, 0),
              child: const Icon(
                Icons.check_rounded,
                size: fontSize,
                color: Colors.green,
              ),
            ),
            Transform.translate(
              offset: const Offset(icon2xffset, 0),
              child: const Icon(
                Icons.check_rounded,
                size: fontSize,
                color: Colors.green,
              ),
            )
          ],
        );
        break;
      default:
    }

    return SizedBox(width: 40, height: 40, child: Container(child: child));
  }
}
