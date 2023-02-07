import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/admin/dashboard/dashboard_controller.dart';
import 'package:paytym/screens/admin/reports/reports_controller.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/icons.dart';
import '../dashboard/widgets/filter_bottom_sheet.dart';
import '../leaves/leaves_controller.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final bool isLeavesController;
  const CustomFloatingActionButton({super.key, this.isLeavesController = true});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showCustomBottomSheet(
            context,
            isLeavesController
                ? Get.find<LeavesControllerAdmin>()
                : Get.find<ReportsControllerAdmin>());
      },
      backgroundColor: CustomColors.lightBlueColor,
      child: Image.asset(
        IconPath.filterIconPng,
        height: 22,
      ),
    );
  }
}
