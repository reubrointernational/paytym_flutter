import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/core/constants/styles.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/calendar/widgets/custom_svg.dart';
import 'package:paytym/screens/dashboard/dashboard_controller.dart';
import 'package:paytym/screens/login/login_controller.dart';
import 'package:paytym/screens/scan_time/scanner_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/widgets/paytym_logo.dart';

import '../../core/constants/strings.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.put(DashboardController());
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ScanTime()),
          );
        },
        backgroundColor: CustomColors.fabColor,
        child: const CustomSVG(
          IconPath.scanIconSvg,
          size: 23,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    dashboardAppBar(),
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
                    checkInCheckOutCard(),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
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
                          child: employeeLeaveDetails(index),
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

  Widget employeeLeaveDetails(int index) {
    final leaves = employeeLeaves[index];
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    "${leaves["total"]}",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: CustomColors.whiteTextColor),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor:
                        CustomColors.whiteCircleAvatarBackgroundColor,
                    radius: 15,
                    child: Icon(
                      leaves["icon"],
                      size: 18,
                      color: leaves["bgColor"],
                    ),
                  ),
                  kSizedBoxH2,
                  Text(
                    leaves["title"],
                    style: const TextStyle(
                        fontSize: 16,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w600,
                        color: CustomColors.whiteTextColor),
                  ),
                  Text(
                    "${leaves["attendance_percentage"]}% attendance",
                    style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 0.5,
                        color: CustomColors.whiteWithOpacityTextColor),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Positioned(
          right: -30,
          top: -20,
          child: CircleAvatar(
            backgroundColor: CustomColors.cardBackgroundCircleColor,
            radius: 50,
          ),
        ),
        const Positioned(
          right: -40,
          bottom: -20,
          child: CircleAvatar(
            backgroundColor: CustomColors.cardBackgroundCircleColor,
            radius: 50,
          ),
        ),
      ],
    );
  }

  Widget checkInCheckOutCard() => SizedBox(
        height: 140,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  kCheckInOutString,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: CustomColors.blueTextColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => RichText(
                        text: TextSpan(
                          text:
                              "${(Get.find<DashboardController>().seconds.value / 60).floor().toString().padLeft(2, '0')}:${Get.find<DashboardController>().seconds.value.remainder(60).toString().padLeft(2, '0')}",
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: CustomColors.grey80x3TextColor),
                          children: const [
                            TextSpan(
                              text: khrsString,
                              style: TextStyle(
                                fontSize: 16,
                                color: CustomColors.grey156x3TextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(
                      () => SizedBox(
                        height: 32,
                        width: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.find<DashboardController>().updateTimer();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColors.blueCardColor,
                            // padding: const EdgeInsets.symmetric(
                            //     horizontal: 10, vertical: 20),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(20),
                                left: Radius.circular(20),
                              ),
                            ),
                          ),
                          child: Text(
                            Get.find<DashboardController>().isTimerOn.value
                                ? kStopString
                                : kStartString,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Obx(
                        () => Text(
                          "$kNowIsString ${Get.find<DashboardController>().time.value}",
                          style: kTextStyleS11W600C255140x3,
                        ),
                      ),
                      const VerticalDivider(
                        width: 20,
                        thickness: 2.5,
                        indent: 2,
                        endIndent: 2,
                      ),
                      Text(
                        Get.find<DashboardController>().getDate(),
                        style: kTextStyleS11W600C255140x3,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      kNextShiftString,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.calendar_month,
                          size: 13,
                          color: CustomColors.greyIconColor,
                        ),
                        kSizedBoxW4,
                        Text(
                          kSep20String,
                          style: kTextStyleS11W600C255140x3,
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.schedule,
                          size: 13,
                          color: CustomColors.greyIconColor,
                        ),
                        kSizedBoxW4,
                        Text(
                          k08PMString,
                          style: kTextStyleS11W600C255140x3,
                        ),
                      ],
                    ),
                    kSizedBoxW25,
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget dashboardAppBar() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              CustomSVG(IconPath.menuSvg, size: 20),
              kSizedBoxW15,
              PaytymLogo(
                size: 18,
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
