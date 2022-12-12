import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/strings.dart';
import '../../models/leaves/leaves_response.dart';
import 'leaves_controller.dart';
import 'widgets/leave_card.dart';

class OtherLeavesPage extends StatelessWidget {
  const OtherLeavesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        List<LeaveRequest>? otherLeaves = Get.find<LeavesController>()
            .leaveResponseModel
            .value
            .leaveRequests
            ?.where((element) => element.type != ksickString)
            .toList();
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: otherLeaves?.length ?? 0,
          itemBuilder: (context, index) {
            final leave = otherLeaves?[index];
            return LeavesCard(leave: leave);
          },
        );
      },
    );
  }
}
