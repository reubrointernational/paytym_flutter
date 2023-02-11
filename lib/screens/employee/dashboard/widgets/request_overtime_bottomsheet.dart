import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/employee/dashboard/dashboard_controller.dart';
import 'package:paytym/screens/employee/reports/reports_controller.dart';
import 'package:paytym/screens/employee/reports/widgets/bottomsheet_text_field.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/constants/widgets.dart';
import '../../leaves/leaves_controller.dart';

class RequestOvertimeBottomsheet extends StatelessWidget {
  const RequestOvertimeBottomsheet({super.key});
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
            kRequestOvertimeString,
            style:
                kTextStyleS18W600.copyWith(color: CustomColors.blueTextColor),
          ),
          kSizedBoxH10,
          Form(
            key: Get.find<DashboardController>().requestAdvanceFormKey,
            child: Column(
              children: [
                //todo change onsaved, validation messages etc to suit overtime
                BottomsheetTextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
                  ],
                  hintText: kStartDateString,
                  keyboardType: TextInputType.datetime,
                  suffixIcon: GestureDetector(
                    onTap: () => Get.find<LeavesController>()
                        .selectDateTime(context, true),
                    child: const Icon(Icons.calendar_month, size: 18),
                  ),
                  validator: (value) =>
                      Get.find<DashboardController>().dateValidator(value!),
                  // onSaved: (value) => Get.find<DashboardController>()
                  //     .requestAdvanceModel
                  //     .amount = value!,
                ),
                kSizedBoxH10,
                BottomsheetTextField(
                  hintText: kStartTimeString,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  // validator: (value) =>
                  //     Get.find<ReportsController>().amountValidator(value!),
                  // onSaved: (value) => Get.find<DashboardController>()
                  //     .requestAdvanceModel
                  //     .amount = value!,
                ),
                kSizedBoxH10,
                BottomsheetTextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
                  ],
                  hintText: kEndDateString,
                  keyboardType: TextInputType.datetime,
                  suffixIcon: GestureDetector(
                    onTap: () => Get.find<LeavesController>()
                        .selectDateTime(context, true),
                    child: const Icon(Icons.calendar_month, size: 18),
                  ),
                  validator: (value) =>
                      Get.find<DashboardController>().dateValidator(value!),
                  // onSaved: (value) => Get.find<DashboardController>()
                  //     .requestAdvanceModel
                  //     .amount = value!,
                ),
                kSizedBoxH10,
                BottomsheetTextField(
                  hintText: kEndTimeString,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  // validator: (value) =>
                  //     Get.find<DashboardController>().reasonValidator(value!),
                  // onSaved: (value) => Get.find<DashboardController>()
                  //     .requestAdvanceModel
                  //     .description = value!,
                ),
                kSizedBoxH10,
                BottomsheetTextField(
                  maxLines: 3,
                  maxLength: 80,
                  hintText: kReasonString,
                  validator: (value) =>
                      Get.find<DashboardController>().reasonValidator(value!),
                  onSaved: (value) => Get.find<DashboardController>()
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
              onPressed: () => Get.find<DashboardController>().requestAdvance(),
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.blueTextColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                kRequestOvertimeString,
                style: TextStyle(
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
