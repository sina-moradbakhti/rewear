import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/constants.dart';

class MyCustomfield extends StatelessWidget {
  final IconData icon;
  final String title;
  final String hint;
  final String current;
  final VoidCallback? onTapped;
  final VoidCallback? onLongTapped;

  const MyCustomfield({
    Key? key,
    required this.icon,
    this.current = '',
    this.onTapped,
    this.onLongTapped,
    required this.title,
    this.hint = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 2.5, left: 2.5),
            child: Text(
              title,
              style: Get.theme.textTheme.bodyText2
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 45,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                  color: MyColors.lightGrey,
                  borderRadius: MyConstants.buttonCircularRadius,
                  border: Border.all(
                      width: Get
                          .theme.inputDecorationTheme.border!.borderSide.width,
                      color: MyColors.grey)),
              child: MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: onTapped,
                onLongPress: onLongTapped,
                child: Stack(children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: LayoutBuilder(
                      builder: (context, parentSize) => Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(current != '' ? current : hint,
                            style: current != ''
                                ? Get.theme.textTheme.bodyText2
                                    ?.copyWith(color: MyColors.black)
                                : Get.theme.textTheme.bodyText2
                                    ?.copyWith(color: MyColors.darkGrey)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Align(
                      child: Icon(
                        icon,
                        size: 20,
                        color: MyColors.darkGrey,
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  )
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
