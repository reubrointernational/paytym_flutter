import 'dart:collection';

import 'package:get/get.dart';
import 'package:paytym/network/base_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/constants/enums.dart';
import '../../models/calendar/calendar_model.dart';
import 'package:flutter/material.dart';

class CalendarController extends GetxController with BaseController {
  final selectedCalendarTab = CalendarTabs.meeting.obs;

  final selectedDay = DateTime.now().obs;

  List<dynamic> getEventsForDay(DateTime day) {
    return ['HI', 'This', 'is', 'HI', 'This', 'is'];
  }

  static List<CalendarModel> kCalendarModelList = [
    CalendarModel('Mon', '10', Colors.white, Colors.transparent),
    CalendarModel('Tue', '11', Colors.white, Colors.transparent),
    CalendarModel('Wed', '12', Colors.white, Colors.transparent),
    CalendarModel('Thu', '13', Colors.white, Colors.transparent),
    CalendarModel('Fri', '14', Colors.white, Colors.transparent),
    CalendarModel('Sat', '15', Colors.white, Colors.transparent),
    CalendarModel('Sun', '16', Colors.white, Colors.transparent),
  ];
}
