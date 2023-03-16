import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/admin/reports/tabs/deduction_tab.dart';
import 'package:paytym/screens/admin/reports/tabs/projects_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paytym/screens/login/login_controller.dart';

import '../../../core/constants/strings.dart';
import '../widgets/custom_admin_scaffold_with_tabbar.dart';
import 'tabs/attendance_tab.dart';
import 'tabs/contract_period_tab.dart';
import 'tabs/medical_tab.dart';
import 'reports_controller.dart';
import 'tabs/payroll_tab.dart';
import 'tabs/overtime_tab.dart';
import 'tabs/uploads_tab.dart';

class ReportsPageAdmin extends StatelessWidget {
  const ReportsPageAdmin({Key? key}) : super(key: key);

  getList() {
    final list = [];
    if ((Get.find<LoginController>()
            .loginResponseModel
            ?.capabilities?.isNotEmpty??false)){
if (Get.find<LoginController>()
              .loginResponseModel
              ?.capabilities
              ?.first
              .viewPayroll ==
          1) {
        list.add(Animate(
          effects: const [FadeEffect()],
          child: const PayrollTab(),
        ));
      }
      if (Get.find<LoginController>()
              .loginResponseModel
              ?.capabilities
              ?.first
              .projects ==
          1) {
        list.add(Animate(
          effects: const [FadeEffect()],
          child: const ProjectsTabAdmin(),
        ));
      }
      if (Get.find<LoginController>()
              .loginResponseModel
              ?.capabilities
              ?.first
              .attendance ==
          1) {
        list.add(Animate(
          effects: const [FadeEffect()],
          child: const AttendanceTabAdmin(),
        ));
      }
      if (Get.find<LoginController>()
              .loginResponseModel
              ?.capabilities
              ?.first
              .deductions ==
          1) {
        list.add(Animate(
          effects: const [FadeEffect()],
          child: const DeductionTabAdmin(),
        ));
      }
      if (Get.find<LoginController>()
              .loginResponseModel
              ?.capabilities
              ?.first
              .medical ==
          1) {
        list.add(Animate(
          effects: const [FadeEffect()],
          child: const MedicalTabAdmin(),
        ));
      }
      if (Get.find<LoginController>()
              .loginResponseModel
              ?.capabilities
              ?.first
              .contractPeriod ==
          1) {
        list.add(Animate(
          effects: const [FadeEffect()],
          child: const ContractPeriodTabAdmin(),
        ));
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ReportsControllerAdmin());
    if (Get.find<LoginController>()
            .loginResponseModel
            ?.capabilities
            ?.isNotEmpty ??
        false) {
if (Get.find<LoginController>()
              .loginResponseModel
              ?.capabilities
              ?.first
              .viewPayroll ==
          1) {
        reportsTabListAdmin.add('Payroll');
      }
      if (Get.find<LoginController>()
              .loginResponseModel
              ?.capabilities
              ?.first
              .projects ==
          1) {
        reportsTabListAdmin.add('Projects');
      }
      if (Get.find<LoginController>()
              .loginResponseModel
              ?.capabilities
              ?.first
              .attendance ==
          1) {
        reportsTabListAdmin.add('Attendance');
      }
      if (Get.find<LoginController>()
              .loginResponseModel
              ?.capabilities
              ?.first
              .deductions ==
          1) {
        reportsTabListAdmin.add('Deduction');
      }
      if (Get.find<LoginController>()
              .loginResponseModel
              ?.capabilities
              ?.first
              .medical ==
          1) {
        reportsTabListAdmin.add('Medical');
      }
      if (Get.find<LoginController>()
              .loginResponseModel
              ?.capabilities
              ?.first
              .contractPeriod ==
          1) {
        reportsTabListAdmin.add('Contract period');
      }
    }
    
    return CustomAdminScaffoldWithTabBar(
      tabList: reportsTabListAdmin,
      title: kReportsString,
      children: [
        Animate(effects: const [FadeEffect()], child: const UploadsTabAdmin()),
        // Animate(
        //   effects: const [FadeEffect()],
        //   child: const PayrollTab(),
        // ),
        Animate(
          effects: const [FadeEffect()],
          child: const OvertimeTabAdmin(),
        ),

        ...getList(),
        // Animate(
        //   effects: const [FadeEffect()],
        //   child: const ProjectsTabAdmin(),
        // ),
        // Animate(
        //   effects: const [FadeEffect()],
        //   child: const AttendanceTabAdmin(),
        // ),
        // Animate(
        //   effects: const [FadeEffect()],
        //   child: const DeductionTabAdmin(),
        // ),
        // Animate(
        //   effects: const [FadeEffect()],
        //   child: const MedicalTabAdmin(),
        // ),
        // Animate(
        //   effects: const [FadeEffect()],
        //   child: const ContractPeriodTabAdmin(),
        // ),
      ],
    );
  }
}
