import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/iconly_font_icons.dart';
import 'package:rewear/generals/images.dart';
import 'package:rewear/generals/widgets/break.widget.dart';

class UploadBoxWidget extends StatefulWidget {
  final Function(List<XFile>) onUpdatedPhotoList;
  const UploadBoxWidget({Key? key, required this.onUpdatedPhotoList})
      : super(key: key);

  @override
  State<UploadBoxWidget> createState() => _UploadBoxWidgetState();
}

class _UploadBoxWidgetState extends State<UploadBoxWidget> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _photos = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (_photos.isNotEmpty)
          Column(
            children: [
              for (var photo in _photos.reversed)
                UploadPhotoItemWidget(
                    file: photo,
                    onDeleted: () {
                      setState(() {
                        _photos.removeWhere((element) => element == photo);
                      });
                    }),
              BreakWidget(size: 10)
            ],
          ),
        MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onPressed: _upload,
          padding: EdgeInsets.zero,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
                color: MyColors.lightOrange.withOpacity(.5),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 1.5, color: MyColors.orange)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  MySvgs.cartable,
                  width: 35,
                  height: 35,
                ),
                BreakWidget(size: 10),
                Text(
                  'Upload your photos here',
                  style: Get.theme.textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.w400, color: MyColors.black),
                ),
                BreakWidget(size: 10),
                Text(
                  'Browse',
                  style: Get.theme.textTheme.bodyText1!.copyWith(
                      color: MyColors.orange, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void _upload() async {
    await _picker
        .pickImage(source: ImageSource.gallery, imageQuality: 50, maxWidth: 400)
        .then((photos) {
      if (photos != null) {
        setState(() {
          _photos.add(photos);
        });
        widget.onUpdatedPhotoList(_photos);
      }
    });
  }
}

class UploadPhotoItemWidget extends StatelessWidget {
  final XFile file;
  final VoidCallback onDeleted;
  const UploadPhotoItemWidget(
      {Key? key, required this.file, required this.onDeleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: MyColors.lightGrey,
          border: Border.all(width: 1, color: MyColors.mediumGrey),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                    width: 45,
                    height: 45,
                    child: Image.file(
                      File(file.path),
                      fit: BoxFit.cover,
                    )),
              ),
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: onDeleted,
                  icon: Icon(
                    IconlyFont.delete,
                    color: MyColors.red,
                  ))
            ]),
      ),
    );
  }
}
