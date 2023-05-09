import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/styles.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/models/leaves/leaves_status_model.dart';

import '../../../../core/colors/colors.dart';
import '../../../../models/leaves/leaves_response.dart';
import '../leaves_controller.dart';

class LeavesCard extends StatelessWidget {
  final LeaveRequest? leave;
  const LeavesCard({super.key, this.leave});

  @override
  Widget build(BuildContext context) {
    LeaveStatusModel leaveStatusModel =
        Get.find<LeavesController>().getLeaveStatusModel(leave?.status);
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Get.find<LeavesController>().getMonthFromDate(leave?.startDate),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: CustomColors.blueTextColor,
            ),
          ),
          kSizedBoxH10,
          Stack(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: const Color.fromRGBO(200, 195, 226, 1),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      leave?.leaveType?.leaveType ?? '',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    kSizedBoxH3,
                    Text(
                      (leave?.leaveType?.leaveType.toLowerCase().trim() ??
                                  '') ==
                              'Halfday'.trim()
                          ? Get.find<LeavesController>()
                              .formatDate(leave?.startDate)
                          : '${Get.find<LeavesController>().formatDate(leave?.startDate)}-${Get.find<LeavesController>().formatDate(leave?.endDate)}',
                      style: kTextStyleS18W600,
                    ),
                    kSizedBoxH3,
                    Text(
                      leave?.title ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: CustomColors.greyHeadingTextColor,
                      ),
                    ),
                    kSizedBoxH3,
                    Text(
                      leave?.reason ?? '',
                      style: const TextStyle(
                        color: CustomColors.greyHeadingTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 10,
                top: 15,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: leaveStatusModel.textColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    leaveStatusModel.text,
                    style: const TextStyle(
                      fontSize: 11,
                      color: CustomColors.whiteTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
