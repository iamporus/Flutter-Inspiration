import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfilePageWidget extends StatelessWidget {
  const ProfilePageWidget({
    Key key,
    @required this.profilePictureImage,
  }) : super(key: key);

  final profilePictureImage;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.cover,
      child: Align(
        alignment: Alignment.center,
        child: CachedNetworkImage(
          imageUrl: profilePictureImage,
        ),
      ),
    );
  }
}
