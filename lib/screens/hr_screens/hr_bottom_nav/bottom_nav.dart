import 'package:flutter/material.dart';
import 'package:paytym/screens/hr_screens/chat/chat_lists.dart';
import 'package:paytym/screens/hr_screens/dashboard/employees_list.dart';
import 'package:paytym/screens/hr_screens/hr_bottom_nav/bottom_nav_controller.dart';
import 'package:paytym/screens/hr_screens/dashboard/hr_dashboard.dart';

import '../../../core/colors/colors.dart';

class HRBottomNavigationPage extends StatefulWidget {
  const HRBottomNavigationPage({super.key});

  @override
  State<HRBottomNavigationPage> createState() => _HRBottomNavigationPageState();
}

class _HRBottomNavigationPageState extends State<HRBottomNavigationPage> {
  int _currentIndex = 0;

  Widget switchWidgets(index) {
    switch (index) {
      case 0:
        return const HRDashboard();
      case 1:
        return Container();
      case 2:
        return Container();
      case 3:
        return const HRChatLists();
      case 4:
        return Container();
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      bottomNavigationBar: BottomNavigationBar(
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
    );
  }
}
