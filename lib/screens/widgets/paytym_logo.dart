import 'package:flutter/material.dart';

class PaytymLogo extends StatelessWidget {
  final double size;
  final Color? color;
  const PaytymLogo({super.key, this.size = 100, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 70,
        width: 140,

        child: Image.asset(
          'assets/png/logo2.png',
          height: size,
          color: color,fit: BoxFit.contain,
        ),
      ),
    );
  }
}
