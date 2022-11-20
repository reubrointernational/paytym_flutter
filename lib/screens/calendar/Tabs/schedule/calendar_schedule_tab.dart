import 'package:flutter/material.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/calendar/Tabs/schedule/calendar_schedule_card.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/constants/styles.dart';

class CalendarSchedule extends StatelessWidget {
  const CalendarSchedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: calendarScheduleDetails.length,
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                k8amString,
                style: kTextStyleS13W600CustomGrey,
              ),
            ),
            CalendarScheduleCard(),
            kSizedBoxH10,
          ],
        );
      },
    );
  }
}
