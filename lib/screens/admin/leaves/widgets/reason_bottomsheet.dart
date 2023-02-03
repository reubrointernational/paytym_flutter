import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/admin/leaves/leaves_controller.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/constants/widgets.dart';
import '../../../employee/reports/widgets/bottomsheet_text_field.dart';

class ReasonBottomSheetAdmin extends StatelessWidget {
  const ReasonBottomSheetAdmin({super.key});

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
            kReasonString,
            style:
                kTextStyleS18W600.copyWith(color: CustomColors.blueTextColor),
          ),
          kSizedBoxH10,
          Form(
            key: Get.find<LeavesControllerAdmin>().requestAdvanceFormKey,
            child: Column(
              children: [
                BottomsheetTextField(
                  hintText: kReasonString,
                  maxLines: 8,
                  validator: (value) => Get.find<LeavesControllerAdmin>()
                      .notEmptyValidator(value!),
                  onSaved: (value) => Get.find<LeavesControllerAdmin>()
                      .quitCompanyReason = value!,
                ),
              ],
            ),
          ),
          kSizedBoxH10,
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.blueTextColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                kReasonString,
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
