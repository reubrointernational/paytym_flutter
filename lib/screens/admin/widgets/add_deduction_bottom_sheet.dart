import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/constants/widgets.dart';
import '../../login/widgets/custom_text_form_field.dart';
import '../reports/reports_controller.dart';

class AddDeductionBottomSheet extends StatelessWidget {
  const AddDeductionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      child: Form(
        key: Get.find<ReportsControllerAdmin>().formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFormField(
              hintText: 'Title',
              validator: (value) =>
                  value!.isEmpty ? 'Title field should not be empty' : null,
              onSaved: (value) {
                Get.find<ReportsControllerAdmin>()
                    .deductionAddRequestModel
                    .name = value!;
              },
            ),
            kSizedBoxH6,
            CustomTextFormField(
              hintText: 'Amount',
              onSaved: (value) {
                Get.find<ReportsControllerAdmin>()
                    .deductionAddRequestModel
                    .amount = value!;
              },
              inputType: TextInputType.number,
              validator: (value) =>
                  Get.find<ReportsControllerAdmin>().amountValidator(value!),
            ),
            kSizedBoxH6,
            CustomTextFormField(
              hintText: 'Percentage',
              inputType: TextInputType.number,
              onSaved: (value) {
                Get.find<ReportsControllerAdmin>()
                    .deductionAddRequestModel
                    .percentage = value!;
              },
              validator: (value) {
                try {
                  return int.parse(value!) > 100 || int.parse(value) < 0
                      ? 'Enter a value between 0 to 100'
                      : null;
                } catch (e) {
                  return 'Enter a value between 0 to 100';
                }
              },
            ),
            kSizedBoxH6,
            CustomTextFormField(
              hintText: 'Description',
              maxLines: 5,
              onSaved: (value) {
                Get.find<ReportsControllerAdmin>()
                    .deductionAddRequestModel
                    .description = value!;
              },
              validator: (value) => value!.isEmpty
                  ? 'Description field should not be empty'
                  : null,
            ),
            kSizedBoxH15,
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    Get.find<ReportsControllerAdmin>().createDeduction();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.lightBlueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: const Text(
                    'Add Deduction',
                    style: TextStyle(fontSize: 16),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
