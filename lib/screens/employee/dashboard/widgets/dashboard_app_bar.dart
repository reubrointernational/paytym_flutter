import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/employee/dashboard/dashboard_controller.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/icons.dart';
import '../../../../core/constants/list_maps.dart';
import '../../../../core/constants/widgets.dart';
import '../../../../network/end_points.dart';
import '../../../../routes/app_routes.dart';
import '../../calendar/widgets/custom_svg.dart';
import '../../../login/login_controller.dart';
import '../../../widgets/paytym_logo.dart';

class DashboardAppBar extends StatelessWidget {
  const DashboardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            CustomSVG(IconPath.menuSvg, size: 20),
            kSizedBoxW15,
            PaytymLogo(
              size: 60,
            )
          ],
        ),
        Row(
          children: [
            kSizedBoxW15,
            PopupMenuButton<DashboardDropDown>(
              color: CustomColors.blueTextColor,
              itemBuilder: (BuildContext context) {
                return [
                  if (Get.find<LoginController>()
                          .loginResponseModel
                          ?.capabilities
                          ?.first
                          .role
                          ?.id !=
                      5)
                    PopupMenuItem(
                      value: kDashboardDropDownItemList[3].dropDownItem,
                      child: Text(
                        kDashboardDropDownItemList[3].label,
                        style: const TextStyle(
                          color: CustomColors.whiteTextColor,
                        ),
                      ),
                    ),
                  ...List.generate(
                    3,
                    (index) => PopupMenuItem(
                      value: kDashboardDropDownItemList[index].dropDownItem,
                      child: Text(
                        kDashboardDropDownItemList[index].label,
                        style: const TextStyle(
                          color: CustomColors.whiteTextColor,
                        ),
                      ),
                    ),
                  ).toList()
                ];
              },
              onSelected: (DashboardDropDown value) =>
                  Get.find<DashboardController>().onClickMenuItem(value),
              child: CachedNetworkImage(
                imageUrl:
                    '$kImageUrl${Get.find<LoginController>().loginResponseModel?.employee?.image}',
                imageBuilder: (context, imageProvider) => Animate(
                  effects: const [
                    ScaleEffect(duration: Duration(microseconds: 500))
                  ],
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
        ),
      ],
    );
  }
}
