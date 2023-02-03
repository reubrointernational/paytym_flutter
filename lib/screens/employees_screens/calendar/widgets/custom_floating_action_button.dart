import 'package:flutter/material.dart';
import 'package:paytym/core/constants/strings.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants/icons.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: CustomColors.blueCardColor,
      child: Image.asset(
        IconPath.filterIconPng,
        height: 22,
      ),
    );
  }
}
