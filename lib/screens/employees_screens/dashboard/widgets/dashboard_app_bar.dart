import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants/icons.dart';
import '../../../../core/constants/widgets.dart';
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
            Stack(children: const [
              Icon(Icons.notifications_outlined),
              Positioned(
                right: 0,
                top: 2,
                child: CircleAvatar(
                  backgroundColor: CustomColors.redColor,
                  radius: 5,
                ),
              ),
            ]),
            kSizedBoxW15,
            CachedNetworkImage(
              imageUrl: Get.find<LoginController>()
                      .loginResponseModel
                      ?.employee
                      ?.image ??
                  '',
              imageBuilder: (context, imageProvider) => CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                radius: 15,
                backgroundImage: imageProvider,
              ),
              placeholder: (context, url) => const SpinKitDoubleBounce(
                color: Colors.white,
                size: 7.5,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ],
        ),
      ],
    );
  }
}
