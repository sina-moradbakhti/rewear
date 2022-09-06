import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/widgets/hr.widget.dart';
import 'package:rewear/generals/widgets/star.widget.dart';
import 'package:rewear/models/tailor.dart';
import 'package:rewear/generals/exts/extensions.dart';

class TailoryMapItem extends StatelessWidget {
  VoidCallback? onTapped;
  final Tailor tailory;
  TailoryMapItem({Key? key, this.onTapped, required this.tailory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(5),
      clipBehavior: Clip.none,
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: onTapped,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                        width: 100,
                        height: 100,
                        child: (tailory.image != null)
                            ? Image.network(
                                tailory.image!.avatarURL(),
                                fit: BoxFit.cover,
                              )
                            : Container())),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      child: Text(
                        tailory.fullname ?? '',
                        style: Get.theme.textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.fade),
                      ),
                      height: 35),
                  SizedBox(
                    child: Text(
                      tailory.address ?? '',
                      style: Get.theme.textTheme.bodyText2!.copyWith(
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    height: 40,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Hr(),
                  ),
                  StarWidget(rate: tailory.rate ?? 0)
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
