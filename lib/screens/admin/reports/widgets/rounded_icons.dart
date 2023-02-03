import 'package:flutter/material.dart';

class RoundedIcon extends StatelessWidget {
  final IconData iconPath;
  final Color iconColor;
  final Color? circleColor;
  const RoundedIcon({super.key, required this.iconPath, this.iconColor = Colors.green, this.circleColor});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: circleColor,
      child: Icon(iconPath, color: iconColor,),
    );
  }
}
