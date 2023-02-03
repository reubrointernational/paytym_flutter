import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/core/extensions/camelcase.dart';
import 'package:paytym/screens/employees_screens/leaves/leaves_controller.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../widgets/bordered_text_form_field.dart';

class LeaveDialogue extends StatelessWidget {
  const LeaveDialogue({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text(kRequestLeaveString),
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: Get.find<LeavesController>().formKey,
              child: Column(
                children: [
                  BorderedTextFormField(
                    onSaved: (value) => Get.find<LeavesController>()
                        .leaveRequestModel
                        .title = value!.toCamelCase(),
                    hintText: kTitleString,
                    validator: (value) =>
                        Get.find<LeavesController>().titleValidator(value!),
                  ),
                  kSizedBoxH6,
                  Container(
                    height: 50,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          width: 1.2,
                          color: CustomColors.lightBlueCardBorderColor),
                    ),
                    child: Obx(
                      () => DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value:
                              Get.find<LeavesController>().selectedItem.value,
                          onChanged: (String? value) {
                            Get.find<LeavesController>().selectedItem.value =
                                value!;

                            Get.find<LeavesController>()
                                .leaveRequestModel
                                .type = value;
                          },
                          items: leaveTypes
                              .map<DropdownMenuItem<String>>((String? value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value!.toCamelCase(),
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  kSizedBoxH6,
                  BorderedTextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
                    ],
                    onSaved: (value) => Get.find<LeavesController>()
                        .leaveRequestModel
                        .startDate = value,
                    controller:
                        Get.find<LeavesController>().startDateController,
                    hintText: kStartDateString,
                    keyboardType: TextInputType.datetime,
                    suffixIcon: GestureDetector(
                      onTap: () => Get.find<LeavesController>()
                          .selectDateTime(context, true),
                      child: const Icon(Icons.calendar_month, size: 18),
                    ),
                    validator: (value) =>
                        Get.find<LeavesController>().dateValidator(value!),
                  ),
                  kSizedBoxH6,
                  BorderedTextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
                    ],
                    onSaved: (value) => Get.find<LeavesController>()
                        .leaveRequestModel
                        .endDate = value,
                    hintText: kEndDateString,
                    controller: Get.find<LeavesController>().endDateController,
                    keyboardType: TextInputType.datetime,
                    suffixIcon: GestureDetector(
                      onTap: () => Get.find<LeavesController>()
                          .selectDateTime(context, false),
                      child: const Icon(Icons.calendar_month, size: 18),
                    ),
                    validator: (value) =>
                        Get.find<LeavesController>().dateValidator(value!),
                  ),
                ],
              ),
            ),
            kSizedBoxH6,
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () =>
                    Get.find<LeavesController>().validateAndApplyForLeave(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.blueCardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  kRequestLeaveString,
                  style: TextStyle(
                    color: CustomColors.whiteTextColor,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
