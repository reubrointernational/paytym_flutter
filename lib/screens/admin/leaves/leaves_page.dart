import 'package:get/get.dart';
import 'package:paytym/screens/admin/widgets/custom_admin_scaffold_with_tabbar.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/strings.dart';
import 'leaves_controller.dart';
import 'leaves_tab.dart';

class LeavesPageAdmin extends StatelessWidget {
  const LeavesPageAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LeavesControllerAdmin());
    return CustomAdminScaffoldWithTabBar(
      tabList: leaveTabListAdmin,
      title: kLeavesString,
      children:
          leaveTabList.getRange(0, 3).map((e) => LeavesTabAdmin(e)).toList(),
    );
  }
}
