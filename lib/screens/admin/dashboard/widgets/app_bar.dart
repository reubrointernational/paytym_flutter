import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/screens/employee/bottom_nav/bottom_nav_page.dart';

import '../../../../core/constants/icons.dart';
import '../../../../core/constants/widgets.dart';
import '../../../../routes/app_routes.dart';
import '../../../employee/calendar/widgets/custom_svg.dart';
import '../../../widgets/paytym_logo.dart';
import '../../bottom_nav/bottom_nav_page.dart';

class HrAppBar extends StatelessWidget {
  const HrAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            CustomSVG(
              IconPath.menuSvg,
              size: 20,
              color: CustomColors.whiteCardColor,
            ),
            kSizedBoxW15,
            PaytymLogo(
              size: 60,
              color: CustomColors.whiteCardColor,
            )
          ],
        ),
        PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                value: 0,
                child: Text("Employee Profile"),
              ),
            ];
          },
          onSelected: (value) {
            Get.back();
          },
          child: const CircleAvatar(
            radius: 20,
            backgroundColor: CustomColors.whiteCardColor,
          ),
        ),
      ],
    );
  }
}
