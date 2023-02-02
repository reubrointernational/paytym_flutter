import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';

import '../../../core/constants/icons.dart';
import '../../../core/constants/widgets.dart';
import '../../calendar/widgets/custom_svg.dart';
import '../../widgets/paytym_logo.dart';

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
        const CircleAvatar(
          radius: 20,
          backgroundColor: CustomColors.whiteCardColor,
        ),
      ],
    );
  }
}
