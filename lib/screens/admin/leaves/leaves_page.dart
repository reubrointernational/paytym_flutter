import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/admin/widgets/custom_admin_scaffold.dart';
import 'package:paytym/screens/employee/leaves/leaves_controller.dart';
import 'package:flutter/material.dart';
import 'package:paytym/screens/widgets/custom_tab_bar.dart';
import '../../../core/constants/strings.dart';
import '../../../core/constants/styles.dart';
import 'leaves_controller.dart';
import 'leaves_tab.dart';

class LeavesPageAdmin extends StatelessWidget {
  const LeavesPageAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LeavesControllerAdmin());
    return CustomAdminScaffold(
      tabList: leaveTabList,
      title: kLeavesString,
      children: leaveTabList.map((e) => LeavesTabAdmin(e)).toList(),
    );
  }
}
