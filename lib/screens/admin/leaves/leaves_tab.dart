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
      print(" leaveTabListAdmin[addPostFrameCallback]");
      Future.delayed(const Duration(milliseconds: 500), () {
        print(" leaveTabListAdmin[Future.delayed]");
        leave != leaveTabListAdmin[1]
            ? Get.find<LeavesControllerAdmin>().fetchLeaveData(1)
            : Get.find<LeavesControllerAdmin>().fetchLeaveData(3);
      });
    });
    return Obx(
      () {
        List<LeaveRequest>? allLeaves;
        print(" leaveTabListAdmin[0.obx]");
        if (leave == leaveTabListAdmin[2]) {
          print(" leaveTabListAdmin[2]");
          allLeaves = Get.find<LeavesControllerAdmin>()
              .getFilteredLeavesList()!
              .where((element) => Get.find<LeavesControllerAdmin>()
                  .isToday(element.createdAt ?? DateTime.now()))
              .toList();
        } else if (leave == leaveTabListAdmin[3]) {
          print(" leaveTabListAdmin[3]");
          allLeaves = Get.find<LeavesControllerAdmin>()
              .getFilteredLeavesList()!
              .where((element) => Get.find<LeavesControllerAdmin>()
                  .isYesterday(element.createdAt ?? DateTime.now()))
              .toList();
        } else if (leave == leaveTabListAdmin[0]) {
          print(" leaveTabListAdmin[0]");
          allLeaves = Get.find<LeavesControllerAdmin>().getFilteredLeavesList();
        } else {
          print(" leaveTabListAdmin[0.1]");
          allLeaves =
              Get.find<LeavesControllerAdmin>().getFilteredLeavesList(3);
          allLeaves?.sort((a, b) => b.status!.compareTo(a.status!));
          allLeaves?.sort((a, b) => a.status!.compareTo(b.status!));
        }

        if (allLeaves!.isEmpty) {
          return Center(
            child: Text(
              'No Pending Items ',
              style: TextStyle(
                  color: Colors.blue.shade800,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          );
        } else {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: allLeaves?.length ?? 0,
            itemBuilder: (context, index) {
              final leave = allLeaves?[index];
              return LeavesCardAdmin(
                leave: leave,
                index: index,
              );
            },
          );
        }
      },
    );
  }
}
