import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';

import '../../models/leaves/leaves_response.dart';
import 'leaves_controller.dart';

class CasualLeavesPage extends StatefulWidget {
  const CasualLeavesPage({Key? key}) : super(key: key);

  @override
  State<CasualLeavesPage> createState() => _CasualLeavesPageState();
}

class _CasualLeavesPageState extends State<CasualLeavesPage> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        List<LeaveRequest>? casualLeaves = Get.find<LeavesController>()
            .leaveResponseModel
            .value
            .leaveRequests
            ?.where((element) => element.type == 'casual')
            .toList();
        return ListView.builder(
          itemCount: casualLeaves?.length ?? 0,
          itemBuilder: (context, index) {
            final leave = casualLeaves?[index];
            return Container(
              height: 120,
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Get.find<LeavesController>().formatDate(leave?.startDate),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: CustomColors.greyHeadingTextColor,
                    ),
                  ),
                  Container(
                    height: 90,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1,
                          color: CustomColors.greyCardBorderColor,
                        )),
                    // child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text(
                    //           leave.application,
                    //           style: const TextStyle(
                    //             color: Color.fromRGBO(140, 140, 140, 1),
                    //           ),
                    //         ),
                    //         Text(
                    //           leave.leaveDate,
                    //           style: const TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w600,
                    //           ),
                    //         ),
                    //         Text(
                    //           leave.leaveType,
                    //           style: const TextStyle(
                    //             fontSize: 15,
                    //             color: CustomColors.orangeLabelColor,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     Column(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       crossAxisAlignment: CrossAxisAlignment.end,
                    //       children: [
                    //         Container(
                    //           padding: const EdgeInsets.symmetric(
                    //               horizontal: 8, vertical: 3),
                    //           decoration: BoxDecoration(
                    //             color: leave.bgColor,
                    //             borderRadius: BorderRadius.circular(4),
                    //           ),
                    //           child: Text(
                    //             leave.process,
                    //             style: TextStyle(
                    //               fontSize: 11,
                    //               color: leave.color,
                    //               fontWeight: FontWeight.w600,
                    //             ),
                    //           ),
                    //         ),
                    //         Container(
                    //           height: 25,
                    //           width: 25,
                    //           decoration: BoxDecoration(
                    //             color: CustomColors.leaveAllCardColor,
                    //             borderRadius: BorderRadius.circular(8),
                    //           ),
                    //           child: const Icon(
                    //             Icons.arrow_forward_ios,
                    //             size: 12,
                    //             color: CustomColors.leaveAllIconColor,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
