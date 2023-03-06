import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/admin/reports/tabs/deduction_tab.dart';
import 'package:paytym/screens/admin/reports/tabs/projects_tab.dart';
import 'package:paytym/screens/login/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paytym/screens/employee/reports/reports_controller.dart';
import 'package:paytym/screens/widgets/custom_tab_bar.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/enums.dart';
import '../../../core/constants/strings.dart';
import '../../../core/constants/styles.dart';
import '../../widgets/custom_cached_network_image.dart';
import '../widgets/custom_admin_scaffold_with_tabbar.dart';
import '../leaves/leaves_controller.dart';
import '../leaves/leaves_tab.dart';
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
    Get.put(ReportsControllerAdmin());
    return CustomAdminScaffoldWithTabBar(
      tabList: reportsTabListAdmin,
      title: kReportsString,
      children: [
        Animate(effects: const [FadeEffect()], child: const UploadsTabAdmin()),
        Animate(
          effects: const [FadeEffect()],
          child: const PayrollTab(),
        ),
        Animate(
          effects: const [FadeEffect()],
          child: const OvertimeTabAdmin(),
        ),
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
          child: const DeductionTabAdmin(),
        ),
        Animate(
          effects: const [FadeEffect()],
          child: const MedicalTabAdmin(),
        ),
        Animate(
          effects: const [FadeEffect()],
          child: const ContractPeriodTabAdmin(),
        ),
      ],
    );
  }
}
