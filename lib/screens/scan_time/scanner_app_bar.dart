import 'package:flutter/material.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/employee/calendar/widgets/custom_svg.dart';

import '../../core/constants/icons.dart';
import '../../core/constants/strings.dart';
import '../../core/constants/styles.dart';

class ScannerAppBar extends StatelessWidget {
  const ScannerAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              CustomSVG(IconPath.menuSvg, size: 20),
              kSizedBoxW15,
              Text(
                kScanString,
                style: kTextStyleS18W600,
              ),
            ],
          ),
          const CustomSVG(IconPath.settingsSvg, size: 23),
        ],
      ),
    );
  }
}
