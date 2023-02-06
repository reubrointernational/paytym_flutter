import 'package:flutter/material.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/strings.dart';

import '../../core/constants/styles.dart';

class CustomTabBar extends StatelessWidget {
  final double height;
  final List<String> tabsList;
  final Color color;
  final double width;

  const CustomTabBar({
    Key? key,
    required this.tabsList,
    this.color = CustomColors.lightBlueColor,
    this.width = 50, this.height = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
        physics: const BouncingScrollPhysics(),
        labelPadding: const EdgeInsets.symmetric(horizontal: 5),
        indicator: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(25)),
        labelColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelColor: color,
        labelStyle: kTextStyleS14W600LS0p2,
        isScrollable: true,
        tabs: tabsList
            .map((e) => Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: color),
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(horizontal: width),
                  child: Tab(
                    text: e,
                    height: height,
                  ),
                ))
            .toList());
  }
}
