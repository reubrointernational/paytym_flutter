import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/models/report/advance_response_model.dart';
import 'package:paytym/screens/employee/reports/reports_controller.dart';
import '../../../../models/report/advance/advance_status_model.dart';

class LoanTab extends StatelessWidget {
  const LoanTab({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ReportsController>().getAdvance();
    });
    return Obx(() {
      List<EmployeesList> advanceDetails =
          Get.find<ReportsController>().advanceResponseModel.value.employeeList;

      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: advanceDetails.length,
        itemBuilder: (context, index) {
          final advaceDetail = advanceDetails[index];
          AdvanceStatusModel advanceStatusModel = Get.find<ReportsController>()
              .getAdvanceStatusModel(advaceDetail?.status.toString());
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: GestureDetector(
                  onTap: () {},
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // OT request status 0: Applied, 1:Approved,2:Rejected
                    child: Column(
                      children: [
                        kSizedBoxH4,
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 75),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ID: #${advaceDetail.userid.toString().padLeft(5, '0')}',
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 13,
                                      ),
                                    ),
                                    // kSizedBoxH2,
                                    DetailsRow(
                                      title: "Date of Requirement: ",
                                      value: DateFormat('dd-MM-yyyy').format(
                                        advaceDetail.date ??
                                            DateTime(0000, 00, 00),
                                      ),
                                    ),
                                    // Text(
                                    //   overtimeDetail.branch ?? '',
                                    //   style: TextStyle(
                                    //       color: Colors.grey.shade600,
                                    //       fontSize: 12.5),
                                    // ),
                                    Text(
                                      '${advaceDetail.user?.firstName ?? ''} ${advaceDetail.user?.lastName ?? ''}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: advanceStatusModel.textColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        advanceStatusModel.text,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: advanceStatusModel.boxColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    kSizedBoxH6,
                                    DetailsRow(
                                        title: 'Amount :',
                                        value: advaceDetail.advanceAmount ?? '')
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Reason: ',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  // overtimeDetail.reason ?? '',
                                  advaceDetail.reason ?? '',
                                  style: const TextStyle(
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
                        // For Declined Overtime only
                        advaceDetail.status == '2'
                            ? Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Decline Reason: ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        advaceDetail.declineReason ?? '',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : kSizedBoxH4,

                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     const Text(
                        //       'Reason: ',
                        //       style: TextStyle(
                        //         fontSize: 12,
                        //         fontWeight: FontWeight.w400,
                        //         color: Colors.black,
                        //       ),
                        //     ),
                        //     Expanded(
                        //       child: Text(
                        //         overtimeDetail.reason ?? '',
                        //         style: const TextStyle(
                        //           fontSize: 12,
                        //           fontWeight: FontWeight.w400,
                        //           color: Colors.blue,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
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
