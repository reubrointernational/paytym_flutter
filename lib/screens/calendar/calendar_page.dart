import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/enums.dart';
import 'package:paytym/screens/calendar/widgets/calendar_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paytym/screens/widgets/custom_app_bar.dart';
import '../../core/constants/strings.dart';
import '../../core/constants/styles.dart';
import 'Tabs/meeting/calendar_meeting_tab.dart';
import 'Tabs/schedule/calendar_schedule_tab.dart';
import 'calendar_controller.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CalendarController calendarController = Get.put(CalendarController());
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      backgroundColor: CustomColors.calendarPageBackgroundColor,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const CalendarCard(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Obx(
                () => CupertinoSlidingSegmentedControl(
                  padding: const EdgeInsets.all(0),
                  backgroundColor: CustomColors.selectedTabColor,
                  children: const {
                    CalendarTabs.meeting: SizedBox(
                      width: 160,
                      height: 40,
                      child: Center(
                        child: Text(
                          kMeetingString,
                          style: kTextStyleS14W600LS0p2,
                        ),
                      ),
                    ),
                    CalendarTabs.events: Text(
                      kEventString,
                      style: kTextStyleS14W600LS0p2,
                    ),
                  },
                  groupValue: calendarController.selectedCalendarTab.value,
                  onValueChanged: (value) =>
                      calendarController.selectedCalendarTab.value = value!,
                ),
              ),
            ),
            SizedBox(
              height: 370,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Obx(() => calendarController.selectedCalendarTab.value ==
                        CalendarTabs.meeting
                    ? const CalendarMeeting()
                    : const CalendarSchedule()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
