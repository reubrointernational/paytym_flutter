import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytym/core/constants/enums.dart';
import 'package:paytym/core/constants/styles.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/admin/reports/reports_controller.dart';

import '../../../../core/colors/colors.dart';
import '../../../../models/leaves/leaves_admin_response_model.dart';
import '../leaves_controller.dart';

class LeavesCardAdmin extends StatelessWidget {
  final LeaveRequest? leave;
  final int index;
  const LeavesCardAdmin({super.key, this.leave, required this.index});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<LeavesControllerAdmin>().getLeaveTypes();
    });
    Get.put(ReportsControllerAdmin());
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${DateFormat('dd/MM/yyyy').format(DateTime.parse(leave?.startDate ?? ''))} - ${DateFormat('dd/MM/yyyy').format(DateTime.parse(leave?.endDate ?? ''))}',
            style: kTextStyleS15W600CGrey,
          ),
          kSizedBoxH10,
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: CustomColors.greyCardBorderColor,
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${leave?.user?.firstName} ${leave?.user?.lastName}',
                            overflow: TextOverflow.ellipsis,
                            style: kTextStyleS18W600,
                          ),
                          kSizedBoxH3,
                          Text(
                            '#${leave?.userId.toString().padLeft(5, '0') ?? ''}',
                            // '${Get.find<LeavesControllerAdmin>().formatDate(leave?.startDate)}-${Get.find<LeavesControllerAdmin>().formatDate(leave?.endDate)}',
                            style: const TextStyle(
                              color: CustomColors.greyHeadingTextColor,
                            ),
                          ),
                          kSizedBoxH3,
                          Text(
                            Get.find<LeavesControllerAdmin>()
                                .getLeaveType(leave?.type),
                            style: const TextStyle(
                              fontSize: 15,
                              color: CustomColors.blueLabelColor,
                            ),
                          ),
                          kSizedBoxH3,
                          Text(
                            leave?.title ?? '',
                            style: kTextStyleS13W500Cgrey,
                          ),
                        ],
                      ),
                    ),
                    if (leave!.status == '0')
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.find<LeavesControllerAdmin>()
                                  .selectedLeaveRequest = leave!;
                              Get.find<LeavesControllerAdmin>()
                                  .showBottomSheetForReason(
                                      ReasonButton.leaveDecline);
                            },
                            child: Container(
                              width: 75,
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
                          ),
                          kSizedBoxH8,
                          GestureDetector(
                            onTap: () {
                              Get.find<LeavesControllerAdmin>()
                                  .selectedLeaveRequest = leave!;
                              Get.find<LeavesControllerAdmin>()
                                  .showBottomSheetForReason(
                                      ReasonButton.leaveApprove);
                            },
                            child: Container(
                              width: 75,
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
                          ),
                        ],
                      ),
                    if (leave!.status != '0')
                      CircleAvatar(
                        backgroundColor:
                            leave!.status == '1' ? Colors.green : Colors.red,
                        child: Icon(
                          leave!.status == '1' ? Icons.check : Icons.close,
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
                if (leave?.reason?.isNotEmpty ?? false) kSizedBoxH3,
                if (leave?.reason?.isNotEmpty ?? false)
                  Text(
                    leave?.reason ?? "",
                    style: const TextStyle(
                      fontSize: 15,
                      color: CustomColors.blueLabelColor,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
