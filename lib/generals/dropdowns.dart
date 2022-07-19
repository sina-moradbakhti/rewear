import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/iconly_font_icons.dart';

class MyDropdown extends StatelessWidget {
  final String title;
  final String hint;
  final List<String> items;
  final String current;
  final Function(dynamic) onSelected;

  const MyDropdown({
    Key? key,
    this.current = '',
    required this.title,
    this.hint = '',
    required this.items,
    required this.onSelected,
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
              child: Stack(children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: LayoutBuilder(
                    builder: (context, parentSize) => DropdownButton(
                        underline: Container(),
                        icon: Container(),
                        hint: Container(
                          width: parentSize.maxWidth,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            current != '' ? current : hint,
                            style: current != ''
                                ? Get.theme.textTheme.bodyText2
                                    ?.copyWith(color: MyColors.black)
                                : Get.theme.textTheme.bodyText2
                                    ?.copyWith(color: MyColors.darkGrey),
                          ),
                        ),
                        items: [
                          for (var item in items)
                            DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: Get.theme.textTheme.bodyText2,
                                ))
                        ],
                        onChanged: onSelected),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Align(
                    child: Icon(
                      IconlyFont.arrow___down_2,
                      size: 19,
                      color: MyColors.darkGrey,
                    ),
                    alignment: Alignment.centerRight,
                  ),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
