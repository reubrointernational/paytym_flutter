import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/admin/dashboard/dashboard_controller.dart';
import '../../../core/constants/icons.dart';
import '../../../core/constants/strings.dart';
import '../../../routes/app_routes.dart';
import '../../employee/calendar/widgets/custom_svg.dart';
import '../../login/login_controller.dart';
import 'widgets/app_bar.dart';
import 'widgets/custom_cards.dart';
import 'widgets/check_in_out_card_admin.dart';

class DashboardAdmin extends StatelessWidget {
  const DashboardAdmin({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(DashboardControllerAdmin(), permanent: true);
    return Scaffold(
      floatingActionButton: Animate(
        effects: const [
          ShakeEffect(hz: 0.8, rotation: 90, duration: Duration(seconds: 2)),
          SlideEffect()
        ],
        child: FloatingActionButton(
          onPressed: () => Get.toNamed(Routes.scanTime),
          backgroundColor: CustomColors.lightBlueColor,
          child: const CustomSVG(
            IconPath.scanIconSvg,
            size: 23,
          ),
        ),
      ),
      backgroundColor: CustomColors.lightBlueColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
              child: HrAppBar(),
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Welcome',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: CustomColors.whiteTextColor,
                            ),
                          ),
                          kSizedBoxH4,
                          Text(
                            '${Get.find<LoginController>().loginResponseModel?.employee?.firstName ?? ''} ${Get.find<LoginController>().loginResponseModel?.employee?.lastName ?? ''}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: CustomColors.blackTextColor,
                            ),
                          ).animate().tint(color: Colors.white),
                        ],
                      ),
                    ),
                    kSizedBoxH4,
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        decoration: BoxDecoration(
                          color: CustomColors.whiteCardColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: const [
                            CheckInOutCardAdmin(),
                            kSizedBoxH10,
                            CustomCardDetails(),
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
