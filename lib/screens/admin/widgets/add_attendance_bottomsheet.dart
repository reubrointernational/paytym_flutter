// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:paytym/core/extensions/camelcase.dart';
// import 'package:paytym/screens/admin/reports/reports_controller.dart';
// import '../../../../models/employee_list_model.dart' as emp;
// import '../../../core/colors/colors.dart';
// import '../../../core/constants/strings.dart';
// import '../../../core/constants/widgets.dart';
// import '../../../models/leaves/leave_type_model.dart';
// import '../../employee/leaves/leaves_controller.dart';
// import '../../widgets/bordered_text_form_field.dart';
// import '../calendar/calendar_controller.dart';

// class AddAttendanceBottomsheet extends StatelessWidget {
//   final emp.EmployeeList? employeeList;

//   const AddAttendanceBottomsheet({super.key, this.employeeList});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//       padding: const EdgeInsets.all(28),
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(20),
//           topLeft: Radius.circular(20),
//         ),
//       ),
//       child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Form(
//                 key: Get.find<ReportsControllerAdmin>().attendanceFormKey,
//                 child: Column(
//                   children: [
//                     BorderedTextFormField(
//                       inputFormatters: [
//                         FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
//                       ],
//                       onSaved: (value) => Get.find<ReportsControllerAdmin>()
//                           .attendanceRequestModel
//                           .checkInDate = value!,
                      
//                       hintText: kStartDateString,
//                       keyboardType: TextInputType.datetime,
//                       suffixIcon: GestureDetector(
//                         onTap: () => Get.find<LeavesController>()
//                             .selectDateTime(context, true),
//                         child: const Icon(Icons.calendar_month, size: 18),
//                       ),
//                       validator: (value) =>
//                           Get.find<ReportsControllerAdmin>().dateValidator(value!),
//                     ),
//                     // kSizedBoxH6,
//                     // BorderedTextFormField(
//                     //   inputFormatters: [
//                     //     FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
//                     //   ],
//                     //   onSaved: (value) => Get.find<LeavesController>()
//                     //       .leaveRequestModel
//                     //       .endDate = value,
//                     //   hintText: kEndDateString,
//                     //   controller:
//                     //       Get.find<LeavesController>().endDateController,
//                     //   keyboardType: TextInputType.datetime,
//                     //   suffixIcon: GestureDetector(
//                     //     onTap: () => Get.find<LeavesController>()
//                     //         .selectDateTime(context, false),
//                     //     child: const Icon(Icons.calendar_month, size: 18),
//                     //   ),
//                     //   validator: (value) =>
//                     //       Get.find<LeavesController>().dateValidator(value!),
//                     // ),
//                     // kSizedBoxH6,
//                     // GestureDetector(
//                     //   onTap: (() async {
//                     //     TimeOfDay? selectedTime = await showTimePicker(
//                     //         context: context, initialTime: TimeOfDay.now());

//                     //     Get.find<LeavesController>().startTimeController.text =
//                     //         Get.find<CalendarControllerAdmin>()
//                     //             .formatTimeOfDay(selectedTime);
//                     //   }),
//                     //   child: BorderedTextFormField(
//                     //     enabled: false,
//                     //     inputFormatters: [
//                     //       FilteringTextInputFormatter.allow(
//                     //         RegExp(r'[0-9-]'),
//                     //       ),
//                     //     ],
//                     //     // onSaved: (value) => Get.find<LeavesController>()
//                     //     //     .leaveRequestModel
//                     //     //     .startDate = value,
//                     //     controller:
//                     //         Get.find<LeavesController>().startTimeController,
//                     //     hintText: kStartTimeString,
//                     //     keyboardType: TextInputType.datetime,
//                     //     suffixIcon: const Icon(
//                     //       Icons.access_time,
//                     //       size: 18,
//                     //     ),

//                     //     // validator: (value) =>
//                     //     //     Get.find<LeavesController>()
//                     //     //         .dateValidator(value!),
//                     //   ),
//                     // ),
//                     // kSizedBoxH6,
//                     // GestureDetector(
//                     //   onTap: (() async {
//                     //     TimeOfDay? selectedTime = await showTimePicker(
//                     //         context: context, initialTime: TimeOfDay.now());

//                     //     Get.find<LeavesController>().endTimeController.text =
//                     //         Get.find<CalendarControllerAdmin>()
//                     //             .formatTimeOfDay(selectedTime);
//                     //   }),
//                     //   child: BorderedTextFormField(
//                     //     enabled: false,
//                     //     inputFormatters: [
//                     //       FilteringTextInputFormatter.allow(
//                     //         RegExp(r'[0-9-]'),
//                     //       ),
//                     //     ],
//                     //     // onSaved: (value) => Get.find<LeavesController>()
//                     //     //     .leaveRequestModel
//                     //     //     .startDate = value,
//                     //     controller:
//                     //         Get.find<LeavesController>().endTimeController,
//                     //     hintText: kEndTimeString,
//                     //     keyboardType: TextInputType.datetime,
//                     //     suffixIcon: const Icon(
//                     //       Icons.access_time,
//                     //       size: 18,
//                     //     ),
//                     //     // validator: (value) =>
//                     //     //     Get.find<LeavesController>()
//                     //     //         .dateValidator(value!),
//                     //   ),
//                     // ),
//                     // kSizedBoxH6,
//                     // BorderedTextFormField(
//                     //   maxLines: 5,
//                     //   maxLength: 300,
//                     //   onSaved: (value) => Get.find<LeavesController>()
//                     //       .leaveRequestModel
//                     //       .title = value!.toCamelCase(),
//                     //   hintText: 'Reason',
//                     //   validator: (value) =>
//                     //       Get.find<LeavesController>().titleValidator(value!),
//                     // ),
//                   ],
//                 ),
//               ),
//               kSizedBoxH15,
//               SizedBox(
//                 height: 50,
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Get.find<LeavesController>().validateAndApplyForLeave();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: CustomColors.blueCardColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: const Text(
//                     'Add Attendance',
//                     style: TextStyle(
//                       color: CustomColors.whiteTextColor,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//     );
//   }
// }
