import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/admin/leaves/leaves_page.dart';
import 'package:paytym/screens/login/login_controller.dart';

import '../../../core/colors/colors.dart';
import '../../employee/bottom_nav/bottom_nav_controller.dart';
import '../calendar/calendar_page.dart';
import '../chat/chat_listing_page.dart';
import '../dashboard/dashboard_admin.dart';
import '../reports/reports_page.dart';

class BottomNavigationPageAdmin extends StatefulWidget {
  const BottomNavigationPageAdmin({super.key});

  @override
  State<BottomNavigationPageAdmin> createState() =>
      _BottomNavigationPageAdminState();
}

class _BottomNavigationPageAdminState extends State<BottomNavigationPageAdmin> {
  Widget switchWidgets(index) {
    switch (index) {
      case 0:
        return const DashboardAdmin();
      case 1:
        return const LeavesPageAdmin();
      case 2:
        return const CalendarPageAdmin();
      case 3:
        return const ChatListingPageAdmin();
      case 4:
        return const ReportsPageAdmin();
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<LoginController>().bottomNavigationAdminIndex.value = 0;
        return false;
      },
      child: Obx(() => Scaffold(
            backgroundColor: CustomColors.backgroundColor,
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0,
              backgroundColor: CustomColors.lightBlueColor,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.red,
              unselectedItemColor: CustomColors.whiteCardColor,
              selectedFontSize: 10,
              unselectedFontSize: 10,
              currentIndex:
                  Get.find<LoginController>().bottomNavigationAdminIndex.value,
              onTap: (value) {
                Get.find<LoginController>().bottomNavigationAdminIndex.value =
                    value;
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
            body: switchWidgets(
                Get.find<LoginController>().bottomNavigationAdminIndex.value),
          )),
    );
  }
}
