import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:paytym/models/leaves/leaves_admin_response_model.dart';
import 'leaves_controller.dart';
import 'widgets/leave_card.dart';

class LeavesTabAdmin extends StatelessWidget {
  final String leave;
  const LeavesTabAdmin(this.leave, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<LeaveList>? allLeaves;
      allLeaves =
          // (leave == 'Today')
          //     ?
          Get.find<LeavesControllerAdmin>()
              .leaveAdminResponseModel
              .value
              .leaveList;
      // : Get.find<LeavesControllerAdmin>()
      //     .leaveAdminResponseModel
      //     .value
      //     .leaveList
      //     .where((element) =>
      //         element.type?.toLowerCase() == leave.toLowerCase())
      //     .toList();
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: allLeaves.length,
        itemBuilder: (context, index) {
          final leave = allLeaves?[index];
          return LeavesCardAdmin(leave: leave);
        },
      );
    });
  }
}
