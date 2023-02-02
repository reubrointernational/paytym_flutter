import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/screens/reports/reports_controller.dart';

import '../../core/constants/enums.dart';
import '../../core/constants/strings.dart';
import '../../core/constants/styles.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> tabsList;
  final Color backgroundColor;
  final double width;
  final bool swapBlackWhiteText;
  const CustomTabBar(
      {Key? key,
      required this.tabsList,
      required this.backgroundColor,
      this.width = 50,
      this.swapBlackWhiteText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
      decoration: BoxDecoration(
          color: CustomColors.whiteTextColor,
          borderRadius: BorderRadius.circular(10)),
      child: TabBar(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(right: 10),
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
                  height: 50,
                  width: 100,
                  margin: const EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                          width: 1, color: CustomColors.blueTextColor)),
                  alignment: Alignment.center,
                  child: Text(
                    e,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
