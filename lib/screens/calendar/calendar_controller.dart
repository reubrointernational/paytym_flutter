import '../../models/calendar/calendar_model.dart';
import 'package:flutter/material.dart';

class CalendarController {
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
