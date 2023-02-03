import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/employees_screens/calendar/Tabs/event/calendar_event_card.dart';
import 'package:paytym/screens/employees_screens/calendar/calendar_controller.dart';
import 'package:paytym/screens/employees_screens/reports/reports_controller.dart';

import '../../../../../core/constants/strings.dart';
import '../../../../../core/constants/styles.dart';

class CalendarEvent extends StatelessWidget {
  const CalendarEvent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: Get.find<CalendarController>()
                .eventsResponseModel
                .value
                .events
                ?.length ??
            0,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  '${Get.find<CalendarController>().eventsResponseModel.value.events?[index]?.startDate ?? ""} - ${Get.find<CalendarController>().eventsResponseModel.value.events?[index]?.endDate ?? ""}',
                  style: kTextStyleS13W600CustomGrey,
                ),
              ),
              CalendarEventCard(index: index),
              kSizedBoxH10,
            ],
          );
        },
      ),
    );
  }
}
