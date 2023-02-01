import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/employee/leaves/leaves_controller.dart';
import 'package:flutter/material.dart';
import 'package:paytym/screens/employee/leaves/leaves_tab.dart';
import 'package:paytym/screens/widgets/custom_tab_bar.dart';
import '../../../core/constants/strings.dart';
import '../../../core/constants/styles.dart';

class LeavesPageAdmin extends StatelessWidget {
  const LeavesPageAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LeavesController());
    return DefaultTabController(
      length: leaveTabList.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            kLeavesString,
            style: kTextStyleS18W600white,
          ),
          elevation: 0,
          backgroundColor: Colors.lightBlue,
        ),
        backgroundColor: CustomColors.lightBlueColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
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
      ),
    );
  }
}
