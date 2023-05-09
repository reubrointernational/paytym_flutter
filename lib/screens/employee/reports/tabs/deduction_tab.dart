import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/employee/reports/reports_controller.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/styles.dart';

class DeductionTab extends StatelessWidget {
  const DeductionTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Get.find<ReportsController>().getDeduction());
    return Obx(() {
      final deductionList = (Get.find<ReportsController>()
                  .deductionResponseModel
                  .value
                  .deductions
                  ?.isEmpty ??
              true) || (Get.find<ReportsController>()
                      .deductionResponseModel
                      .value
                      .deductions
                      ?.first.assignDeduction?.isEmpty??true)
              
          ? []
          : Get.find<ReportsController>()
                  .deductionResponseModel
                  .value
                  .deductions
                  ?.first
                  .assignDeduction ??
              [];
      return Column(
        children: [
          Card(
            color: CustomColors.whiteCardColor,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    kDeductionsString,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Divider(),
                  for (int i = 0; i < deductionList.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            deductionList[i].deduction?.name ?? '',
                            style: kTextStyleS12W600CcustomGrey,
                          ),
                          Text(
                            "\$${Get.find<ReportsController>().formatNumber(deductionList[i].rate?.toString() ?? '0')}",
                            style: kTextStyleS12W600CcustomGrey,
                          ),
                        ],
                      ),
                    ),
                  kSizedBoxH10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        kTotalString,
                        style: kTextStyleS13W600Cblue,
                      ),
                      Text(
                        "\$${Get.find<ReportsController>().getSumDeductionAmount(deductionList)}",
                        style: kTextStyleS13W600Cblue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
