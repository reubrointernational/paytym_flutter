import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/admin/calendar/calendar_controller.dart';

import '../../../../../core/constants/styles.dart';
import 'calendar_event_card.dart';

class CalendarEventAdmin extends StatelessWidget {
  const CalendarEventAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  '${Get.find<CalendarControllerAdmin>().eventsResponseModel.value.events?[index].startDate ?? ""} - ${Get.find<CalendarControllerAdmin>().eventsResponseModel.value.events?[index].endDate ?? ""}',
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
