import 'package:flutter/material.dart';

import '../../../../../core/colors/colors.dart';
import '../../../../../core/constants/strings.dart';
import '../../../../../core/constants/styles.dart';
import '../../../../../core/constants/widgets.dart';

class CalendarHolidayCardAdmin extends StatelessWidget {
  final int index;

  const CalendarHolidayCardAdmin({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 8,
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                        child: Text(
                          '26-01-2024',
                          style: kTextStyleS13W600CustomGrey,
                        ),
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
                kSizedBoxH10,
                const Divider(
                  thickness: 3,
                  indent: 10,
                  endIndent: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 5, 25, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.add_circle_outline,
                            color: CustomColors.greenColor,
                          ),
                          kSizedBoxW10,
                          Text(
                            kAddString,
                            style: kTextStyleS13W600,
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.delete_sharp,
                            color: CustomColors.redColor,
                          ),
                          kSizedBoxW10,
                          Text(
                            kDeleteString,
                            style: kTextStyleS13W600,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
