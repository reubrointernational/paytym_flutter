import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:paytym/screens/employee/leaves/leaves_controller.dart';
import '../../../models/leaves/leaves_response.dart';
import 'widgets/leave_card.dart';

class LeavesTab extends StatefulWidget {
  final String leave;
  const LeavesTab({Key? key, required this.leave}) : super(key: key);

  @override
  State<LeavesTab> createState() => _LeavesTabState();
}

class _LeavesTabState extends State<LeavesTab> {
  late Timer timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      print("timer from leave employee ");
      Get.find<LeavesController>().fetchLeaveData();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<LeaveRequest>? allLeaves;
      allLeaves = (widget.leave == 'All')
          ? Get.find<LeavesController>().leaveResponseModel.value.leaveRequests
          : Get.find<LeavesController>()
              .leaveResponseModel
              .value
              .leaveRequests
              ?.where((element) =>
                  element.leaveType!.leaveType.toLowerCase().trim() ==
                  widget.leave.toLowerCase())
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
