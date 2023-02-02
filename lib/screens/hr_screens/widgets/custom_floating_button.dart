import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/icons.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final void Function()? onPressed;
  const CustomFloatingActionButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: CustomColors.lightBlueColor,
      child: Image.asset(
        IconPath.floatingActionFilterIconPng,
        height: size.height * 0.06, // 25
        width: size.width * 0.06,
      ),
    );
  }
}
