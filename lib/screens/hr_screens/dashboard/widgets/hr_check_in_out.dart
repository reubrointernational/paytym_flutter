import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/custom_slider_thumb.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/constants/widgets.dart';

import '../dashboard_controller.dart';

class HRCheckInOutCard extends StatelessWidget {
  const HRCheckInOutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.18,
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
                  fontWeight: FontWeight.w700,
                  color: CustomColors.blackTextColor,
                ),
              ),
              kSizedBoxH10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
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
                                    color: CustomColors.lightBlueColor,
                                    /*gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromARGB(255, 28, 41, 226),
                                          Color.fromARGB(255, 14, 130, 238)
                                        ]),*/
                                    borderRadius: BorderRadius.circular(7.5)),
                              ),
                            ),
                          ),
                          SliderTheme(
                            data: const SliderThemeData(
                              thumbShape: CustomRoundSliderThumbShape(
                                enabledThumbRadius: 18.0,
                              ),
                            ),
                            child: Slider(
                                value: 10,
                                max: 100,
                                thumbColor: CustomColors.lightBlueColor,
                                inactiveColor: CustomColors.whiteTextColor,
                                activeColor: CustomColors.lightBlueColor,
                                onChanged: (double value) {},
                                onChangeEnd: (double value) {}),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                  RichText(
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
                ],
              ),
              kSizedBoxH10,
              IntrinsicHeight(
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
            ],
          ),
        ),
      ),
    );
  }
}
