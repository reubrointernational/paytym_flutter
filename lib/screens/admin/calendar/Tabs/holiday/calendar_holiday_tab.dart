import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../calendar_controller.dart';
import 'calendar_holiday_card.dart';


class CalendarHolidayTabAdmin extends StatelessWidget {
  const CalendarHolidayTabAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: Get.find<CalendarControllerAdmin>()
              .eventsResponseModel
              .value
              .events
              ?.length ??
          0,
      itemBuilder: (context, index) {
        return CalendarHolidayCardAdmin(index: index);
      },
    );
  }
}
