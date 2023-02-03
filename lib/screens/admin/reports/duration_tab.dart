import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/styles.dart';
import '../../../core/constants/widgets.dart';
import 'reports_controller.dart';
import 'widgets/medical_card_column.dart';

class DurationTabAdmin extends StatelessWidget {
  const DurationTabAdmin({Key? key}) : super(key: key);

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
            child: Row(
              children: const [
                Expanded(
                  flex: 2,
                  child: MedicalCardColumn(
                    branch: 'Branch',
                    name: 'Akhil Reubro',
                    heading: 'Employment Period',
                    condition: '',
                  ),
                ),
                Expanded(
                  child: MedicalCardColumn(
                    isNameGrey: true,
                    isHeadingBlue: true,
                    branch: '',
                    name: '004578',
                    heading: '6 Months',
                    condition: '',
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
