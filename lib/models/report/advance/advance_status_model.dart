import 'package:flutter/material.dart';
import 'package:paytym/core/colors/colors.dart';

class AdvanceStatusModel {
  Color boxColor;
  Color textColor;
  String text;
  AdvanceStatusModel(
      [this.text = '',
      this.textColor = CustomColors.whiteCardColor,
      this.boxColor = CustomColors.backgroundColor]);
}
