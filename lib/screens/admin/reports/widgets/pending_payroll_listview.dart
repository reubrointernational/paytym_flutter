import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/admin/dashboard/dashboard_controller.dart';
import 'package:paytym/screens/admin/reports/csv_download.dart';
import 'package:paytym/screens/admin/reports/reports_controller.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/widgets.dart';
import '../../../../core/custom_slider_thumb.dart';
import '../../../../core/dialog_helper.dart';
import '../../../employee/dashboard/dashboard_controller.dart';

class PendingPayrollListview extends StatefulWidget {
  const PendingPayrollListview({super.key});

  @override
  State<PendingPayrollListview> createState() => _PendingPayrollListviewState();
}

class _PendingPayrollListviewState extends State<PendingPayrollListview> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                child: Card(
                  color: CustomColors.whiteCardColor,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'PROCESS PAYROLL',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: CustomColors.blackTextColor,
                          ),
                        ),
                        kSizedBoxH10,
                        Obx(() => SliderTheme(
                              data: SliderThemeData(
                                overlayShape: SliderComponentShape.noOverlay,
                                thumbShape: const CustomRoundSliderThumbShape(
                                  enabledThumbRadius: 18.0,
                                ),
                              ),
                              child: Slider(
                                value: Get.find<ReportsControllerAdmin>()
                                    .sliderValue
                                    .value,
                                max: 100,
                                thumbColor: CustomColors.lightBlueColor,
                                inactiveColor: CustomColors.lightBlueColor,
                                activeColor: CustomColors.orangeColor,
                                onChanged: (double value) {
                                  Get.find<ReportsControllerAdmin>()
                                      .changeSliderPosition(value);
                                },
                                onChangeStart: (value) =>
                                    Get.find<ReportsControllerAdmin>()
                                        .sliderStartValue = value,
                                onChangeEnd: (double value) =>
                                    Get.find<ReportsControllerAdmin>()
                                        .sliderController(),
                              ),
                            )),
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
                final employeeList = Get.find<DashboardControllerAdmin>()
                    .employeeList
                    .value
                    .employeeList
                    .where((element) => element.status == 1)
                    .toList();
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: employeeList.length,
                  itemBuilder: (context, index) {
                    final employees = employeeList[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: GestureDetector(
                        onTap: () {},
                        child: Card(
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
                                      const BoxConstraints(maxHeight: 100),
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
                                            employees.branch?.toString() ?? '',
                                            style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 12.5),
                                          ),
                                          Text(
                                            '${employees.firstName} ${employees.lastName}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            'ID: #${employees.id.toString().padLeft(5, '0')}',
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          //Finance only
                                          IconButton(
                                            icon: const Icon(
                                              Icons.download,
                                              size: 18,
                                              color: CustomColors.orangeColor,
                                            ),
                                            onPressed: () {
                                              CsvDownloader().downloadCsv(employeeList);
                                            },
                                          ),
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
                                                      '\$ ${employees.payroll?.grossSalary}',
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: CustomColors
                                                        .lightBlueColor,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),

                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                employees.isExpanded =
                                                    !employees.isExpanded;
                                              });
                                            },
                                            child: Icon(
                                              employees.isExpanded
                                                  ? Icons.expand_less
                                                  : Icons.expand_more,
                                              color: Colors.grey,
                                              size: 20,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: employees.isExpanded,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Divider(
                                        thickness: 1,
                                        height: 15,
                                        color: Colors.grey.shade300,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          payrollDetails('Basic Salary: ',
                                              employees.payroll?.baseSalary??'0'),
                                          payrollDetails('Tax: ',
                                              employees.payroll?.totalTax ?? 0),
                                        ],
                                      ),
                                      kSizedBoxH6,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          payrollDetails('Allowance: ',
                                              employees.payroll?.totalAllowance??'0'),
                                          payrollDetails('Deduction: ',
                                              employees.payroll?.totalDeduction??'0'),
                                        ],
                                      ),
                                      kSizedBoxH6,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          payrollDetails('Bonus: ',
                                              employees.payroll?.totalBonus??'0'),
                                          payrollDetails(
                                              'Commission: ',
                                              employees
                                                  .payroll?.totalCommission??'0'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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
