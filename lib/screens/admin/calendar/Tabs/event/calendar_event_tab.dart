import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/admin/calendar/calendar_controller.dart';

import '../../../../../core/constants/styles.dart';
import 'calendar_event_card.dart';

class CalendarEventAdmin extends StatelessWidget {
  const CalendarEventAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<CalendarControllerAdmin>().getEvents();
    });
    return Obx(
      () => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: Get.find<CalendarControllerAdmin>()
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
                padding: const EdgeInsets.only(left: 10, bottom: 5),
                child: Text(
                  '${DateFormat('dd-MM-yyyy').format(Get.find<CalendarControllerAdmin>().eventsResponseModel.value.events?[index].startDate ?? DateTime(0000,00,00))} - ${DateFormat('dd-MM-yyyy').format(Get.find<CalendarControllerAdmin>().eventsResponseModel.value.events?[index].endDate ?? DateTime(0000, 00, 00))}',
                  style: kTextStyleS13W600CustomGrey,
                ),
              ),
              CalendarEventCardAdmin(index: index),
              kSizedBoxH20,
            ],
          );
        },
      ),
    );
  }
}
