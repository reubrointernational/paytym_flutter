import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSVG extends StatelessWidget {
  final String iconPath;
  final double? size;
  final Color? color;
  const CustomSVG(this.iconPath, {super.key, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      width: size,
      height: size,
      fit: BoxFit.cover,
      color: color,
    );
  }
}
