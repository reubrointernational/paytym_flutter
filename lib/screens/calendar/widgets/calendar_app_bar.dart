import 'package:flutter/material.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/core/constants/strings.dart';
import 'package:paytym/core/constants/styles.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/calendar/widgets/custom_svg.dart';

class CalendarAppBar extends StatelessWidget {
  const CalendarAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            CustomSVG(IconPath.menuSvg, size: 20),
            kSizedBoxW15,
            Text(
              kCalendarString,
              style: kTextStyleS18W600,
            ),
          ],
        ),
        const CustomSVG(IconPath.settingsSvg, size: 23),
      ],
    );
  }
}
