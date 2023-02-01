import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:paytym/screens/employee/leaves/leaves_controller.dart';
import '../../../models/leaves/leaves_response.dart';
import 'leaves_controller.dart';
import 'widgets/leave_card.dart';

class LeavesTabAdmin extends StatelessWidget {
  final String leave;
  const LeavesTabAdmin(this.leave,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(leave);
    return Obx(() {
      List<LeaveRequest>? allLeaves;
      allLeaves = (leave == 'All')
          ? Get.find<LeavesControllerAdmin>()
              .leaveResponseModel
              .value
              .leaveRequests
          : Get.find<LeavesControllerAdmin>()
              .leaveResponseModel
              .value
              .leaveRequests
              ?.where((element) =>
                  element.type?.toLowerCase() == leave.toLowerCase())
              .toList();
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: allLeaves?.length ?? 0,
        itemBuilder: (context, index) {
          final leave = allLeaves?[index];
          return LeavesCardAdmin(leave: leave);
        },
      );
    });
  }
}
