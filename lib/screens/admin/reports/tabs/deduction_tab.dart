import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/core/dialog_helper.dart';
import 'package:paytym/screens/admin/widgets/add_deduction_bottom_sheet.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/constants/styles.dart';
import '../../dashboard/dashboard_controller.dart';
import '../reports_controller.dart';
import '../widgets/medical_title_tag.dart';

class DeductionTabAdmin extends StatelessWidget {
  const DeductionTabAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ReportsControllerAdmin>().getDeduction();
      Get.find<DashboardControllerAdmin>().clearFilter();
    });
    return Column(
      children: [
        // SizedBox(
        //   height: 100,
        //   child: ListView(
        //     scrollDirection: Axis.horizontal,
        //     children: [
        //       ...List.generate(
        //         2,
        //         (index) => Stack(
        //           children: [
        //             const Positioned(
        //               right: 12,
        //               top: 2,
        //               child: Icon(
        //                 Icons.download_outlined,
        //                 color: Colors.green,
        //               ),
        //             ),
        //             Container(
        //               decoration: BoxDecoration(
        //                 border: Border.all(color: Colors.grey.shade200),
        //                 borderRadius: BorderRadius.circular(10),
        //               ),
        //               margin: const EdgeInsets.symmetric(horizontal: 10),
        //               padding: const EdgeInsets.symmetric(
        //                   vertical: 10, horizontal: 30),
        //               child: Column(
        //                 children: [
        //                   Container(
        //                     alignment: Alignment.center,
        //                     height: 50,
        //                     width: 50,
        //                     decoration: BoxDecoration(
        //                         border: Border.all(color: Colors.grey.shade200),
        //                         borderRadius: BorderRadius.circular(10),
        //                         color: Colors.lightBlue),
        //                     child: Text(
        //                       '16',
        //                       style: kTextStyleS18W600.copyWith(
        //                           color: Colors.amber),
        //                     ),
        //                   ),
        //                   kSizedBoxH10,
        //                   Text(
        //                     index == 0 ? 'Surcharge' : 'Advance',
        //                     style: kTextStyleS14W600LS0p2,
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       IconButton(
        //         onPressed: () {
        //           DialogHelper.showBottomSheet(const AddDeductionBottomSheet());
        //         },
        //         icon: const Icon(
        //           Icons.add_circle_outline,
        //           size: 40,
        //           color: Colors.blue,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        kSizedBoxH10,
        Expanded(
          child: Obx(
            () => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: Get.find<ReportsControllerAdmin>()
                      .deductionResponseModel
                      .value
                      .details
                      ?.length ??
                  0,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      // height: 260,

                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: MedicalTitleTag(
                                  branch: '',
                                  name: Get.find<ReportsControllerAdmin>()
                                          .deductionResponseModel
                                          .value
                                          .details?[index]
                                          .name ??
                                      '',
                                  employmentId: '',
                                ),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  Get.find<ReportsControllerAdmin>()
                                          .deductionResponseModel
                                          .value
                                          .details?[index]
                                          .description ??
                                      '',
                                  style: kTextStyleS12W600CcustomGrey,
                                ),
                              ),
                            ],
                          ),
                          kSizedBoxH6,
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Visibility(
                              visible: Get.find<ReportsControllerAdmin>()
                                      .deductionResponseModel
                                      .value
                                      .details?[index]
                                      .amount
                                      ?.isNotEmpty ??
                                  false,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Amount',
                                    style: kTextStyleS12W600CcustomGrey,
                                  ),
                                  Text(
                                    "\$${Get.find<ReportsControllerAdmin>().formatNumber(Get.find<ReportsControllerAdmin>().deductionResponseModel.value.details?[index].amount ?? '0')}",
                                    style: kTextStyleS12W600CcustomGrey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: Get.find<ReportsControllerAdmin>()
                                    .deductionResponseModel
                                    .value
                                    .details?[index]
                                    .percentage
                                    ?.isNotEmpty ??
                                false,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Percentage',
                                  style: kTextStyleS12W600CcustomGrey,
                                ),
                                Text(
                                  '${Get.find<ReportsControllerAdmin>().deductionResponseModel.value.details?[index].percentage}%',
                                  style: kTextStyleS12W600CcustomGrey,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Created at',
                                  style: kTextStyleS12W600CcustomGrey,
                                ),
                                Text(
                                  DateFormat('dd-MM-yyyy').format(
                                      Get.find<ReportsControllerAdmin>()
                                              .deductionResponseModel
                                              .value
                                              .details?[index]
                                              .createdAt ??
                                          DateTime(0000, 00, 00)),
                                  style: kTextStyleS12W600CcustomGrey,
                                ),
                              ],
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     const Text(
                          //       'Surcharge',
                          //       style: kTextStyleS12W600CcustomGrey,
                          //     ),
                          //     Text(
                          //       "\$${Get.find<ReportsControllerAdmin>().formatNumber(Get.find<ReportsControllerAdmin>().deductionResponseModel.value.details?[index].amount ?? '0')}",
                          //       style: kTextStyleS12W600CcustomGrey,
                          //     ),
                          //   ],
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     const Text(
                          //       'Advance',
                          //       style: kTextStyleS12W600CcustomGrey,
                          //     ),
                          //     Text(
                          //       "\$${Get.find<ReportsControllerAdmin>().formatNumber(Get.find<ReportsControllerAdmin>().deductionResponseModel.value.details?[index].amount ?? '0')}",
                          //       style: kTextStyleS12W600CcustomGrey,
                          //     ),
                          //   ],
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 15),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       const Text(
                          //         kTotalString,
                          //         style: kTextStyleS13W600Cblue,
                          //       ),
                          //       Text(
                          //         "\$${Get.find<ReportsControllerAdmin>().formatNumber(Get.find<ReportsControllerAdmin>().deductionResponseModel.value.details?[index].amount ?? '0')}",
                          //         style: kTextStyleS13W600Cblue.copyWith(
                          //             color: Colors.lightBlue),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          Get.find<ReportsControllerAdmin>()
                              .deleteDeduction(index);
                        },
                        icon: const Icon(
                          Icons.delete_outline_outlined,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  kSizedBoxH10,
            ),
          ),
        ),
      ],
    );
  }
}
