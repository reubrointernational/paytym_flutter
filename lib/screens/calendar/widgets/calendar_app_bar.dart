import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paytym/core/constants/icons.dart';

class CalendarAppBar extends StatelessWidget {
  const CalendarAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              IconPath.menuSvg,
              width: 20,
              height: 20,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 15,
            ),
            const Text(
              "Calendar",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SvgPicture.asset(
          IconPath.settingsSvg,
          width: 23,
          height: 23,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
