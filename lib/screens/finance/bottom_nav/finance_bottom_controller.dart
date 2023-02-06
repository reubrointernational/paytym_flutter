import 'package:paytym/models/bottom_nav/bottom_nav_model.dart';
import 'package:flutter/material.dart';

class FinanceBottomNavController {
  static List<BottomNavModel> bottomNavModelList = [
    BottomNavModel("Dashboard", Icons.dashboard_outlined),
    BottomNavModel("Payroll", Icons.article_outlined),
    BottomNavModel("Calendar", Icons.calendar_month_outlined),
    BottomNavModel("Wages", Icons.paid_outlined),
    BottomNavModel("Report", Icons.analytics_outlined),
  ];
}
