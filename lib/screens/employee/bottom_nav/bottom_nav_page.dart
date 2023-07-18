import 'package:get/get.dart';
import 'package:paytym/screens/employee/leaves/leaves_page.dart';
import 'package:paytym/screens/employee/reports/reports_page.dart';
import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';
import '../../../core/dialog_helper.dart';
import '../../../logout_controller.dart';
import '../calendar/calendar_page.dart';
import '../chats/chat_group_listing.dart';
import '../dashboard/dashboard.dart';
import 'bottom_nav_controller.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _currentIndex = 0;

  @override
  void initState() {
    //init inactivity timer
    Get.find<LogoutController>().initTimer();
    super.initState();
  }

  Widget switchWidgets(index) {
    switch (index) {
      case 0:
        return const DashboardPage();
      case 1:
        return const LeavesPage();
      case 2:
        return const CalendarPage();
      case 3:
        return const ChatListingPage();
      case 4:
        return const ReportsPage();
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: CustomColors.bottomNavSelectedItemColor,
          unselectedItemColor: CustomColors.bottomNavUnselectedItemColor,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          currentIndex: _currentIndex,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          items: List.generate(
            BottomNavController.bottomNavModelList.length,
            (index) => BottomNavigationBarItem(
              icon: Icon(
                BottomNavController.bottomNavModelList[index].icon,
                size: 20,
              ),
              label: BottomNavController.bottomNavModelList[index].label,
            ),
          ),
        ),
        body: switchWidgets(_currentIndex),
      ),
    );
  }
}
