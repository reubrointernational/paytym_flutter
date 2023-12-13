import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../calendar_controller.dart';
import 'calendar_holiday_card.dart';

class CalendarHolidayTabAdmin extends StatelessWidget {
  const CalendarHolidayTabAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<CalendarControllerAdmin>().getHolidays();
    });
    return Obx(
      () {
        final leaveList = Get.find<CalendarControllerAdmin>()
            .leaveAdminResponseModel
            .value
            .leaveList;

        leaveList.sort((a, b) => a.date.compareTo(b.date));

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: leaveList.length,
          itemBuilder: (context, index) {
            return CalendarHolidayCardAdmin(index: index);
          },
        );
      },
    );
  }
}
