import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/constants/styles.dart';
import '../reports_controller.dart';

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
              
              Container(
                height: 150,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(15),
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
                            style: kTextStyleS13W600Cblue.copyWith(color: Colors.lightBlue),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
