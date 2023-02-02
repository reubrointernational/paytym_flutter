import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/styles.dart';
import 'package:paytym/models/leaves/leaves_status_model.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../models/leaves/leaves_response.dart';
import '../leaves_controller.dart';
import 'package:paytym/core/extensions/camelcase.dart';

class LeavesCard extends StatelessWidget {
  final LeaveRequest? leave;
  const LeavesCard({super.key, this.leave});

  @override
  Widget build(BuildContext context) {
    LeaveStatusModel leaveStatusModel =
        Get.find<LeavesController>().getLeaveStatusModel(leave?.status);
    return Container(
      height: 120,
      margin: const EdgeInsets.only(top: 10),
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
          Container(
            height: 90,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: const Color.fromRGBO(200, 195, 226, 1),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        leave?.title ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: CustomColors.greyHeadingTextColor,
                        ),
                      ),
                      Text(
                        '${Get.find<LeavesController>().formatDate(leave?.startDate)}-${Get.find<LeavesController>().formatDate(leave?.endDate)}',
                        style: kTextStyleS18W600,
                      ),
                      Text(
                        leave?.type?.toCamelCase() ?? '',
                        style: TextStyle(
                          fontSize: 15,
                          color: (leave?.type == kcasualString)
                              ? CustomColors.orangeLabelColor
                              : CustomColors.blueLabelColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
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
                    Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        color: CustomColors.blueTextColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: CustomColors.whiteTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
