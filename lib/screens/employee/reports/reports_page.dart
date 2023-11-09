import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/employee/reports/tabs/loan_tab.dart';
import 'package:paytym/screens/employee/reports/tabs/my_files_tab.dart';
import 'package:paytym/screens/employee/reports/tabs/projects_tab.dart';
import 'package:paytym/screens/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:paytym/screens/employee/reports/reports_controller.dart';
import 'package:paytym/screens/widgets/custom_tab_bar.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../core/constants/styles.dart';
import '../../../network/end_points.dart';
import '../../widgets/custom_cached_network_image.dart';
import 'tabs/attendance_tab.dart';
import 'tabs/deduction_tab.dart';
import 'tabs/medical_tab.dart';
import 'tabs/overtime_tab.dart';
import 'tabs/payslip_tab.dart';
import 'tabs/split_payment_tab.dart';
import 'widgets/reports_app_bar.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ReportsController());

    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: DefaultTabController(
        length: reportsTabList.length,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 6, 9, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ReportsAppBar(),
                    kSizedBoxH10,
                    Row(
                      children: [
                        CustomCachedNetworkImage(
                          imageUrl:
                              '$kStorageUrl${Get.find<LoginController>().loginResponseModel?.employee?.image}',
                          radius: 26,
                        ),
                        kSizedBoxW10,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${Get.find<LoginController>().loginResponseModel?.employee?.firstName ?? ''} ${Get.find<LoginController>().loginResponseModel?.employee?.lastName ?? ''}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: CustomColors.blueTextColor,
                              ),
                            ),
                            kSizedBoxH4,
                            Text(
                              '#${Get.find<LoginController>().loginResponseModel?.employee?.id?.toString().padLeft(5, '0') ?? "#00000"}',
                              style: kTextStyleS13W500Cgrey,
                            ),
                            // kSizedBoxH4,
                            // Text(
                            //   "$kNetPayString \$${Get.find<LoginController>().loginResponseModel?.employee?.rate} ${Get.find<LoginController>().loginResponseModel?.employee?.salaryType == '0' ? '/month' : '/hour'}",
                            //   style: kTextStyleS13W500Cgrey,
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: CustomColors.calendarPageBackgroundColor,
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: CustomTabBar(
                          tabsList: reportsTabList,
                          color: CustomColors.blueCardColor,
                          width: 20,
                        ),
                      ),
                      /*Row(
                        children: [
                          Obx(() {
                            return CustomDropdownYearButton(
                              lists: years,
                              value:
                                  reportsController.selectedDropdownYear.value,
                              onChanged: (value) {
                                reportsController.selectedDropdownYear.value =
                                    value!;
                              },
                              hint: 'years',
                            );
                          }),
                          Expanded(
                            child: CustomTabBar(
                              tabsList: monthsTabList,
                              backgroundColor: CustomColors.blueCardColor,
                              width: 20,
                              swapBlackWhiteText: true,
                            ),
                          ),
                        ],
                      ),*/
                      Expanded(
                        flex: 10,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                          child: TabBarView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              Animate(
                                effects: const [FadeEffect()],
                                child: const AttendanceTab(),
                              ),
                              Animate(
                                effects: const [FadeEffect()],
                                child: const OvertimeTab(),
                              ),
                              Animate(
                                effects: const [FadeEffect()],
                                child: const LoanTab(),
                              ),
                              Animate(
                                effects: const [FadeEffect()],
                                child: const SplitPaymentTab(),
                              ),
                              Animate(
                                effects: const [FadeEffect()],
                                child: const DeductionTab(),
                              ),
                              Animate(
                                effects: const [FadeEffect()],
                                child: const PayslipTab(),
                              ),
                              Animate(
                                  effects: const [FadeEffect()],
                                  child: const MyFilesTab()),
                              Animate(
                                  effects: const [FadeEffect()],
                                  child: const ProjectsTab()),
                              Animate(
                                effects: const [FadeEffect()],
                                child: const MedicalTab(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
