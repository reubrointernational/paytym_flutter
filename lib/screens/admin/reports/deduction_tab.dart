import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/employee/reports/reports_controller.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../core/constants/styles.dart';
import 'reports_controller.dart';

class DeductionTabAdmin extends StatelessWidget {
  const DeductionTabAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Get.find<ReportsControllerAdmin>().getDeduction());
    return Obx(
      () => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: Get.find<ReportsControllerAdmin>()
                .deductionResponseModel
                .value
                .deductions
                ?.length ??
            0,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  Get.find<ReportsControllerAdmin>().getDate(
                      Get.find<ReportsControllerAdmin>()
                              .deductionResponseModel
                              .value
                              .deductions
                              ?.first
                              .createdAt! ??
                          '2022-09-01'),
                  style: kTextStyleS13W600CustomGrey,
                ),
              ),
              Container(
                height: 180,
                padding: const EdgeInsets.only(top: 8, bottom: 10),
                child: Card(
                  color: CustomColors.whiteCardColor,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          kDeductionsString,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              kFundDeductionsString,
                              style: kTextStyleS12W600CcustomGrey,
                            ),
                            Text(
                              "\$${Get.find<ReportsControllerAdmin>().formatNumber(Get.find<ReportsControllerAdmin>().deductionResponseModel.value.deductions?.first.fundDeduction ?? '0')}",
                              style: kTextStyleS12W600CcustomGrey,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              kProfessionalTaxString,
                              style: kTextStyleS12W600CcustomGrey,
                            ),
                            Text(
                              "\$${Get.find<ReportsControllerAdmin>().formatNumber(Get.find<ReportsControllerAdmin>().deductionResponseModel.value.deductions?.first.pTax ?? '0')}",
                              style: kTextStyleS12W600CcustomGrey,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                kTotalString,
                                style: kTextStyleS13W600Cblue,
                              ),
                              Text(
                                "\$${Get.find<ReportsControllerAdmin>().formatNumber(Get.find<ReportsControllerAdmin>().deductionResponseModel.value.deductions?.first.totalDeduction ?? '0')}",
                                style: kTextStyleS13W600Cblue,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
