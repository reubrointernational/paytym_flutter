import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/core/constants/styles.dart';
import 'package:paytym/screens/calendar/widgets/custom_svg.dart';
import 'package:paytym/screens/dashboard/dashboard_controller.dart';
import 'package:paytym/screens/dashboard/widgets/check_in_out_card.dart';
import 'package:paytym/screens/dashboard/widgets/dashboard_app_bar.dart';
import 'package:paytym/screens/dashboard/widgets/dashboard_colored_card.dart';
import 'package:paytym/screens/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/strings.dart';
import '../../routes/app_routes.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.put(DashboardController());
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.scanTime),
        backgroundColor: CustomColors.fabColor,
        child: const CustomSVG(
          IconPath.scanIconSvg,
          size: 23,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 260,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DashboardAppBar(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dashboardController.getWish(),
                          style: kTextStyleS13W600.copyWith(
                              color: CustomColors.darkGreyTextColor),
                        ),
                        Text(
                          '${Get.find<LoginController>().loginResponseModel?.employee?.firstName ?? ''} ${Get.find<LoginController>().loginResponseModel?.employee?.lastName ?? ''}',
                          style: const TextStyle(
                            color: CustomColors.blueTextColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const CheckInOutCard(),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: CustomColors.dashboardGreyBackgroundColor,
                child: GridView.builder(
                  padding: const EdgeInsets.all(20),
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: employeeLeaves.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: employeeLeaves[index]["bgColor"],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DashboardColoredCard(
                            index: index,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
