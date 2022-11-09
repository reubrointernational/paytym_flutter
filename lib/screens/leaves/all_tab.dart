import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:paytym/screens/leaves/leaves_controller.dart';
import 'widgets/leave_card.dart';

class AllLeavesPage extends StatelessWidget {
  const AllLeavesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
          itemCount: Get.find<LeavesController>()
                  .leaveResponseModel
                  .value
                  .leaveRequests
                  ?.length ??
              0,
          itemBuilder: (context, index) {
            final leave = Get.find<LeavesController>()
                .leaveResponseModel
                .value
                .leaveRequests?[index];
            return LeavesCard(leave: leave);
          },
        ));
  }
}
