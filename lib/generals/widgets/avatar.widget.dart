import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/widgets/defaultAvatarImage.widget.dart';

class AvatarWidget extends StatelessWidget {
  final String avatarId;
  const AvatarWidget({Key? key, required this.avatarId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: MyColors.lightGrey, borderRadius: BorderRadius.circular(60)),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: 60,
        height: 60,
        child: CachedNetworkImage(
            imageUrl: avatarId,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) =>
                const DefaultAvatarImageWidget()),
      ),
    );
  }
}
