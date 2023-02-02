import 'package:paytym/models/bottom_nav/bottom_nav_model.dart';
import 'package:flutter/material.dart';

class BottomNavController {
  static List<BottomNavModel> bottomNavModelList = [
    BottomNavModel("Dashboard", Icons.dashboard_outlined),
    BottomNavModel("Leaves", Icons.article_outlined),
    BottomNavModel("Calendar", Icons.calendar_month_outlined),
    BottomNavModel("Chat", Icons.chat_outlined),
    BottomNavModel("Report", Icons.analytics_outlined),
  ];
}