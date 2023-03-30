import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:paytym/core/constants/strings.dart';
import 'package:paytym/models/leaves/leaves_admin_response_model.dart';
import 'leaves_controller.dart';
import 'widgets/leave_card.dart';

class LeavesTabAdmin extends StatelessWidget {
  final String leave;
  const LeavesTabAdmin(this.leave, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<LeavesControllerAdmin>().fetchLeaveData(1);
    });
    return Obx(
      () {
        List<LeaveRequest>? allLeaves;
        if (leave == leaveTabListAdmin[0]) {
          allLeaves = Get.find<LeavesControllerAdmin>()
              .getFilteredLeavesList()!
              .where((element) => Get.find<LeavesControllerAdmin>()
                  .isToday(element.createdAt ?? DateTime.now()))
              .toList();
        } else if (leave == leaveTabListAdmin[1]) {
          allLeaves = Get.find<LeavesControllerAdmin>()
              .getFilteredLeavesList()!
              .where((element) => Get.find<LeavesControllerAdmin>()
                  .isYesterday(element.createdAt ?? DateTime.now()))
              .toList();
        } else {
          allLeaves = Get.find<LeavesControllerAdmin>().getFilteredLeavesList();
        }

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: allLeaves?.length,
          itemBuilder: (context, index) {
            final leave = allLeaves?[index];

            return LeavesCardAdmin(
              leave: leave,
              index: index,
            );
          },
        );
      },
    );
  }
}
