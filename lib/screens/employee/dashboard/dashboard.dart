import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/core/constants/styles.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/employee/calendar/widgets/custom_svg.dart';
import 'package:paytym/screens/employee/dashboard/dashboard_controller.dart';
import 'package:paytym/screens/employee/dashboard/widgets/check_in_out_card.dart';
import 'package:paytym/screens/employee/dashboard/widgets/dashboard_app_bar.dart';
import 'package:paytym/screens/employee/dashboard/widgets/dashboard_colored_card.dart';
import 'package:paytym/screens/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/strings.dart';
import '../../../routes/app_routes.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DashboardController(), fenix: true);
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
            Container(
              color: CustomColors.backgroundColor,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(18, 0, 18, 18),
                child: DashboardAppBar(),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      color: CustomColors.backgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 18, left: 18, right: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Get.find<DashboardController>().getWish(),
                              style: kTextStyleS13W600.copyWith(
                                  color: CustomColors.lightBlueColor),
                            ),
                            kSizedBoxH4,
                            Text(
                              '${Get.find<LoginController>().loginResponseModel?.employee?.firstName ?? ''} ${Get.find<LoginController>().loginResponseModel?.employee?.lastName ?? ''}',
                              style: const TextStyle(
                                color: CustomColors.blackTextColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            kSizedBoxH15,
                            const CheckInOutCard(),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: CustomColors.dashboardGreyBackgroundColor,
                      child: FutureBuilder(
                        future: Get.find<DashboardController>()
                            .fetchDashboardDetails(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          return GridView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(20),
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
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
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
