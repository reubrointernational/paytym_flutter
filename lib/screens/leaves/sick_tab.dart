import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/strings.dart';
import '../../models/leaves/leaves_response.dart';
import 'leaves_controller.dart';
import 'widgets/leave_card.dart';

class SickLeavesPage extends StatelessWidget {
  const SickLeavesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        List<LeaveRequest>? casualLeaves = Get.find<LeavesController>()
            .leaveResponseModel
            .value
            .leaveRequests
            ?.where((element) => element.type == ksickString)
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
