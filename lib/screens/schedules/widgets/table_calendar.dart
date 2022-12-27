import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/colors/colors.dart';

class CustomTableCalendar extends StatelessWidget {
  const CustomTableCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      rowHeight: 50,
      focusedDay: DateTime.now(),
      lastDay: DateTime.utc(2030, 3, 14),
      firstDay: DateTime.utc(2010, 10, 16),
      calendarFormat: CalendarFormat.week,
      daysOfWeekHeight: 30,
      calendarStyle: CalendarStyle(
        defaultDecoration:
            BoxDecoration(color: Colors.grey.shade200, shape: BoxShape.circle),
        todayTextStyle: const TextStyle(
          color: Colors.white,
        ),
        todayDecoration: const BoxDecoration(
            color: CustomColors.blueTextColor, shape: BoxShape.circle),
      ),
      headerStyle: const HeaderStyle(
          leftChevronVisible: false,
          rightChevronVisible: false,
          formatButtonVisible: false,
          titleTextStyle: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          )),
    );
  }
}
