import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/screens/calendar/widgets/custom_svg.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../core/constants/styles.dart';
import '../../../core/constants/widgets.dart';
import '../calendar_controller.dart';

class CalendarCard extends StatelessWidget {
  const CalendarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.whiteCardColor,
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: CustomColors.blueCardColor,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Obx(() {
              DateTime selectedDay =
                  Get.find<CalendarController>().selectedDay.value;
              return TableCalendar(
                eventLoader: (day) {
                  return Get.find<CalendarController>().getEventsForDay(day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  Get.find<CalendarController>().selectedDay.value =
                      selectedDay;
                },
                selectedDayPredicate: (day) => isSameDay(selectedDay, day),
                rowHeight: 65,
                daysOfWeekHeight: 20,
                firstDay: DateTime.utc(2022, 12, 12),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: Get.find<CalendarController>().selectedDay.value,
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
              );
            }),
          ),
        ],
      ),
    );
  }
}
