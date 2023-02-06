import 'package:flutter/material.dart';
import 'package:paytym/screens/admin/leaves/leaves_page.dart';

import '../../../core/colors/colors.dart';
import '../../admin/calendar/calendar_page.dart';
import '../../admin/dashboard/hr_dashboard.dart';
import '../../admin/reports/reports_page.dart';
import '../../employee/bottom_nav/bottom_nav_controller.dart';
import '../wages_page.dart/wages_page.dart';
import 'finance_bottom_controller.dart';

class FinanceBottomNavigationPage extends StatefulWidget {
  const FinanceBottomNavigationPage({super.key});

  @override
  State<FinanceBottomNavigationPage> createState() =>
      _FinanceBottomNavigationPageState();
}

class _FinanceBottomNavigationPageState
    extends State<FinanceBottomNavigationPage> {
  int _currentIndex = 0;

  Widget switchWidgets(index) {
    switch (index) {
      case 0:
        return const HRDashboard();
      case 1:
        return Container();
      case 2:
        return const CalendarPageAdmin();
      case 3:
        return const WagesPage();
      case 4:
        return const ReportsPageAdmin();
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          backgroundColor: CustomColors.lightBlueColor,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: CustomColors.whiteCardColor,
          unselectedItemColor: CustomColors.whiteCardColor,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          currentIndex: _currentIndex,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          items: List.generate(
            FinanceBottomNavController.bottomNavModelList.length,
            (index) => BottomNavigationBarItem(
              icon: Icon(
                FinanceBottomNavController.bottomNavModelList[index].icon,
                size: 20,
              ),
              label: FinanceBottomNavController.bottomNavModelList[index].label,
            ),
          ),
        ),
        body: switchWidgets(_currentIndex),
      ),
    );
  }
}
