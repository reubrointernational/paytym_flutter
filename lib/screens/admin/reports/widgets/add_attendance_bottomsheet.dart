import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/admin/reports/reports_controller.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants/widgets.dart';
import '../../../../models/employee_list_model.dart';
import '../../../widgets/bordered_text_form_field.dart';

class AddAttendanceBottomSheet extends StatelessWidget {
  final EmployeeList employee;
  const AddAttendanceBottomSheet({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    Get.find<ReportsControllerAdmin>().endTimeController.text = '';
    Get.find<ReportsControllerAdmin>().startTimeController.text = '';
    Get.find<ReportsControllerAdmin>().attendanceHrDateController.text = '';

    Get.find<ReportsControllerAdmin>().attendanceHrRequestModel.employeeId =
        employee.id.toString();
    Get.find<ReportsControllerAdmin>().attendanceHrRequestModel.employerId =
        employee.employerId.toString();
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: Get.find<ReportsControllerAdmin>().attendanceformKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
              onSaved: (value) => Get.find<ReportsControllerAdmin>()
                  .attendanceHrRequestModel
                  .date = () {
                List<String> dateComponents = value!.split('-');
                return '${dateComponents[2]}-${dateComponents[1]}-${dateComponents[0]}';
              }(),
              controller:
                  Get.find<ReportsControllerAdmin>().attendanceHrDateController,
              hintText: 'Date',
              keyboardType: TextInputType.datetime,
              suffixIcon: GestureDetector(
                onTap: () =>
                    Get.find<ReportsControllerAdmin>().showDatePick(context),
                child: const Icon(Icons.calendar_month, size: 18),
              ),
              validator: (value) =>
                  Get.find<ReportsControllerAdmin>().dateValidator(value!),
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

                        Get.find<ReportsControllerAdmin>()
                                .startTimeController
                                .text =
                            Get.find<ReportsControllerAdmin>()
                                .formatTimeOfDay(selectedTime);
                      }),
                      child: BorderedTextFormField(
                        enabled: false,
                        onSaved: (value) => Get.find<ReportsControllerAdmin>()
                            .attendanceHrRequestModel
                            .checkInTime = value,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9-]'),
                          ),
                        ],
                        controller: Get.find<ReportsControllerAdmin>()
                            .startTimeController,
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
                        Get.find<ReportsControllerAdmin>()
                                .endTimeController
                                .text =
                            Get.find<ReportsControllerAdmin>()
                                .formatTimeOfDay(selectedTime);
                      }),
                      child: BorderedTextFormField(
                        enabled: false,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9-]'),
                          ),
                        ],
                        onSaved: (value) => Get.find<ReportsControllerAdmin>()
                            .attendanceHrRequestModel
                            .checkOutTime = value,
                        controller: Get.find<ReportsControllerAdmin>()
                            .endTimeController,
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
            kSizedBoxH6,
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (Get.find<ReportsControllerAdmin>()
                          .attendanceformKey
                          .currentState
                          ?.validate() ??
                      false) {
                    Get.find<ReportsControllerAdmin>()
                        .validateAndSubmitAttendance();
                  }
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
      ),
    );
  }
}
