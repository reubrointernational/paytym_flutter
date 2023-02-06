import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/custom_slider_thumb.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/constants/widgets.dart';

import '../dashboard_controller.dart';

class CheckInOutCard extends StatelessWidget {
  const CheckInOutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 158,
      child: Card(
        color: CustomColors.blueTextColor,
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
                  fontWeight: FontWeight.w700,
                  color: CustomColors.whiteTextColor,
                ),
              ),
              kSizedBoxH10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 15,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        /*gradient: const LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color.fromARGB(255, 28, 41, 226),
                                              Color.fromARGB(255, 14, 130, 238)
                                            ]),*/
                                        borderRadius:
                                            BorderRadius.circular(7.5)),
                                  ),
                                ),
                              ),
                              SliderTheme(
                                data: SliderThemeData(
                                  trackHeight: 0,
                                  //activeTrackColor: Colors.red,
                                  /*inactiveTrackColor:
                                      const Color.fromARGB(255, 2, 69, 124),*/
                                  overlayShape: SliderComponentShape.noOverlay,
                                  thumbShape: const CustomRoundSliderThumbShape(
                                    enabledThumbRadius: 18.0,
                                  ),
                                ),
                                child: Slider(
                                  thumbColor: CustomColors.whiteCardColor,
                                  inactiveColor: CustomColors.whiteCardColor,
                                  activeColor: CustomColors.whiteCardColor,
                                  value: Get.find<DashboardController>()
                                      .sliderValue
                                      .value,
                                  max: 100,
                                  onChanged: (double value) {
                                    Get.find<DashboardController>()
                                        .changeSliderPosition(value);
                                  },
                                  onChangeEnd: (double value) =>
                                      Get.find<DashboardController>()
                                          .sliderController(value),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  // Obx(
                  //   () => SizedBox(
                  //     height: 32,
                  //     width: 70,
                  //     child: ElevatedButton(
                  //       onPressed: () {
                  //         Get.find<DashboardController>().updateTimer();
                  //       },
                  //       style: ElevatedButton.styleFrom(
                  //         backgroundColor: CustomColors.blueCardColor,
                  //         // padding: const EdgeInsets.symmetric(
                  //         //     horizontal: 10, vertical: 20),
                  //         shape: const RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.horizontal(
                  //             right: Radius.circular(20),
                  //             left: Radius.circular(20),
                  //           ),
                  //         ),
                  //       ),
                  //       child: Text(
                  //         Get.find<DashboardController>().isTimerOn.value
                  //             ? kStopString
                  //             : kStartString,
                  //         style: const TextStyle(
                  //           fontWeight: FontWeight.w400,
                  //           fontSize: 12,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Obx(
                    () => RichText(
                      text: TextSpan(
                        text:
                            "${(Get.find<DashboardController>().seconds.value / 60).floor().toString().padLeft(2, '0')}:${Get.find<DashboardController>().seconds.value.remainder(60).toString().padLeft(2, '0')}",
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: CustomColors.whiteTextColor),
                        children: const [
                          TextSpan(
                            text: khrsString,
                            style: TextStyle(
                              fontSize: 16,
                              color: CustomColors.whiteTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              kSizedBoxH10,
              IntrinsicHeight(
                child: Row(
                  children: [
                    Obx(
                      () => Text(
                        "$kNowIsString ${Get.find<DashboardController>().time.value}",
                        style: kTextStyleS14C255140x3,
                      ),
                    ),
                    const VerticalDivider(
                      color: CustomColors.whiteTextColor,
                      width: 20,
                      thickness: 2.5,
                      indent: 2,
                      endIndent: 2,
                    ),
                    Text(
                      Get.find<DashboardController>().getDate(),
                      style: kTextStyleS14C255140x3,
                    ),
                  ],
                ),
              ),
              kSizedBoxH10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    kNextShiftString,
                    style: TextStyle(
                      color: CustomColors.whiteTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.calendar_month,
                        size: 13,
                        color: CustomColors.lightBlueColor,
                      ),
                      kSizedBoxW4,
                      Text(
                        kSep20String,
                        style: kTextStyleS14C255140x3,
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.schedule,
                        size: 13,
                        color: CustomColors.lightBlueColor,
                      ),
                      kSizedBoxW4,
                      Text(
                        k08PMString,
                        style: kTextStyleS14C255140x3,
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
