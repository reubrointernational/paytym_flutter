import 'package:get/get.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/login/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paytym/screens/reports/reports_controller.dart';

import '../../core/colors/colors.dart';
import '../../core/constants/enums.dart';
import '../../core/constants/strings.dart';
import '../../core/constants/styles.dart';
import '../widgets/custom_cached_network_image.dart';
import 'widgets/reports_app_bar.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ReportsController reportsController = Get.put(ReportsController());

    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 6, 9, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ReportsAppBar(),
                  kSizedBoxH10,
                  Row(
                    children: [
                      CustomCachedNetworkImage(
                        imageUrl: Get.find<LoginController>()
                                .loginResponseModel
                                ?.employee
                                ?.image ??
                            '',
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
                          Obx(
                            () => Text(
                              '#${reportsController.payslipResponseModel.value.payroll?.userId?.toString().padLeft(7, '0') ?? "4578300"}',
                              style: kTextStyleS13W500Cgrey,
                            ),
                          ),
                          kSizedBoxH4,
                          Obx(
                            () => Text(
                              "$kNetPayString \$${reportsController.payslipResponseModel.value.payroll?.salary}",
                              style: kTextStyleS13W500Cgrey,
                            ),
                          ),
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
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    Obx(
                      () => CupertinoSlidingSegmentedControl(
                        padding: EdgeInsets.zero,
                        backgroundColor: CustomColors.blueTextColor,
                        thumbColor: CustomColors.whiteCardColor,
                        children: {
                          Reports.payslip: SizedBox(
                            width: 100,
                            height: 40,
                            child: Center(
                              child: Text(
                                kPaySlipString,
                                style: reportsController.reportTab.value ==
                                        Reports.payslip
                                    ? kTextStyleS14W600Cblack300LS0p2
                                    : kTextStyleS14W600Cgrey300LS0p2,
                              ),
                            ),
                          ),
                          Reports.deduction: Text(
                            kDeductionString,
                            style: reportsController.reportTab.value ==
                                    Reports.deduction
                                ? kTextStyleS14W600Cblack300LS0p2
                                : kTextStyleS14W600Cgrey300LS0p2,
                          ),
                          Reports.attendance: Text(
                            kAttendanceString,
                            style: reportsController.reportTab.value ==
                                    Reports.attendance
                                ? kTextStyleS14W600Cblack300LS0p2
                                : kTextStyleS14W600Cgrey300LS0p2,
                          ),
                        },
                        groupValue: reportsController.reportTab.value,
                        onValueChanged: (value) =>
                            reportsController.reportTab.value = value!,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
                        child: Obx(
                          () => reportsController.getTab(),
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
    );
  }
}
