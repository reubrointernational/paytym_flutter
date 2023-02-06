import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/styles.dart';
import 'reports_controller.dart';
import 'widgets/medical_title_tag.dart';

class ContractPeriodTabAdmin extends StatelessWidget {
  const ContractPeriodTabAdmin({Key? key}) : super(key: key);

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
          return Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const MedicalTitleTag(
                  branch: 'Branch',
                  name: 'Akhil Reubro',
                  employmentId: '0045786',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Employment Period',
                        style: kTextStyleS14C255140x3.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                    Text('6 months',
                        style: kTextStyleS14C255140x3.copyWith(
                            color: Colors.lightBlue)),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
