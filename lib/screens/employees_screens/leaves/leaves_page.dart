import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/employees_screens/leaves/leaves_controller.dart';
import 'package:flutter/material.dart';
import 'package:paytym/screens/employees_screens/leaves/leaves_tab.dart';
import 'package:paytym/screens/widgets/custom_tab_bar.dart';
import '../../../core/constants/strings.dart';
import 'widgets/leaves_app_bar.dart';

class LeavesPage extends StatelessWidget {
  const LeavesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LeavesController());
    return DefaultTabController(
      length: leaveTabList.length,
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                const LeavesAppBar(),
                kSizedBoxH15,
                CustomTabBar(
                  tabsList: leaveTabList,
                  backgroundColor: Colors.grey.shade200,
                ),
                kSizedBoxH10,
                Expanded(
                  child: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    children:
                        leaveTabList.map((e) => LeavesTab(leave: e)).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
