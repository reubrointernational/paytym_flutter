import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/icons.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: CustomColors.blueCardColor,
      child: Image.asset(
        IconPath.filterIconPng,
        height: size.height * 0.06, // 25
        width: size.width * 0.06,
      ),
    );
  }
}
