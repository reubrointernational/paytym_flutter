import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/styles.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/routes/app_routes.dart';

import 'package:paytym/screens/widgets/custom_tab_bar.dart';

import '../widgets/floating_action_button.dart';
import 'attendance_tab.dart';
import 'deductions_tab.dart';
import 'employment_period_tab.dart';
import 'medical_tab.dart';
import 'projects_tab.dart';

class HRReportsPage extends StatefulWidget {
  const HRReportsPage({super.key});

  @override
  State<HRReportsPage> createState() => _HRReportsPageState();
}

class _HRReportsPageState extends State<HRReportsPage>
    with TickerProviderStateMixin {
  late TabController controller = TabController(length: 7, vsync: this);

  @override
  Widget build(BuildContext context) {
    final List<String> tabsList = [
      'Projects',
      'Attendance',
      'Deductions',
      'Employment Period',
      'Medical',
      'Status',
      'Superannual & Tax',
    ];
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      floatingActionButton: const CustomFloatingActionButton(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Reports',
                  style: kTextStyleS18W600,
                ),
                GestureDetector(
                    onTap: () => Get.toNamed(Routes.settings),
                    child: const Icon(Icons.settings)),
              ],
            ),
            kSizedBoxH15,
            CustomTabBar(
              
              tabsList: tabsList,
              backgroundColor: CustomColors.blueTextColor,
              width: 20,
              swapBlackWhiteText: true,
            ),
            kSizedBoxH10,
            Expanded(
              child: TabBarView(
                physics: const BouncingScrollPhysics(),
                controller: controller,
                children: [
                  const EmployeeProjectsTab(),
                  const EmployeeAttendanceTab(),
                  const EmployeesDeductionTab(),
                  const EmployeesEmploymentPeriod(),
                  const EmployeesMedicalTab(),
                  Container(),
                  Container(),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
