import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/screens/employees_screens/reports/reports_controller.dart';

import '../../../../core/constants/styles.dart';

class CustomMonthsTabBar extends StatelessWidget {
  final List<String> tabsList;
  final Color backgroundColor;
  final double width;
  final bool swapBlackWhiteText;
  final TabController? controller;
  const CustomMonthsTabBar(
      {Key? key,
      required this.tabsList,
      required this.backgroundColor,
      this.controller,
      this.width = 50,
      this.swapBlackWhiteText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
      decoration: BoxDecoration(
          color: CustomColors.whiteTextColor,
          borderRadius: BorderRadius.circular(10)),
      child: TabBar(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(right: 10),
        controller: controller,
        labelPadding: const EdgeInsets.symmetric(horizontal: 0),
        indicatorColor: Colors.transparent,
        /*indicator: BoxDecoration(
            color: CustomColors.blueTextColor,
            borderRadius: BorderRadius.circular(9)),*/
        labelColor: CustomColors.blueTextColor,
        unselectedLabelColor: swapBlackWhiteText ? Colors.grey.shade300 : null,
        labelStyle: kTextStyleS14W600LS0p2,
        isScrollable: true,
        /*tabs: tabsList
              .map((e) => Tab(
                    text: e,
                  ))
              .toList()*/
        tabs: tabsList
            .map((e) => Container(
                  //height: 40,
                  width: 60,
                  margin: const EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                    color: CustomColors.whiteTabColor,
                    borderRadius: BorderRadius.circular(40),
                    border:
                        Border.all(width: 1, color: CustomColors.blueTextColor),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    e,
                    style: const TextStyle(
                      color: CustomColors.blueTextColor,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
