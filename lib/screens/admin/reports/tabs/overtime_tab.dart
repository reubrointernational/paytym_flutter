import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytym/core/constants/enums.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/admin/reports/reports_controller.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/dialog_helper.dart';
import '../../../employee/dashboard/widgets/request_overtime_bottomsheet.dart';
import '../widgets/payment_history.dart';

class OvertimeTabAdmin extends StatelessWidget {
  const OvertimeTabAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Get.find<ReportsControllerAdmin>().getOvertime());
    return Obx(() => ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: Get.find<ReportsControllerAdmin>()
              .overtimeResponseModel
              .value
              .employeeList
              .length,
          itemBuilder: (context, index) {
           
            return Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: GestureDetector(
                onTap: () {},
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 80),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Branch',
                                    style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 12.5),
                                  ),
                                  const Text(
                                    'Name',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'ID: ${Get.find<ReportsControllerAdmin>().overtimeResponseModel.value.employeeList[index].employeeId}',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  DetailsRow(
                                    title: "Date: ",
                                    value: DateFormat('dd-MM-yyyy').format(
                                        Get.find<ReportsControllerAdmin>()
                                            .overtimeResponseModel
                                            .value
                                            .employeeList[index]
                                            .date),
                                  ),
                                  DetailsRow(
                                    title: "Start Time: ",
                                    value: DateFormat('h:mm a').format(
                                        Get.find<ReportsControllerAdmin>()
                                            .overtimeResponseModel
                                            .value
                                            .employeeList[index]
                                            .date),
                                  ),
                                  kSizedBoxH3,
                                  DetailsRow(
                                    title: "Total Hours: ",
                                    value: Get.find<ReportsControllerAdmin>()
                                        .overtimeResponseModel
                                        .value
                                        .employeeList[index]
                                        .totalHours,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Reason: ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Overtime alloted by Akhil',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          processButton('Decline', CustomColors.redColor, () {
                            Get.find<ReportsControllerAdmin>()
                                .approveOrDeclineOvertime(
                                    index,
                                    ReasonButton.overtimeDecline);
                          }),
                          kSizedBoxW10,
                          processButton(
                              'Edit', CustomColors.blueCardColor, () {
                                DialogHelper.showBottomSheet(
                                RequestOvertimeBottomsheet(index: index,));
                                
                              }),
                          kSizedBoxW10,
                          processButton(
                              'Approve', CustomColors.greenColor, () {
                                Get.find<ReportsControllerAdmin>()
                                .approveOrDeclineOvertime(
                                    index,
                                    ReasonButton.overtimeApprove);
                              }),
                        ],
                      ),
                      kSizedBoxH10,
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}

class DetailsRow extends StatelessWidget {
  final String title;
  final String value;
  const DetailsRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
