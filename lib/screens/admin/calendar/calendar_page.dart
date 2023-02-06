import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/screens/admin/calendar/widgets/calendar_card.dart';

import 'package:flutter/material.dart';
import '../../../core/constants/strings.dart';
import '../../../core/constants/styles.dart';
import '../../../core/constants/widgets.dart';
import '../../employee/calendar/widgets/custom_floating_action_button.dart';
import '../../widgets/custom_tab_bar.dart';
import 'Tabs/holiday/calendar_holiday_tab.dart';
import 'Tabs/meeting/calendar_meeting_tab.dart';
import 'Tabs/event/calendar_event_tab.dart';
import 'Tabs/schedule/calendar_schedule_tab.dart';
import 'calendar_controller.dart';

class CalendarPageAdmin extends StatelessWidget {
  const CalendarPageAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CalendarControllerAdmin());
    return DefaultTabController(
      length: calendarTabList.length,
      child: Scaffold(
        floatingActionButton: const CustomFloatingActionButton(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: CustomColors.lightBlueColor,
          title: const Text(
            kCalendarString,
            style: kTextStyleS18W600white,
          ),
        ),
        backgroundColor: CustomColors.lightBlueColor,
        body: SafeArea(
          child: Column(
            children: [
              const CalendarCardAdmin(),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 18, 18, 10),
                        child: CustomTabBar(
                          tabsList: calendarTabList,
                        ),
                      ),
                      kSizedBoxH15,
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: TabBarView(
                            physics: BouncingScrollPhysics(),
                            children: [
                              CalendarMeetingAdmin(),
                              CalendarEventAdmin(),
                              CalendarScheduleAdmin(),
                              CalendarHolidayTabAdmin()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(15.0),
              //   child: Obx(
              //     () => CupertinoSlidingSegmentedControl(
              //       padding: const EdgeInsets.all(0),
              //       backgroundColor: CustomColors.selectedTabColor,
              //       children: const {
              //         CalendarTabs.meeting: SizedBox(
              //           width: 160,
              //           height: 40,
              //           child: Center(
              //             child: Text(
              //               kMeetingString,
              //               style: kTextStyleS14W600LS0p2,
              //             ),
              //           ),
              //         ),
              //         CalendarTabs.events: Text(
              //           kEventString,
              //           style: kTextStyleS14W600LS0p2,
              //         ),
              //       },
              //       groupValue: calendarController.selectedCalendarTab.value,
              //       onValueChanged: (value) =>
              //           calendarController.selectedCalendarTab.value = value!,
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 370,
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 15),
              //     child: Obx(() =>
              //         calendarController.selectedCalendarTab.value ==
              //                 CalendarTabs.meeting
              //             ? const CalendarMeeting()
              //             : const CalendarSchedule()),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
