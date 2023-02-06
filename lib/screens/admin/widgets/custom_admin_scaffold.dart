import 'package:flutter/material.dart';
import 'package:paytym/screens/admin/widgets/custom_tab_bar.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/styles.dart';
import '../../../core/constants/widgets.dart';
import '../../widgets/custom_tab_bar.dart';

class CustomAdminScaffold extends StatelessWidget {
  final List<String> tabList;
  final String title;
  final List<Widget> children;
  const CustomAdminScaffold(
      {super.key, required this.tabList, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabList.length,
      child: Scaffold(
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
                  CustomTabBarAdmin(
                    tabsList: tabList,
                    width: 120,
                  ),
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
