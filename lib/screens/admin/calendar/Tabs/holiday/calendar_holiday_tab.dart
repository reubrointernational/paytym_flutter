import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../calendar_controller.dart';
import 'calendar_holiday_card.dart';

class CalendarHolidayTabAdmin extends StatelessWidget {
  const CalendarHolidayTabAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: Get.find<CalendarControllerAdmin>()
            .leaveAdminResponseModel
            .value
            .leaveList
            .length,
        itemBuilder: (context, index) {
          return CalendarHolidayCardAdmin(index: index);
        },
      ),
    );
  }
}
