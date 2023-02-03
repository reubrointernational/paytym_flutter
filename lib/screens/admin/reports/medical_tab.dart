import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/widgets.dart';
import '../../../core/colors/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../core/constants/styles.dart';
import 'reports_controller.dart';
import 'widgets/medical_card_column.dart';

class MedicalTabAdmin extends StatelessWidget {
  const MedicalTabAdmin({Key? key}) : super(key: key);

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
                    heading: 'Medical Condition',
                    condition: 'Hypertension,\nDepression',
                  ),
                ),
                Expanded(
                  child: MedicalCardColumn(
                    isNameGrey: true,
                    branch: '',
                    name: '004578',
                    heading: 'Medication',
                    condition: 'Medicines\n',
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
