import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/admin/reports/tabs/deduction_tab.dart';
import 'package:paytym/screens/admin/reports/tabs/projects_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    final reportsController = Get.put(ReportsControllerAdmin());
    final reportsTabListAdmin = reportsController.fillReportTab();

    return CustomAdminScaffoldWithTabBar(
      tabList: reportsTabListAdmin,
      title: kReportsString,
      children: [
        Animate(
          effects: const [FadeEffect()],
          child: const ProjectsTabAdmin(),
        ),
        Animate(
          effects: const [FadeEffect()],
          child: const AttendanceTabAdmin(),
        ),
        Animate(
          effects: const [FadeEffect()],
          child: const UploadsTabAdmin(),
        ),
        Animate(
          effects: const [FadeEffect()],
          child: const OvertimeTabAdmin(),
        ),
        if (reportsTabListAdmin.contains('Payroll'))
          Animate(
            effects: const [FadeEffect()],
            child: const PayrollTab(),
          ),
        if (reportsTabListAdmin.contains('Deduction'))
          Animate(
            effects: const [FadeEffect()],
            child: const DeductionTabAdmin(),
          ),
        if (reportsTabListAdmin.contains('Medical'))
          Animate(
            effects: const [FadeEffect()],
            child: const MedicalTabAdmin(),
          ),
        if (reportsTabListAdmin.contains('Contract period'))
          Animate(
            effects: const [FadeEffect()],
            child: const ContractPeriodTabAdmin(),
          ),
      ],
    );
  }
}
