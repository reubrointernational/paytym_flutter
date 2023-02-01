import 'package:flutter/material.dart';
import 'package:paytym/screens/admin/leaves/leaves_page.dart';

import '../../../core/colors/colors.dart';
import '../../employee/bottom_nav/bottom_nav_controller.dart';

class BottomNavigationPageAdmin extends StatefulWidget {
  const BottomNavigationPageAdmin({super.key});

  @override
  State<BottomNavigationPageAdmin> createState() => _BottomNavigationPageAdminState();
}

class _BottomNavigationPageAdminState extends State<BottomNavigationPageAdmin> {
  int _currentIndex = 0;

  Widget switchWidgets(index) {
    switch (index) {
      case 0:
        return const LeavesPageAdmin();
      case 1:
        return Container();
      case 2:
        return Container();
      case 3:
        return Container();
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
