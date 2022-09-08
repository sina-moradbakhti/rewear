import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/routes.dart';
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
        color: (request.acceptedBySeller && !request.acceptedByUser)
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
              userType == UserType.seller ? _statusForTailor : _status
            ],
          ),
        ),
      ),
    );
  }

  Widget get _status {
    if (request.canceledBySeller) {
      return Icon(
        Icons.close,
        size: 26,
        color: MyColors.red,
      );
    }

    if (!request.acceptedBySeller) {
      return Icon(
        Icons.circle_outlined,
        size: 26,
        color: MyColors.grey,
      );
    } else {
      if (!request.acceptedByUser) {
        return Icon(
          Icons.emoji_people_rounded,
          size: 26,
          color: MyColors.orange,
        );
      } else {
        return const Icon(
          Icons.check_circle_outline_rounded,
          size: 26,
          color: Colors.green,
        );
      }
    }
  }

  Widget get _statusForTailor {
    if (request.canceledByUser || request.canceledBySeller) {
      return Icon(
        Icons.close,
        size: 26,
        color: MyColors.red,
      );
    }

    if (request.acceptedBySeller && request.acceptedByUser) {
      return const Icon(
        Icons.check_circle_outline_rounded,
        size: 26,
        color: Colors.green,
      );
    } else {
      if (request.acceptedByUser) {
        return Icon(
          Icons.emoji_people_rounded,
          size: 26,
          color: MyColors.orange,
        );
      } else {
        return Icon(
          Icons.circle_outlined,
          size: 26,
          color: MyColors.grey,
        );
      }
    }
  }
}
