import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/styles.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/models/leaves/leaves_status_model.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../models/leaves/leaves_response.dart';
import '../leaves_controller.dart';
import 'package:paytym/core/extensions/camelcase.dart';

class LeavesCardAdmin extends StatelessWidget {
  final LeaveRequest? leave;
  const LeavesCardAdmin({super.key, this.leave});

  @override
  Widget build(BuildContext context) {
    LeaveStatusModel leaveStatusModel =
        Get.find<LeavesControllerAdmin>().getLeaveStatusModel(leave?.status);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 90,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: CustomColors.greyCardBorderColor,
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Smith',
                        // leave?.title ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: kTextStyleS18W600,
                      ),
                      const Text(
                        '004578457',
                        // '${Get.find<LeavesControllerAdmin>().formatDate(leave?.startDate)}-${Get.find<LeavesControllerAdmin>().formatDate(leave?.endDate)}',
                        style: TextStyle(
                          color: CustomColors.greyHeadingTextColor,
                        ),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 65,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Decline',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    kSizedBoxH8,
                    Container(
                      width: 65,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Approve',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
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
