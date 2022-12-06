import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../core/colors/colors.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final double radius;
  final String imageUrl;
  const CustomCachedNetworkImage(
      {super.key, required this.radius, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: radius,
        backgroundColor: CustomColors.circleAvatarBackgroundColor,
        backgroundImage: imageProvider,
      ),
      placeholder: (context, url) => const SpinKitDoubleBounce(
        color: CustomColors.whiteCircleAvatarBackgroundColor,
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
