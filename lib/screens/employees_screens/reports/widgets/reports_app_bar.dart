import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/icons.dart';
import '../../../../core/constants/list_maps.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/constants/widgets.dart';
import '../../calendar/widgets/custom_svg.dart';
import '../reports_controller.dart';

class ReportsAppBar extends StatelessWidget {
  const ReportsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            CustomSVG(IconPath.menuSvg, size: 20),
            kSizedBoxW15,
            Text(
              kReportsString,
              style: kTextStyleS18W600,
            ),
          ],
        ),
        PopupMenuButton<ReportsDropDown>(
          color: CustomColors.blueTextColor,
          onSelected: (ReportsDropDown value) =>
              Get.find<ReportsController>().onClickMenuItem(value),
          itemBuilder: (BuildContext context) => List.generate(
            4,
            (index) => PopupMenuItem(
              value: kReportDropDownItemList[index].dropDownItem,
              child: Text(
                kReportDropDownItemList[index].label,
                style: const TextStyle(
                  color: CustomColors.whiteTextColor,
                ),
              ),
            ),
          ).toList(),
        ),
      ],
    );
  }
}
