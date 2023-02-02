import 'package:flutter/material.dart';

import '../../core/colors/colors.dart';
import '../../core/constants/strings.dart';

class PaytymLogo extends StatelessWidget {
  final double size;
  final Color? color;
  const PaytymLogo({super.key, this.size = 100, this.color});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/png/logo.png',
      height: size,
      color: color,
    );
  }
}
