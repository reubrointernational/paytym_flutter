import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/screens/employee/calendar/widgets/custom_svg.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../core/constants/styles.dart';
import '../calendar_controller.dart';

class CalendarCardAdmin extends StatelessWidget {
  const CalendarCardAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.lightBlueColor,
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
      child: Column(
        children: [
          Obx(() {
            DateTime selectedDay =
                Get.find<CalendarControllerAdmin>().selectedDay.value;
            return TableCalendar(
              eventLoader: (day) {
                return Get.find<CalendarControllerAdmin>().getEventsForDay(day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                Get.find<CalendarControllerAdmin>().selectedDay.value =
                    selectedDay;
              },
              selectedDayPredicate: (day) => isSameDay(selectedDay, day),
              rowHeight: 65,
              daysOfWeekHeight: 20,
              firstDay: DateTime.utc(2022, 12, 12),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: Get.find<CalendarControllerAdmin>().selectedDay.value,
              calendarFormat: CalendarFormat.week,
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: kCalendarCard,
                weekendStyle: kCalendarCard,
              ),
              headerStyle: HeaderStyle(
                headerPadding: EdgeInsets.only(bottom: 8),
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
              ),
              calendarStyle: const CalendarStyle(
                weekendTextStyle: kCalendarCard,
                defaultTextStyle: kCalendarCard,
              ),
            );
          }),
        ],
      ),
    );
  }
}
