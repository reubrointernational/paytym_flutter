import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/admin/reports/reports_controller.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants/widgets.dart';
import '../../../widgets/bordered_text_form_field.dart';

class AddAttendanceBottomSheet extends StatelessWidget {
  const AddAttendanceBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            // key: Get.find<LeavesController>().formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add Attendance',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                kSizedBoxH15,
                BorderedTextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
                  ],
                  // onSaved: (value) => Get.find<LeavesController>()
                  //     .leaveRequestModel
                  //     .startDate = value,
                  // controller:
                  //     Get.find<LeavesController>().startDateController,
                  hintText: 'Date',
                  keyboardType: TextInputType.datetime,
                  suffixIcon: GestureDetector(
                    onTap: () => Get.find<ReportsControllerAdmin>()
                        .selectDateTime(context),
                    child: const Icon(Icons.calendar_month, size: 18),
                  ),
                  // validator: (value) =>
                  // Get.find<LeavesController>().dateValidator(value!),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: (() async {
                            TimeOfDay? selectedTime = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());

                            // Get.find<LeavesController>().startTimeController.text =
                            //     Get.find<CalendarControllerAdmin>()
                            //         .formatTimeOfDay(selectedTime);
                          }),
                          child: BorderedTextFormField(
                            enabled: false,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9-]'),
                              ),
                            ],

                            // controller:
                            //     Get.find<LeavesController>().startTimeController,
                            hintText: 'Check In Time',
                            keyboardType: TextInputType.datetime,
                            suffixIcon: const Icon(
                              Icons.access_time,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      kSizedBoxW10,
                      Expanded(
                        child: GestureDetector(
                          onTap: (() async {
                            TimeOfDay? selectedTime = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());

                            // Get.find<LeavesController>().startTimeController.text =
                            //     Get.find<CalendarControllerAdmin>()
                            //         .formatTimeOfDay(selectedTime);
                          }),
                          child: BorderedTextFormField(
                            enabled: false,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9-]'),
                              ),
                            ],

                            // controller:
                            //     Get.find<LeavesController>().startTimeController,
                            hintText: 'Check Out Time',
                            keyboardType: TextInputType.datetime,
                            suffixIcon: const Icon(
                              Icons.access_time,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          kSizedBoxH6,
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Get.find<LeavesController>().validateAndApplyForLeave();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.blueCardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Submit',
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
