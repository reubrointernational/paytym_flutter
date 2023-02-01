import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:paytym/screens/employee/leaves/leaves_controller.dart';
import '../../../models/leaves/leaves_response.dart';
import 'widgets/leave_card.dart';

class LeavesTab extends StatelessWidget {
  final String leave;
  const LeavesTab({Key? key, required this.leave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(leave);
    return Obx(() {
      List<LeaveRequest>? allLeaves;
      allLeaves = (leave == 'All')
          ? Get.find<LeavesController>().leaveResponseModel.value.leaveRequests
          : Get.find<LeavesController>()
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
          return LeavesCard(leave: leave);
        },
      );
    });
  }
}
