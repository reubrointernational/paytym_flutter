import 'package:flutter/material.dart';
import 'package:paytym/core/colors/colors.dart';

import '../../../core/constants/styles.dart';

class CustomTabBarAdmin extends StatelessWidget {
  final List<String> tabsList;

  final double width;

  const CustomTabBarAdmin({
    Key? key,
    required this.tabsList,
    this.width = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
        indicatorWeight: 0,
        physics: const BouncingScrollPhysics(),
        indicator: BoxDecoration(
          color: CustomColors.lightBlueColor,
          borderRadius: BorderRadius.circular(22),
        ),
        //padding: EdgeInsets.zero,
        labelPadding: const EdgeInsets.symmetric(horizontal: 4),
        labelColor: Colors.white,
        unselectedLabelColor: CustomColors.lightBlueColor,
        labelStyle: kTextStyleS14W600LS0p2,
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: tabsList
            .map((e) => Container(
                  width: width,
                  height: 44,
                  decoration: BoxDecoration(
                    border: Border.all(color: CustomColors.lightBlueColor),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Tab(
                    text: e,
                  ),
                ))
            .toList());
  }
}
