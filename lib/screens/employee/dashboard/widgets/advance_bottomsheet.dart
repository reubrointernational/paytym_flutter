import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytym/models/report/advance_response_model.dart';
import 'package:paytym/models/report/overtime_list_response_model.dart';
import 'package:paytym/screens/admin/reports/reports_controller.dart';
import 'package:paytym/screens/employee/dashboard/dashboard_controller.dart';
import 'package:paytym/screens/employee/reports/widgets/bottomsheet_text_field.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/constants/widgets.dart';
import '../../../../models/employee_list_model.dart' as emp;

class RequestAdvanceBottomsheet extends StatelessWidget {
  final emp.EmployeeList? employeeList;
  final int? index;
  final String? delete;
  const RequestAdvanceBottomsheet(
      {super.key, this.index, this.employeeList, this.delete});
  @override
  Widget build(BuildContext context) {
    int? originalIndex;
    print(
        "RequestAdvanceBottomsheet build (1) Got Index :${index?.toString()}  Delete: ${delete?.toString()}");

    if (delete != "true") {
      if (index != null) {
        print("RequestAdvanceBottomsheet build (2) ");
        List<EmployeesList>? advanceDetails = Get.find<ReportsControllerAdmin>()
            .getFilteredAdvanceList()
            ?.where((element) => element.status == '0')
            .toList();
        originalIndex = Get.find<ReportsControllerAdmin>()
            .advanceResponseModel
            .value
            .employeeList
            .indexOf(advanceDetails?[index!] ?? EmployeesList());

        Get.find<DashboardController>().advanceTextEditingcontroller!.text =
            DateFormat('dd-MM-yyyy').format(Get.find<ReportsControllerAdmin>()
                    .advanceResponseModel
                    .value
                    .employeeList[originalIndex]
                    .date ??
                DateTime(0000, 00, 00));
        Get.find<DashboardController>().advanceApproveEditRequestModel.date =
            DateFormat('yyyy-MM-dd').format(Get.find<ReportsControllerAdmin>()
                    .advanceResponseModel
                    .value
                    .employeeList[originalIndex]
                    .date ??
                DateTime(0000, 00, 00));
      }
      return Container(
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
              index != null ? kEditAdvanceString : kRequestAdvanceString,
              style:
                  kTextStyleS18W600.copyWith(color: CustomColors.blueTextColor),
            ),
            kSizedBoxH10,
            Form(
              key: Get.find<DashboardController>().requestAdvanceFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (employeeList != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        '${employeeList?.firstName ?? ''} ${employeeList?.lastName ?? ''}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  BottomsheetTextField(
                    controller: Get.find<DashboardController>()
                        .advanceTextEditingcontroller,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
                    ],
                    hintText: kDateString.substring(0, 4),
                    keyboardType: TextInputType.datetime,
                    suffixIcon: InkWell(
                      onTap: () => Get.find<DashboardController>()
                          .selectDateTime(context),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.calendar_month, size: 18),
                      ),
                    ),
                    validator: (value) =>
                        Get.find<DashboardController>().dateValidator(value!),
                  ),
                  kSizedBoxH10,
                  BottomsheetTextField(
                      text: index != null
                          ? Get.find<ReportsControllerAdmin>()
                              .advanceResponseModel
                              .value
                              .employeeList[originalIndex ?? index!]
                              .totalHours
                          : null,
                      onSaved: ((value) => Get.find<DashboardController>()
                          .advanceApproveEditRequestModel
                          .totalHours = value),
                      hintText: kAmountString,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          try {
                            final text = newValue.text;
                            if (text.isNotEmpty) double.parse(text);
                            return newValue;
                          } catch (e) {}
                          return oldValue;
                        }),
                      ],
                      validator: (value) {
                        try {
                          double.parse(value!);
                          return null;
                        } catch (e) {}
                        return 'Enter a valid number';
                      }),
                  kSizedBoxH10,
                  BottomsheetTextField(
                      text: index != null
                          ? Get.find<ReportsControllerAdmin>()
                              .advanceResponseModel
                              .value
                              .employeeList[originalIndex ?? index!]
                              .reason
                          : null,
                      maxLines: 3,
                      maxLength: 80,
                      hintText: kReasonString,
                      validator: (value) => Get.find<DashboardController>()
                          .reasonValidator(value!),
                      onSaved: ((value) {
                        print("Onsaved Edit  button:" + value.toString());
                        Get.find<DashboardController>()
                            .advanceApproveEditRequestModel
                            .reason = value;
                      })),
                ],
              ),
            ),
            kSizedBoxH10,
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  print("RequestAdvanceBottomsheet build (6) Button pressed");
                  index != null
                      ? Get.find<ReportsControllerAdmin>()
                          .approveOrDeclineAdvance(
                              originalIndex!, ReasonButton.advanceEdit)
                      : Get.find<DashboardController>()
                          .requestAdvanceLoan(employeeList);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.blueTextColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  index != null ? "Approve Advance" : kRequestAdvanceString,
                  // index != null ? kEditOvertimeString : kRequestOvertimeString,
                  style: const TextStyle(
                    color: CustomColors.whiteTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      // Delete - true
      print("RequestAdvanceBottomsheet build (3) ");
      if (index != null) {
        print("Delete - true coding starts :${delete?.toString()}");

        List<EmployeesList>? advanceDetails = Get.find<ReportsControllerAdmin>()
            .getFilteredAdvanceList()
            ?.where((element) => element.status == '0')
            .toList();
        originalIndex = Get.find<ReportsControllerAdmin>()
            .advanceResponseModel
            .value
            .employeeList
            .indexOf(advanceDetails?[index!] ?? EmployeesList());

        Get.find<DashboardController>().advanceTextEditingcontroller!.text =
            DateFormat('dd-MM-yyyy').format(Get.find<ReportsControllerAdmin>()
                    .advanceResponseModel
                    .value
                    .employeeList[originalIndex]
                    .date ??
                DateTime(0000, 00, 00));
        Get.find<DashboardController>().advanceApproveEditRequestModel.date =
            DateFormat('yyyy-MM-dd').format(Get.find<ReportsControllerAdmin>()
                    .advanceResponseModel
                    .value
                    .employeeList[originalIndex]
                    .date ??
                DateTime(0000, 00, 00));
      }
      return Container(
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
              "Reason for Decline Advance",
              // index != null ? kEditOvertimeString : kRequestOvertimeString,
              style:
                  kTextStyleS18W600.copyWith(color: CustomColors.blueTextColor),
            ),
            kSizedBoxH10,
            Form(
              key: Get.find<DashboardController>().requestAdvanceFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (employeeList != null)
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 10),
                    //   child: Text(
                    //     '${employeeList?.firstName ?? ''} ${employeeList?.lastName ?? ''}',
                    //     style: const TextStyle(
                    //         fontSize: 18, fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    kSizedBoxH10,
                  // BottomsheetTextField(
                  //   controller: Get.find<DashboardController>()
                  //       .overtimeTextEditingController,
                  //   inputFormatters: [
                  //     FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
                  //   ],
                  //   hintText: kDateString.substring(0, 4),
                  //   keyboardType: TextInputType.datetime,
                  //   suffixIcon: InkWell(
                  //     onTap: () => Get.find<DashboardController>()
                  //         .selectDateTime(context),
                  //     child: const Padding(
                  //       padding: EdgeInsets.all(8.0),
                  //       child: Icon(Icons.calendar_month, size: 18),
                  //     ),
                  //   ),
                  //   validator: (value) =>
                  //       Get.find<DashboardController>().dateValidator(value!),
                  // ),
                  kSizedBoxH10,
                  // BottomsheetTextField(
                  //     text: index != null
                  //         ? Get.find<ReportsControllerAdmin>()
                  //         .overtimeResponseModel
                  //         .value
                  //         .employeeList[originalIndex ?? index!]
                  //         .totalHours
                  //         : null,
                  //     onSaved: ((value) => Get.find<DashboardController>()
                  //         .overtimeApproveEditRequestModel
                  //         .totalHours = value),
                  //     hintText: kTotalHoursString,
                  //     keyboardType: TextInputType.number,
                  //     inputFormatters: [
                  //       FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                  //       TextInputFormatter.withFunction((oldValue, newValue) {
                  //         try {
                  //           final text = newValue.text;
                  //           if (text.isNotEmpty) double.parse(text);
                  //           return newValue;
                  //         } catch (e) {}
                  //         return oldValue;
                  //       }),
                  //     ],
                  //     validator: (value) {
                  //       try {
                  //         double.parse(value!);
                  //         return null;
                  //       } catch (e) {}
                  //       return 'Enter a valid number';
                  //     }),
                  kSizedBoxH10,
                  BottomsheetTextField(
                      // text: " ",
                      text: index != null
                          ? Get.find<ReportsControllerAdmin>()
                              .advanceResponseModel
                              .value
                              .employeeList[originalIndex ?? index!]
                              .declineReason
                          : null,
                      maxLines: 3,
                      maxLength: 80,
                      hintText: kReasonString,
                      validator: (value) => Get.find<DashboardController>()
                          .reasonValidator(value!),
                      onSaved: ((value) {
                        print("Onsaved Edit  button:$value");
                        Get.find<DashboardController>()
                            .advanceApproveEditRequestModel
                            .declineReason = value;
                      })),
                ],
              ),
            ),
            kSizedBoxH10,
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  print(
                      "RequestAdvanceBottomsheet build  decline (6) Button pressed");
                  index != null
                      ? Get.find<ReportsControllerAdmin>()
                          .approveOrDeclineAdvance(
                              originalIndex!, ReasonButton.advanceDecline)
                      : Get.find<DashboardController>()
                          .requestAdvanceLoan(employeeList);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.blueTextColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  index != null ? "Submit " : kRequestAdvanceString,
                  // index != null ? kEditOvertimeString : kRequestOvertimeString,
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
}

// Get.find<ReportsControllerAdmin>()
//                                 .approveOrDeclineOvertime(
//                                     index,
//                                     ReasonButton.overtimeEdit);
