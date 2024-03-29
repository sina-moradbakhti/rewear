import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/modals/requestStatus.model.dart';
import 'package:rewear/generals/routes.dart';
import 'package:rewear/generals/widgets/requestStatus.widget.dart';
import 'package:rewear/models/orderStatus.enum.dart';
import 'package:rewear/models/request.model.dart';
import 'package:rewear/generals/exts/extensions.dart';
import 'package:rewear/models/userType.enum.dart';

import 'defaultClotheImage.widget.dart';

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
        elevation: 0,
        color: _getStColor(),
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
                      child: CachedNetworkImage(
                        imageUrl:
                            (request.images?.first ?? '').resURL(request.id!),
                        errorWidget: ((context, url, error) =>
                            const DefaultClothImageWidget()),
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

  Color _getStColor() {
    if (userType == UserType.customer && !request.customerSeen) {
      return MyColors.lightOrange;
    } else if (userType == UserType.seller && !request.sellerSeen) {
      return MyColors.lightOrange;
    }

    return MyColors.white;
  }

  Widget get _status {
    if (request.orderStatus == OrderStatus.rejectedBySeller ||
        request.orderStatus == OrderStatus.rejectedByCustomer) {
      return const RequestStatusWidget(status: RequestStatus.canceled);
    } else {
      // Order is not canceled but
      if (request.orderStatus != OrderStatus.acceptedBySeller) {
        // not accepted yet
        if (request.sellerSeen) {
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
        if (request.orderStatus != OrderStatus.acceptedByBoth) {
          return const RequestStatusWidget(
              status: RequestStatus.pendingUserApproval);
        } else {
          return const RequestStatusWidget(status: RequestStatus.approved);
        }
      }
    }
  }
}
