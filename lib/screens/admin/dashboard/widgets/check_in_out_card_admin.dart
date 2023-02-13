import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/custom_slider_thumb.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/constants/widgets.dart';
import '../../../employee/dashboard/dashboard_controller.dart';

class CheckInOutCardAdmin extends StatelessWidget {
  const CheckInOutCardAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h * 0.18,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 15, left: 15),
              child: Text(
                kCheckInOutString,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: CustomColors.blackTextColor,
                ),
              ),
            ),
            kSizedBoxH10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              height: 18,
                              decoration: BoxDecoration(
                                  color: CustomColors.lightBlueColor,
                                  borderRadius: BorderRadius.circular(9)),
                            ),
                          ),
                        ),
                      ),
                      Obx(() => SliderTheme(
                            data: SliderThemeData(
                              overlayShape: SliderComponentShape.noOverlay,
                              thumbShape: const CustomRoundSliderThumbShape(
                                enabledThumbRadius: 18.0,
                              ),
                            ),
                            child: Slider(
                              value: Get.find<DashboardController>()
                                  .sliderValue
                                  .value,
                              max: 100,
                              thumbColor: CustomColors.lightBlueColor,
                              inactiveColor: CustomColors.lightBlueColor,
                              activeColor: CustomColors.whiteTextColor,
                              onChanged: (double value) {
                                Get.find<DashboardController>()
                                    .changeSliderPosition(value);
                              },
                              onChangeEnd: (double value) =>
                                  Get.find<DashboardController>()
                                      .sliderController(value),
                            ),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: RichText(
                    text: const TextSpan(
                      text: '00:00',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: CustomColors.grey80x3TextColor),
                      children: [
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
              ],
            ),
            kSizedBoxH10,
            Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 15),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Text(
                      "$kNowIsString 07:59 AM",
                      style: kTextStyleS14C255140x3.copyWith(
                        color: CustomColors.blackTextColor,
                      ),
                    ),
                    const VerticalDivider(
                      color: CustomColors.darkGreyTextColor,
                      width: 20,
                      thickness: 2.5,
                      indent: 2,
                      endIndent: 2,
                    ),
                    Text(
                      "Wednesday, 12 Sep 2022",
                      style: kTextStyleS14C255140x3.copyWith(
                        color: CustomColors.blackTextColor,
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
