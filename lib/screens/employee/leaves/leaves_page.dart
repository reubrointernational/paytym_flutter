import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/employee/leaves/leaves_controller.dart';
import 'package:flutter/material.dart';
import 'package:paytym/screens/employee/leaves/leaves_tab.dart';
import 'package:paytym/screens/widgets/custom_tab_bar.dart';
import '../../../core/constants/strings.dart';
import 'widgets/leaves_app_bar.dart';

class LeavesPage extends StatelessWidget {
  const LeavesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<LeavesController>().fetchLeaveData();
    });
    Get.put(LeavesController());
    return FutureBuilder<bool>(
        future: Get.find<LeavesController>().getLeaveTypes(),
        builder: (context, snapshot) {
          List<String> tabList = ['All'];
          tabList.addAll(Get.find<LeavesController>()
                  .leaveTypesModel
                  .value
                  .leaveTypes
                  ?.map((e) => e.leaveType ?? '') ??
              []);

          return DefaultTabController(
            length: tabList.length,
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
                        tabsList: tabList,
                        color: CustomColors.blueTextColor,
                      ),
                      kSizedBoxH10,
                      Expanded(
                        child: TabBarView(
                          physics: const BouncingScrollPhysics(),
                          children:
                              tabList.map((e) => LeavesTab(leave: e)).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
