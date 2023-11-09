import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/admin/dashboard/dashboard_controller.dart';
import 'package:paytym/screens/admin/reports/csv_download.dart';
import 'package:paytym/screens/admin/reports/reports_controller.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/icons.dart';
import '../../../../core/constants/widgets.dart';
import '../../../../core/custom_slider_thumb.dart';
import '../../../../core/dialog_helper.dart';
import '../../../../models/employee_list_model.dart';
import '../../widgets/filter_payroll_bottomsheet.dart';

class PendingPayrollListview extends StatelessWidget {
  const PendingPayrollListview({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => Get.find<DashboardControllerAdmin>().clearFilter());
    });

    bool payrollOpen = true;
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: SizedBox(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                // height: 130,
                child: Card(
                  color: CustomColors.whiteCardColor,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     const Text(
                        //       '                     ',
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.w700,
                        //         color: CustomColors.blackTextColor,
                        //       ),
                        //     ),
                        //     IconButton(
                        //       icon: const Icon(
                        //         Icons.download,
                        //         size: 18,
                        //         color: CustomColors.orangeColor,
                        //       ),
                        //       onPressed: () {
                        //         final employeeList =
                        //             Get.find<DashboardControllerAdmin>()
                        //                 .employeeList
                        //                 .value
                        //                 .employeeList
                        //                 ?.where(
                        //                     (element) => element.status == 1)
                        //                 .toList();
                        //         if (employeeList != null) {
                        //           DialogHelper.showToast(
                        //               desc: 'Payslip Downloading');
                        //           CsvDownloader().downloadCsv(employeeList);
                        //         }
                        //       },
                        //     ),
                        //     IconButton(
                        //       icon: const Icon(
                        //         Icons.refresh,
                        //         size: 18,
                        //         color: CustomColors.orangeColor,
                        //       ),

                        //       onPressed: () {
                        //         final employeeList =
                        //             Get.find<DashboardControllerAdmin>()
                        //                 .employeeList
                        //                 .value
                        //                 .employeeList
                        //                 ?.where(
                        //                     (element) => element.status == 1)
                        //                 .toList();
                        //         if (employeeList != null) {
                        //           DialogHelper.showToast(
                        //               desc: 'Payslip Reverting');
                        //           // CsvDownloader().downloadCsv(employeeList);
                        //         }
                        //       },
                        //     ),
                        //   ],
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'PROCESS PAYROLL',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: CustomColors.blackTextColor,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.download,
                                size: 18,
                                color: CustomColors.orangeColor,
                              ),
                              onPressed: () {
                                final employeeList =
                                    Get.find<DashboardControllerAdmin>()
                                        .employeeList
                                        .value
                                        .employeeList
                                        ?.where(
                                            (element) => element.status == 1)
                                        .toList();
                                if (employeeList != null) {
                                  DialogHelper.showToast(
                                      desc: 'Payslip Downloading');
                                  CsvDownloader().downloadCsv(employeeList);
                                }
                              },
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor:
                                      Get.find<ReportsControllerAdmin>()
                                              .isAllEmployeesSelected
                                              .value
                                          ? Colors.blue
                                          : Colors.white,
                                  side: const BorderSide(color: Colors.blue),
                                ),
                                onPressed: () {
                                  Get.find<ReportsControllerAdmin>()
                                      .isAllEmployeesSelected
                                      .value = true;
                                  Get.find<ReportsControllerAdmin>()
                                      .isEmployeesSelectedForPayroll
                                      .value = false;
                                  Get.find<ReportsControllerAdmin>()
                                      .isRevertPayrollSelected
                                      .value = false;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Text(
                                    'All Employees',
                                    style: TextStyle(
                                        color:
                                            Get.find<ReportsControllerAdmin>()
                                                    .isAllEmployeesSelected
                                                    .value
                                                ? Colors.white
                                                : Colors.blue,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.025,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                            Obx(
                              () => OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor:
                                      Get.find<ReportsControllerAdmin>()
                                              .isEmployeesSelectedForPayroll
                                              .value
                                          ? Colors.blue
                                          : Colors.white,
                                  side: const BorderSide(color: Colors.blue),
                                ),
                                onPressed: () {
                                  Get.find<ReportsControllerAdmin>()
                                      .isAllEmployeesSelected
                                      .value = false;
                                  Get.find<ReportsControllerAdmin>()
                                      .isEmployeesSelectedForPayroll
                                      .value = true;
                                  Get.find<ReportsControllerAdmin>()
                                      .isRevertPayrollSelected
                                      .value = false;
                                  showFilterBottomSheet(context,
                                      Get.find<ReportsControllerAdmin>());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Text(
                                    'Choose Employee',
                                    style: TextStyle(
                                        color: Get.find<
                                                    ReportsControllerAdmin>()
                                                .isEmployeesSelectedForPayroll
                                                .value
                                            ? Colors.white
                                            : Colors.blue,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.025,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                            Obx(
                              () => OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor:
                                      Get.find<ReportsControllerAdmin>()
                                              .isRevertPayrollSelected
                                              .value
                                          ? Colors.blue
                                          : Colors.white,
                                  side: const BorderSide(color: Colors.blue),
                                ),
                                onPressed: () {
                                  Get.find<ReportsControllerAdmin>()
                                      .isAllEmployeesSelected
                                      .value = false;
                                  Get.find<ReportsControllerAdmin>()
                                      .isEmployeesSelectedForPayroll
                                      .value = false;
                                  Get.find<ReportsControllerAdmin>()
                                      .isRevertPayrollSelected
                                      .value = true;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Text(
                                    'Revert Payroll',
                                    style: TextStyle(
                                        color:
                                            Get.find<ReportsControllerAdmin>()
                                                    .isRevertPayrollSelected
                                                    .value
                                                ? Colors.white
                                                : Colors.blue,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.025,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SliderColumn(
                          // title: 'ALL',
                          title: '',
                          processPayrollTypes:
                              Get.find<ReportsControllerAdmin>()
                                      .isAllEmployeesSelected
                                      .value
                                  ? ProcessPayrollTypes.all
                                  : ProcessPayrollTypes.all,
                        ),
                        // const SliderColumn(
                        //   title: 'DEPARTMENT',
                        //   processPayrollTypes: ProcessPayrollTypes.dept,
                        // ),
                        // const SliderColumn(
                        //   title: 'BRANCH',
                        //   processPayrollTypes: ProcessPayrollTypes.branch,
                        // ),
                        // Revert Payroll Section
                        // ExpansionTile(
                        //   title: Text("Revert Payroll"),
                        //   children: [
                        //     Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Obx(() => OutlinedButton(
                        //               style: OutlinedButton.styleFrom(
                        //                 backgroundColor:
                        //                     Get.find<ReportsControllerAdmin>()
                        //                             .isAllEmployeesSelected
                        //                             .value
                        //                         ? Colors.blue
                        //                         : Colors.white,
                        //                 side: const BorderSide(
                        //                     color: Colors.blue),
                        //               ),
                        //               onPressed: () {
                        //                 Get.find<ReportsControllerAdmin>()
                        //                     .isAllEmployeesSelected
                        //                     .value = true;
                        //                 Get.find<ReportsControllerAdmin>()
                        //                     .isEmployeesSelectedForPayroll
                        //                     .value = false;
                        //               },
                        //               child: Padding(
                        //                 padding: const EdgeInsets.all(1.0),
                        //                 child: Text(
                        //                   'All Employees',
                        //                   style: TextStyle(
                        //                       color: Get.find<
                        //                                   ReportsControllerAdmin>()
                        //                               .isAllEmployeesSelected
                        //                               .value
                        //                           ? Colors.white
                        //                           : Colors.blue,
                        //                       fontSize: 16,
                        //                       fontWeight: FontWeight.w500),
                        //                 ),
                        //               ),
                        //             )),
                        //         Obx(() => OutlinedButton(
                        //               style: OutlinedButton.styleFrom(
                        //                 backgroundColor:
                        //                     Get.find<ReportsControllerAdmin>()
                        //                             .isAllEmployeesSelected
                        //                             .value
                        //                         ? Colors.white
                        //                         : Colors.blue,
                        //                 side: const BorderSide(
                        //                     color: Colors.blue),
                        //               ),
                        //               onPressed: () {
                        //                 Get.find<ReportsControllerAdmin>()
                        //                     .isAllEmployeesSelected
                        //                     .value = false;
                        //                 Get.find<ReportsControllerAdmin>()
                        //                     .isEmployeesSelectedForPayroll
                        //                     .value = true;
                        //                 showFilterBottomSheet(context,
                        //                     Get.find<ReportsControllerAdmin>());
                        //               },
                        //               child: Padding(
                        //                 padding: const EdgeInsets.all(1.0),
                        //                 child: Text(
                        //                   'Choose Employee',
                        //                   style: TextStyle(
                        //                       color: Get.find<
                        //                                   ReportsControllerAdmin>()
                        //                               .isAllEmployeesSelected
                        //                               .value
                        //                           ? Colors.blue
                        //                           : Colors.white,
                        //                       fontSize: 16,
                        //                       fontWeight: FontWeight.w500),
                        //                 ),
                        //               ),
                        //             )),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Payroll Details',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: CustomColors.blackTextColor,
                  ),
                ),
              ),
              Obx(() {
                List<EmployeeList>? employeesList =
                    Get.find<DashboardControllerAdmin>().getAllEmployees();
                // List<EmployeeList>? employeesList =
                //     Get.find<DashboardControllerAdmin>().getEmployees();
                // List<EmployeeList>? employeesList =
                // Get.find<DashboardControllerAdmin>()
                //     .getFilteredEmployeeList();

                //Filtering non active Employees by checking status of the employees
                // employeesList = employeesList
                //     ?.where((element) => element.status == 1)
                //     .toList();
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: employeesList?.length ?? 0,
                  itemBuilder: (context, index) {
                    final employees = employeesList?[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: GestureDetector(
                        onTap: () {},
                        child: Stack(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ConstrainedBox(
                                      constraints:
                                          const BoxConstraints(maxHeight: 70),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${employees?.firstName ?? ''} ${employees?.lastName ?? ''}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                // 'ID: #${employees?.id.toString().padLeft(5, '0')}',
                                                employees?.branch?.name
                                                        .toString() ??
                                                    '',
                                                style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              //Only for HR

                                              /*Padding(
                                                            padding: const EdgeInsets.only(bottom: 10),
                                                            child: Row(
                                                children: [
                                                  //Process & Reverse is for HR
                                                  processButton(
                                                      'Process', CustomColors.greenColor),
                                                  kSizedBoxW10,
                                                  processButton(
                                                      'Reverse', CustomColors.redColor),
                                                ],
                                              ),
                                            ),*/
                                              Text(
                                                // employees?.branch?.name
                                                //         .toString() ??
                                                //     '',
                                                'ID: #${employees?.id.toString().padLeft(5, '0')}',
                                                style: TextStyle(
                                                    color: Colors.grey.shade600,
                                                    fontSize: 12.5),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  text: 'Gross : ',
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          '\$ ${employees?.payroll?.grossSalary ?? '0'}',
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: CustomColors
                                                            .lightBlueColor,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Visibility(
                                    //   // visible: employees!.isExpanded,
                                    //   visible: payrollOpen,
                                    //   child:
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Divider(
                                          thickness: 1,
                                          height: 5,
                                          color: Colors.grey.shade300,
                                        ),
                                        kSizedBoxH6,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            payrollDetails(
                                                'Basic Salary: ',
                                                employees
                                                        ?.payroll?.baseSalary ??
                                                    '0'),
                                            payrollDetails(
                                                'Tax: ',
                                                employees?.payroll?.totalTax ??
                                                    0),
                                          ],
                                        ),
                                        kSizedBoxH6,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            payrollDetails(
                                                'Allowance: ',
                                                employees?.payroll
                                                        ?.totalAllowance ??
                                                    '0'),
                                            payrollDetails(
                                                'Deduction: ',
                                                employees?.payroll
                                                        ?.totalDeduction ??
                                                    '0'),
                                          ],
                                        ),
                                        kSizedBoxH6,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            payrollDetails(
                                                'Bonus: ',
                                                employees
                                                        ?.payroll?.totalBonus ??
                                                    '0'),
                                            payrollDetails(
                                                'Commission: ',
                                                employees?.payroll
                                                        ?.totalCommission ??
                                                    '0'),
                                          ],
                                        ),
                                      ],
                                    ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            // Positioned(
                            //   bottom: 10,
                            //   right: 0,
                            //   left: 0,
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       print(
                            //           "Sooraj1:${Get.find<DashboardControllerAdmin>().payrollProcessDownArrow}");
                            //       print("Sooraj 2:${employees!.isExpanded}");
                            //       // employees!.isExpanded = true;
                            //
                            //       if (Get.find<DashboardControllerAdmin>()
                            //               .payrollProcessDownArrow ==
                            //           true) {
                            //         Get.find<DashboardControllerAdmin>()
                            //             .payrollProcessDownArrow = false;
                            //       } else {
                            //         Get.find<DashboardControllerAdmin>()
                            //             .payrollProcessDownArrow = true;
                            //       }
                            //       print("Sooraj 2:${employees!.isExpanded}");
                            //       print(
                            //           "Sooraj1:${Get.find<DashboardControllerAdmin>().payrollProcessDownArrow}");
                            //       if (employees!.isExpanded) {
                            //         employees!.isExpanded = false;
                            //       } else {
                            //         employees!.isExpanded = true;
                            //       }
                            //
                            //       payrollOpen = false;
                            //       // Get.find<DashboardControllerAdmin>()
                            //       //     .payrollProcessDownArrow = true;
                            //
                            //       // setState(() {r
                            //       //   employees?.isExpanded =
                            //       //       !employees.isExpanded;
                            //       // });
                            //     },
                            //     child: Padding(
                            //       padding:
                            //           const EdgeInsets.fromLTRB(28, 28, 28, 0),
                            //       child: Icon(
                            //         employees?.isExpanded ?? false
                            //             ? Icons.expand_less
                            //             : Icons.expand_more,
                            //         color: Colors.grey,
                            //         size: 25,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Positioned(
                              right: 20,
                              top: 12,
                              child: Text(
                                'PID${employees?.payroll?.id ?? 0}',
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class SliderColumn extends StatelessWidget {
  final String title;
  final ProcessPayrollTypes processPayrollTypes;
  const SliderColumn({
    super.key,
    required this.title,
    required this.processPayrollTypes,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: CustomColors.blackTextColor,
            ),
          ),
          if (processPayrollTypes != ProcessPayrollTypes.all)
            Container(
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      width: 1.2,
                      color: const Color.fromRGBO(182, 182, 182, 1))),
              child: Obx(
                () => DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: processPayrollTypes == ProcessPayrollTypes.branch
                        ? Get.find<DashboardControllerAdmin>()
                            .selectedDropdownBranches
                            .value
                        : Get.find<DashboardControllerAdmin>()
                            .selectedDropdownDepartments
                            .value,
                    onChanged: (String? value) {
                      processPayrollTypes == ProcessPayrollTypes.branch
                          ? Get.find<DashboardControllerAdmin>()
                              .selectedDropdownBranches
                              .value = value!
                          : Get.find<DashboardControllerAdmin>()
                              .selectedDropdownDepartments
                              .value = value!;
                    },
                    hint: Text(processPayrollTypes == ProcessPayrollTypes.dept
                        ? 'Departments'
                        : 'Branches'),
                    isExpanded: true,
                    icon: Image.asset(
                      IconPath.dropdownIconPng,
                      height: 20,
                      width: 20,
                    ),
                    items: processPayrollTypes == ProcessPayrollTypes.branch
                        ? Get.find<DashboardControllerAdmin>()
                            .branchwiseEmployeeMap
                            .keys
                            .toList()
                            .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList()
                        : Get.find<DashboardControllerAdmin>()
                            .deptwiseEmployeeMap
                            .keys
                            .toList()
                            .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                  ),
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.only(
                top: processPayrollTypes != ProcessPayrollTypes.all ? 0 : 10),
            child: Obx(() => SliderTheme(
                  data: SliderThemeData(
                    overlayShape: SliderComponentShape.noOverlay,
                    thumbShape: const CustomRoundSliderThumbShape(
                      enabledThumbRadius: 18.0,
                    ),
                  ),
                  child: Slider(
                    value: Get.find<ReportsControllerAdmin>().sliderValue.value,
                    max: 100,
                    thumbColor: CustomColors.lightBlueColor,
                    inactiveColor: CustomColors.lightBlueColor,
                    activeColor: CustomColors.orangeColor,
                    onChanged: (double value) {
                      Get.find<ReportsControllerAdmin>()
                          .changeSliderPosition(value);
                    },
                    onChangeStart: (value) => Get.find<ReportsControllerAdmin>()
                        .sliderStartValue = value,
                    onChangeEnd: (double value) =>
                        Get.find<ReportsControllerAdmin>().sliderController(),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

Widget processButton(String text, Color color) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(width: 1, color: color),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10.5,
          color: color,
        ),
      ),
    );

Widget payrollDetails(text, details) => RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
        children: [
          TextSpan(
            text: '\$ $details',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: CustomColors.lightBlueColor,
            ),
          )
        ],
      ),
    );
