import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/modals/requestStatus.model.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/generals/widgets/requestStatus.widget.dart';
import 'package:rewear/models/request.model.dart';
import 'package:rewear/generals/exts/extensions.dart';
import 'package:rewear/models/userType.enum.dart';

class RequestWidget extends StatelessWidget {
  final Request request;
  final UserType userType;
  const RequestWidget(
      {Key? key, required this.request, this.userType = UserType.customer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.5, color: MyColors.grey))),
      child: MaterialButton(
        color: ((userType == UserType.customer &&
                    (request.acceptedBySeller &&
                        !request.acceptedByUser &&
                        !request.canceledByUser)) ||
                (userType == UserType.seller &&
                    (!request.acceptedBySeller &&
                        !request.canceledBySeller &&
                        !request.acceptedByUser &&
                        !request.canceledByUser)))
            ? MyColors.lightOrange
            : MyColors.white,
        padding: EdgeInsets.zero,
        onPressed: () => userType == UserType.seller
            ? Get.toNamed(MyRoutes.tailorRequestDetails, arguments: request)
            : Get.toNamed(MyRoutes.requestDetails, arguments: request),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MyConstants.primaryPadding.top / 2,
              horizontal: MyConstants.primaryPadding.left),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 55,
                      height: 55,
                      child: Image.network(
                        (request.images?.first ?? '').clothURL(request.id!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request.serviceType ?? '',
                          style: Get.theme.textTheme.bodyText1!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          request.deliveryToTailor.beautify(),
                          style: Get.theme.textTheme.bodyText2,
                        )
                      ],
                    ),
                  )
                ],
              ),
              _status
            ],
          ),
        ),
      ),
    );
  }

  Widget get _status {
    if (request.canceledBySeller || request.canceledByUser) {
      return const RequestStatusWidget(status: RequestStatus.canceled);
    } else {
      // Order is not canceled but
      if (!request.acceptedBySeller) {
        // not accepted yet
        if (request.tailorSeen) {
          // seen
          return const RequestStatusWidget(
              status: RequestStatus.pendingSellerApproval);
        } else {
          // not seen
          return const RequestStatusWidget(
              status: RequestStatus.pendingSellerSeen);
        }
      } else {
        // Order is accepted by seller
        if (!request.acceptedByUser) {
          return const RequestStatusWidget(
              status: RequestStatus.pendingUserApproval);
        } else {
          return const RequestStatusWidget(status: RequestStatus.approved);
        }
      }
    }
  }
}
