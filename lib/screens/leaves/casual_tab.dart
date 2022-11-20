import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/leaves/leaves_response.dart';
import 'leaves_controller.dart';
import 'widgets/leave_card.dart';

class CasualLeavesPage extends StatelessWidget {
  const CasualLeavesPage({Key? key}) : super(key: key);

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
          physics: const BouncingScrollPhysics(),
          itemCount: casualLeaves?.length ?? 0,
          itemBuilder: (context, index) {
            final leave = casualLeaves?[index];
            return LeavesCard(leave: leave);
          },
        );
      },
    );
  }
}
