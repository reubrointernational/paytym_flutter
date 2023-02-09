import 'package:flutter/material.dart';
import 'package:paytym/core/constants/strings.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants/icons.dart';


class CustomFloatingActionButton extends StatelessWidget {
  final void Function()? onPressed;
  const CustomFloatingActionButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: CustomColors.lightBlueColor,
      child: Image.asset(
        IconPath.filterIconPng,
        height: h * 0.06, // 25
        width: w * 0.06,
      ),
    );
  }
}
