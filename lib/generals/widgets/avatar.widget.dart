import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/widgets/defaultAvatarImage.widget.dart';

class AvatarWidget extends StatelessWidget {
  final String avatarId;
  const AvatarWidget({Key? key, required this.avatarId}) : super(key: key);

  @override
  CircleAvatar build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: MyColors.grey,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: CachedNetworkImage(
            imageUrl: avatarId,
            errorWidget: (context, url, error) =>
                const DefaultAvatarImageWidget()),
      ),
    );
  }
}
