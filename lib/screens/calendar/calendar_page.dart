import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/enums.dart';
import 'package:paytym/screens/calendar/widgets/calendar_card.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Tabs/meeting/calendar_meeting_tab.dart';
import 'Tabs/schedule/calendar_schedule_tab.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarTabs selectedCalendarTab = CalendarTabs.meeting;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.calendarPageBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const CalendarCard(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: CupertinoSlidingSegmentedControl(
                padding: const EdgeInsets.all(0),
                backgroundColor: CustomColors.selectedTabColor,
                children: const {
                  CalendarTabs.meeting: SizedBox(
                    width: 160,
                    height: 40,
                    child: Center(
                      child: Text(
                        "Meeting",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),
                  CalendarTabs.schedule: Text(
                    "Schedule",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                },
                groupValue: selectedCalendarTab,
                onValueChanged: (value) {
                  setState(() {
                    selectedCalendarTab = value!;
                  });
                },
              ),
            ),
            SizedBox(
              height: 370,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: selectSegmentType(selectedCalendarTab),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget selectSegmentType(tab) {
    if (tab == CalendarTabs.meeting) {
      return const CalendarMeeting();
    } else if (tab == CalendarTabs.schedule) {
      return const CalendarSchedule();
    }
    return Container();
  }
}
