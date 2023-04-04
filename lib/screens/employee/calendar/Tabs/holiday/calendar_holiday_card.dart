import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../core/colors/colors.dart';
import '../../../../../core/constants/strings.dart';
import '../../../../../core/constants/styles.dart';
import '../../calendar_controller.dart';

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
                Text(
                  DateFormat('dd-MM-yyyy').format(DateTime.parse(
                      Get.find<CalendarController>()
                          .leaveAdminResponseModel
                          .value
                          .leaveList[index]
                          .date)),
                  style: kTextStyleS13W600CustomGrey,
                ),
                VerticalDivider(
                  width: w * 0.15,
                  thickness: 3,
                  color: CustomColors.greenColor,
                ),
                Text(
                  Get.find<CalendarController>()
                      .leaveAdminResponseModel
                      .value
                      .leaveList[index]
                      .name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
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
