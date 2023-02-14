import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/login/login_controller.dart';
import '../../../core/colors/colors.dart';
import '../../../core/constants/styles.dart';
import '../../../core/constants/widgets.dart';
import 'custom_floating_action_button.dart';
import '../../widgets/custom_tab_bar.dart';

class CustomAdminScaffoldWithTabBar extends StatelessWidget {
  final List<String> tabList;
  final String title;
  final List<Widget> children;

  const CustomAdminScaffoldWithTabBar(
      {super.key,
      required this.tabList,
      required this.title,
      required this.children});


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Get.find<LoginController>().initialIndex = 0);
    return DefaultTabController(
      initialIndex: Get.find<LoginController>().initialIndex ?? 0,
      length: tabList.length,
      child: Scaffold(
        floatingActionButton: CustomFloatingActionButton(
          isLeavesController: title == 'Leaves',
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            title,
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
                  CustomTabBar(tabsList: tabList),
                  kSizedBoxH10,
                  Expanded(
                    child: TabBarView(
                      physics: const BouncingScrollPhysics(),
                      children: children,
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
