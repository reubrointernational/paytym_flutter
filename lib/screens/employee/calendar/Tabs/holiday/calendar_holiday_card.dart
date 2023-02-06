import 'package:flutter/material.dart';

import '../../../../../core/colors/colors.dart';
import '../../../../../core/constants/strings.dart';
import '../../../../../core/constants/styles.dart';

class CalendarHolidayCard extends StatelessWidget {
  final int index;

  const CalendarHolidayCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 8,
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                const Text(
                  '26-01-2024',
                  style: kTextStyleS13W600CustomGrey,
                ),
                VerticalDivider(
                  width: w * 0.15,
                  thickness: 3,
                  color: CustomColors.greenColor,
                ),
                const Text(
                  'Republic Day',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
