import 'package:flutter/material.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/calendar/Tabs/event/calendar_event_card.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/constants/styles.dart';

class CalendarEvent extends StatelessWidget {
  const CalendarEvent({Key? key}) : super(key: key);

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
                '08 : 00 AM',
                style: kTextStyleS13W600CustomGrey,
              ),
            ),
            CalendarEventCard(),
            kSizedBoxH10,
          ],
        );
      },
    );
  }
}
