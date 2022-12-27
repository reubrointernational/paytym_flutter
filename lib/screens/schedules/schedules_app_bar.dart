import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../core/constants/icons.dart';
import '../../core/constants/styles.dart';
import '../calendar/widgets/custom_svg.dart';

class SchedulesAppBar extends StatelessWidget {
  const SchedulesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        children: const [
          CustomSVG(IconPath.menuSvg, size: 20),
          SizedBox(
            width: 15,
          ),
          Text(
            'Schedules',
            style: kTextStyleS18W600,
          ),
        ],
      ),
      const CustomSVG(IconPath.settingsSvg, size: 23),
    ]);
  }
}
