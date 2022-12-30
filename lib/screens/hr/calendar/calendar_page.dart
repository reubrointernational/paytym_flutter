import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/screens/calendar/calendar_page.dart';
import 'package:paytym/screens/hr/calendar/calendar_contents.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../core/constants/icons.dart';
import '../../../core/constants/strings.dart';
import '../../../core/constants/styles.dart';
import '../../calendar/widgets/custom_svg.dart';

class CalendarPageHr extends StatefulWidget {
  const CalendarPageHr({super.key});

  @override
  State<CalendarPageHr> createState() => _CalendarPageHrState();
}

enum CalendarTabs { meeting, event }

class _CalendarPageHrState extends State<CalendarPageHr> {
  CalendarTabs selectedTab = CalendarTabs.meeting;
  @override
  Widget build(BuildContext context) {
    DateTime selectedDay = DateTime.now();
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const CalendarPage());
        },
        backgroundColor: CustomColors.blueCardColor,
        child: Image.asset(
          'assets/png/filter_icon.png',
          height: 25,
          width: 25,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Calendar",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/svg/plus_icon.svg',
                      height: 16,
                      width: 16,
                    )
                  ],
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: CustomColors.blueCardColor,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: TableCalendar(
                    onDaySelected: (selectedDay, focusedDay) {},
                    selectedDayPredicate: (day) => isSameDay(selectedDay, day),
                    rowHeight: 65,
                    daysOfWeekHeight: 20,
                    firstDay: DateTime.utc(2022, 12, 12),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: selectedDay,
                    calendarFormat: CalendarFormat.week,
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: kCalendarCard,
                      weekendStyle: kCalendarCard,
                    ),
                    headerStyle: HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                      rightChevronIcon:
                          const CustomSVG(IconPath.forwardArrowSvg, size: 25),
                      leftChevronIcon:
                          const CustomSVG(IconPath.backArrowSvg, size: 25),
                      titleTextStyle: const TextStyle(
                        color: CustomColors.whiteTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      titleTextFormatter: (date, locale) =>
                          DateFormat('MMMM, yyyy').format(date),
                      decoration: const BoxDecoration(
                        color: CustomColors.blueCardColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                    ),
                    calendarStyle: const CalendarStyle(
                      weekendTextStyle: kCalendarCard,
                      defaultTextStyle: kCalendarCard,
                    ),
                  ),
                ),
                CupertinoSlidingSegmentedControl(
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
                    CalendarTabs.event: Text(
                      'Event',
                      style: kTextStyleS14W600LS0p2,
                    ),
                  },
                  groupValue: selectedTab,
                  onValueChanged: (value) => setState(() {
                    selectedTab = value!;
                  }),
                ),
                selectedTab == CalendarTabs.meeting
                    ? const CalendarContents(
                        time: '09:15 AM',
                        name: 'Rhys Hawkins',
                        subText: 'HR Manager',
                        widget: Text(
                          'Kochi',
                          style: TextStyle(
                            color: CustomColors.blueTextColor,
                            fontSize: 13,
                          ),
                        ),
                      )
                    : const CalendarContents(
                        time: '11:00 AM',
                        name: 'BirthdayParty',
                        subText: 'Krishna Palace Hotel, Chennai',
                        widget: Icon(Icons.add,
                            color: CustomColors.blueTextColor),
                      ),
              ]),
        ),
      ),
    );
  }
}
