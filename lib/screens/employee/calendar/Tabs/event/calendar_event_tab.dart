import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/employee/calendar/Tabs/event/calendar_event_card.dart';
import 'package:paytym/screens/employee/calendar/calendar_controller.dart';

import '../../../../../core/constants/styles.dart';

class CalendarEvent extends StatelessWidget {
  const CalendarEvent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<CalendarController>().getEvents();
    });
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
                  '${DateFormat('dd-MM-yyyy').format(Get.find<CalendarController>().eventsResponseModel.value.events?[index].startDate??DateTime(0000,00,00))} - ${DateFormat('dd-MM-yyyy').format(Get.find<CalendarController>().eventsResponseModel.value.events?[index].endDate ?? DateTime(0000, 00, 00))}',
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
