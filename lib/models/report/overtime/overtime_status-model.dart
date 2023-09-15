import 'dart:ui';

import '../../../core/colors/colors.dart';

class OvertimeStatusModel {
  Color boxColor;
  Color textColor;
  String text;
  OvertimeStatusModel(
      [this.text = '',
      this.textColor = CustomColors.whiteCardColor,
      this.boxColor = CustomColors.backgroundColor]);
}
