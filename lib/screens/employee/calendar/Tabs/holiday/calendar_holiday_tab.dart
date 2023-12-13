import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/employee/calendar/Tabs/holiday/calendar_holiday_card.dart';
import 'package:paytym/screens/employee/calendar/calendar_controller.dart';

class CalendarHolidayTab extends StatelessWidget {
  const CalendarHolidayTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<CalendarController>().getHolidays();
    });
    return Obx(() {
      final leaveList = Get.find<CalendarController>()
          .leaveAdminResponseModel
          .value
          .leaveList;

      leaveList.sort((a, b) => a.date.compareTo(b.date));

      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: leaveList.length,
        itemBuilder: (context, index) {
          return CalendarHolidayCard(index: index);
        },
      );
    });
  }
}
