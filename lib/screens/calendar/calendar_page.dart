import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/screens/calendar/widgets/calendar_card.dart';
import 'package:flutter/material.dart';
import 'package:paytym/screens/widgets/custom_app_bar.dart';
import '../../core/constants/strings.dart';
import '../widgets/custom_tab_bar.dart';
import 'Tabs/meeting/calendar_meeting_tab.dart';
import 'Tabs/event/calendar_event_tab.dart';
import 'Tabs/schedule/calendar_schedule_tab.dart';
import 'calendar_controller.dart';
import 'widgets/custom_floating_action_button.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CalendarController());
    return DefaultTabController(
      length: calendarTabList.length,
      child: Scaffold(
        floatingActionButton: const CustomFloatingActionButton(),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(),
        ),
        backgroundColor: CustomColors.calendarPageBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              const CalendarCard(),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 10),
                child: CustomTabBar(
                  tabsList: calendarTabList,
                  width: 30,
                  backgroundColor: Colors.grey.shade200,
                ),
              ),

              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: TabBarView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      CalendarMeeting(),
                      CalendarEvent(),
                      CalendarSchedule(),
                      CalendarEvent()
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
