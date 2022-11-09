import 'package:flutter/material.dart';

import '../../core/colors/colors.dart';
import '../../core/constants/strings.dart';

class PaytymLogo extends StatelessWidget {
  final double size;
  const PaytymLogo({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: kPayString,
        style: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.w700,
          color: CustomColors.blueTextColor,
        ),
        children: [
          TextSpan(
            text: ktymString,
            style: TextStyle(
              fontSize: size,
              fontWeight: FontWeight.w700,
              color: CustomColors.blackTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
