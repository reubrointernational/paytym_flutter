import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

class CalendarArrows extends StatelessWidget {
  final String svg;
  const CalendarArrows({super.key, required this.svg});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svg,
      width: 25,
      height: 25,
      fit: BoxFit.cover,
    );
  }
}
