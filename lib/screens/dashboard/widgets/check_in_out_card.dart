import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../core/constants/styles.dart';
import '../../../core/constants/widgets.dart';
import '../dashboard_controller.dart';

class CheckInOutCard extends StatelessWidget {
  const CheckInOutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
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
  }
}
