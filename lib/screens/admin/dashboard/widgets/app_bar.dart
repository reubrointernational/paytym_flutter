import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/constants/icons.dart';
import '../../../../core/constants/list_maps.dart';
import '../../../../core/constants/widgets.dart';
import '../../../employee/calendar/widgets/custom_svg.dart';
import '../../../employee/dashboard/dashboard_controller.dart';
import '../../../login/login_controller.dart';
import '../../../widgets/paytym_logo.dart';

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
          color: CustomColors.lightBlueColor,
          itemBuilder: (BuildContext context) => List.generate(
            2,
            (index) => PopupMenuItem(
              value: kReportDropDownItemListWorkProfile[index].dropDownItem,
              child: Text(
                kReportDropDownItemListWorkProfile[index].label,
                style: const TextStyle(
                  color: CustomColors.whiteTextColor,
                ),
              ),
            ),
          ).toList(),
          onSelected: (DashboardDropDown value) =>
              Get.find<DashboardController>().onClickMenuItem(value),
          child: CachedNetworkImage(
            imageUrl: 'https://paytym.net/storage/${Get.find<LoginController>()
                        .loginResponseModel
                        ?.employee
                        ?.image ?? ''}',
            imageBuilder: (context, imageProvider) => CircleAvatar(
              backgroundColor: CustomColors.whiteCardColor,
              radius: 17,
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                radius: 15,
                backgroundImage: imageProvider,
              ),
            ),
            placeholder: (context, url) => const SpinKitDoubleBounce(
              color: Colors.white,
              size: 7.5,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ],
    );
  }
}
