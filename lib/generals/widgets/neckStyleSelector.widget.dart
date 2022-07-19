import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rewear/config/app_init.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/images.dart';
import 'package:rewear/models/neckStyle.model.dart';

class NeckStyleSelector extends StatefulWidget {
  final NeckStyleModel? selectedModel;
  final Function(NeckStyleModel) onSelected;
  const NeckStyleSelector(
      {Key? key, this.selectedModel, required this.onSelected})
      : super(key: key);

  @override
  State<NeckStyleSelector> createState() => _NeckStyleSelectorState();
}

class _NeckStyleSelectorState extends State<NeckStyleSelector> {
  final List<NeckStyleModel> neckStyles = AppInit().neckStyles;

  NeckStyleModel _selected = AppInit().neckStyles.first;

  @override
  void initState() {
    if (widget.selectedModel != null) {
      _selected = widget.selectedModel!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              bottom: 2.5, left: MyConstants.primaryPadding.left),
          child: Text(
            'Neck Style',
            style: Get.theme.textTheme.bodyText1
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 110,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MyConstants.primaryPadding.left / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (var item in neckStyles)
                    NeckStyleItem(
                      model: item,
                      selected: _selected.style == item.style,
                      onTapped: () {
                        widget.onSelected(_selected);
                        setState(() {
                          _selected = item;
                        });
                      },
                    )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class NeckStyleItem extends StatelessWidget {
  final NeckStyleModel model;
  final bool selected;
  VoidCallback? onTapped;
  NeckStyleItem(
      {Key? key, this.selected = false, required this.model, this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return Container(
        height: size.maxHeight,
        width: size.maxHeight - 15,
        margin: const EdgeInsets.all(7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                width: 2, color: !selected ? MyColors.grey : MyColors.orange)),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onTap: onTapped,
          child: Stack(
            children: [
              if (selected)
                Positioned(
                  child: SvgPicture.asset(
                    MySvgs.checkCircle,
                    width: 20,
                    height: 20,
                  ),
                  top: 2.5,
                  right: 2.5,
                ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Center(
                  child: Image.asset(
                    !selected ? model.image : model.clickedImage,
                    alignment: Alignment.center,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
