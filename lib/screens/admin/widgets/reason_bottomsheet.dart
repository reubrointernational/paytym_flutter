import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/admin/leaves/leaves_controller.dart';
import 'package:paytym/screens/admin/reports/reports_controller.dart';
import 'package:paytym/screens/employee/leaves/leaves_controller.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/enums.dart';
import '../../../core/constants/strings.dart';
import '../../../core/constants/styles.dart';
import '../../../core/constants/widgets.dart';
import '../../employee/reports/widgets/bottomsheet_text_field.dart';
import '../../widgets/bordered_text_form_field.dart';

class ReasonBottomSheetAdmin extends StatelessWidget {
  final ReasonButton reasonButton;
  const ReasonBottomSheetAdmin(
      {super.key, this.reasonButton = ReasonButton.leaveApprove});

  @override
  Widget build(BuildContext context) {
    Get.put(LeavesController());
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      padding: const EdgeInsets.all(28),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Form(
        key: Get.find<LeavesControllerAdmin>().requestAdvanceFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: reasonButton.name == 'attendanceEdit' ? true : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() {
                    return CustomTimePicker(
                      title: "Check in time:",
                      hintText: 'Check In',
                      label: Get.find<ReportsControllerAdmin>()
                          .editAttendanceCheckInTime
                          .value,
                      onTap: (() async {
                        TimeOfDay? selectedTime = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now());
                        print(selectedTime!.format(context));
                        Get.find<ReportsControllerAdmin>()
                            .editAttendanceCheckInTime
                            .value = selectedTime.format(context).toString();
                      }),
                    );
                  }),
                  kSizedBoxH4,
                  Obx(() {
                    return CustomTimePicker(
                      title: "Check out time:",
                      hintText: 'Check Out',
                      label: Get.find<ReportsControllerAdmin>()
                          .editAttendanceCheckOutTime
                          .value,
                      onTap: (() async {
                        TimeOfDay? selectedTime = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now());
                        print(selectedTime!.format(context).toString());
                        Get.find<ReportsControllerAdmin>()
                            .editAttendanceCheckOutTime
                            .value = selectedTime.format(context).toString();
                      }),
                    );
                  }),
                ],
              ),
            ),
            kSizedBoxH6,
            Text(
              kReasonString,
              style:
                  kTextStyleS18W600.copyWith(color: CustomColors.blueTextColor),
            ),
            kSizedBoxH10,
            Column(
              children: [
                BottomsheetTextField(
                  hintText: kReasonString,
                  maxLines: 8,
                  validator: (value) => Get.find<LeavesControllerAdmin>()
                      .notEmptyValidator(value!),
                  onSaved: (value) {
                    Get.find<LeavesControllerAdmin>().quitCompanyReason =
                        value!;
                    Get.find<ReportsControllerAdmin>()
                        .editAttendanceReason
                        .value = value;
                  },
                ),
              ],
            ),
            kSizedBoxH10,
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (Get.find<LeavesControllerAdmin>()
                      .requestAdvanceFormKey
                      .currentState!
                      .validate()) {
                    Get.find<LeavesControllerAdmin>()
                        .requestAdvanceFormKey
                        .currentState!
                        .save();

                    if (reasonButton.name != 'attendanceEdit') {
                      reasonButton.name.contains('leave')
                          ? Get.find<LeavesControllerAdmin>()
                              .approveOrDeclineLeave(reasonButton)
                          : Get.find<ReportsControllerAdmin>()
                              .approveOrDeclineAttendance(reasonButton);
                    } else {
                      Get.find<ReportsControllerAdmin>().updateAttendance();
                    }
                    
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.blueTextColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  reasonButton.name.contains(RegExp('App|attendanceEdit'))
                      ? 'Approve'
                      : 'Decline',
                  style: const TextStyle(
                    color: CustomColors.whiteTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*return Container(
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
              onPressed: () {
                reasonButton.name.contains('leave')
                    ? Get.find<LeavesControllerAdmin>().approveOrDeclineLeave(reasonButton)
                    : Get.find<ReportsControllerAdmin>().approveOrDeclineAttendance(reasonButton);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.blueTextColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                reasonButton.name.contains('App') ? 'Approve' : 'Decline',
                style: const TextStyle(
                  color: CustomColors.whiteTextColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );*/
}

class CustomTimePicker extends StatelessWidget {
  final String? title;
  final String? hintText;
  final String? label;
  final void Function()? onTap;
  const CustomTimePicker({
    super.key,
    this.title,
    this.hintText,
    this.onTap,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title!,
          style: const TextStyle(
            color: CustomColors.blueTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        kSizedBoxH4,
        GestureDetector(
          onTap: onTap,
          child: SizedBox(
            width: w * 0.4,
            child: BorderedTextFormField(
              enabled: false,
              label: label,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'[0-9-]'),
                ),
              ],
              /*onSaved: (value) => Get.find<LeavesController>()
                  .leaveRequestModel
                  .startDate = value,*/
              controller:
                  Get.find<ReportsControllerAdmin>().checkInTimeController,
              hintText: hintText!,
              keyboardType: TextInputType.datetime,
              suffixIcon: const Icon(
                Icons.access_time,
                size: 18,
              ),
              /*validator: (value) =>
                  Get.find<LeavesController>().dateValidator(value!),*/
            ),
          ),
        ),
      ],
    );
  }
}
