import 'package:flutter/material.dart';

import '../../core/colors/colors.dart';
import '../../core/constants/strings.dart';

class PaytymLogo extends StatelessWidget {
  final double size;
  const PaytymLogo({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/png/logo.png',
      height: size,
    );
  }
}
