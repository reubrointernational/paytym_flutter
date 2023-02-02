import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/enums.dart';
import 'package:paytym/core/constants/list_maps.dart';
import 'package:paytym/screens/calendar/calendar_controller.dart';

import '../../core/colors/colors.dart';
import '../../core/constants/icons.dart';
import '../../core/constants/strings.dart';
import '../../core/constants/styles.dart';
import '../leaves/widgets/leave_dialogue.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      elevation: 0,
      backgroundColor: CustomColors.backgroundColor,
      actions: [
        PopupMenuButton<CalendarTabs>(
          color: CustomColors.blueTextColor,
          onSelected: (CalendarTabs value) =>
              Get.find<CalendarController>().onClickMenuItem(value, context),
          itemBuilder: (BuildContext context) => List.generate(
            kCalendarDropDownItemList.length,
            (index) => PopupMenuItem(
              value: kCalendarDropDownItemList[index].dropDownItem,
              child: Text(
                kCalendarDropDownItemList[index].label,
                style: const TextStyle(
                  color: CustomColors.whiteTextColor,
                ),
              ),
            ),
          ).toList(),
        ),
      ],
      title: Text(
        kCalendarString,
        style: kTextStyleS18W600.copyWith(color: Colors.black),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          child: SvgPicture.asset(
            IconPath.menuSvg,
          ),
        ),
      ),
    );
  }
}
