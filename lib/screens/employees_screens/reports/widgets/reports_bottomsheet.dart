import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/login/login_controller.dart';
import 'package:paytym/screens/employees_screens/reports/reports_controller.dart';
import 'package:paytym/screens/employees_screens/reports/widgets/bottomsheet_text_field.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/constants/widgets.dart';

class ReportsBottomsheet extends StatelessWidget {
  final bool isSalary;
  const ReportsBottomsheet({super.key, required this.isSalary});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      padding: const EdgeInsets.all(28),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            !isSalary ? kRequestAdvanceString : kRequestPaymentString,
            style:
                kTextStyleS18W600.copyWith(color: CustomColors.blueTextColor),
          ),
          kSizedBoxH10,
          Form(
            key: Get.find<ReportsController>().requestAdvanceFormKey,
            child: Column(
              children: [
                BottomsheetTextField(
                  text:
                      '${Get.find<LoginController>().loginResponseModel?.employee?.firstName} ${Get.find<LoginController>().loginResponseModel?.employee?.lastName}',
                  enabled: false,
                ),
                kSizedBoxH10,
                BottomsheetTextField(
                  hintText: kAmountString,
                  enabled: !isSalary,
                  text: isSalary
                      ? Get.find<ReportsController>()
                          .payslipResponseModel
                          .value
                          .payroll
                          ?.salary
                      : null,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) =>
                      Get.find<ReportsController>().amountValidator(value!),
                  onSaved: (value) => Get.find<ReportsController>()
                      .requestAdvanceModel
                      .amount = value!,
                ),
                kSizedBoxH10,
                BottomsheetTextField(
                  hintText: kDescString,
                  text: isSalary ? kSalaryString : null,
                  enabled: !isSalary,
                  validator: (value) => Get.find<ReportsController>()
                      .descriptionValidator(value!),
                  onSaved: (value) => Get.find<ReportsController>()
                      .requestAdvanceModel
                      .description = value!,
                ),
              ],
            ),
          ),
          kSizedBoxH10,
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => !isSalary
                  ? Get.find<ReportsController>().requestAdvance()
                  : Get.find<ReportsController>().requestPayment(),
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.blueTextColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                isSalary ? kRequestPaymentString : kRequestAdvanceString,
                style: const TextStyle(
                  color: CustomColors.whiteTextColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
