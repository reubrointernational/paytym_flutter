import 'package:flutter/material.dart';
import 'package:paytym/core/colors/colors.dart';

class LeaveStatusModel {
  Color boxColor;
  Color textColor;
  String text;
  LeaveStatusModel(
      [this.text = '',
      this.textColor = CustomColors.backgroundColor,
      this.boxColor = CustomColors.backgroundColor]);
}
