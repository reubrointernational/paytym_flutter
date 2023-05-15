import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/employee/dashboard/dashboard_controller.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/widgets.dart';
import '../../../../models/dashboard/dashboard_response_model.dart';

class DashboardColoredCard extends StatelessWidget {
  final int index;
  final DashboardResponseModel? model;
  const DashboardColoredCard(
      {super.key, required this.index, required this.model});

  @override
  Widget build(BuildContext context) {
    final leaves = employeeLeaves[index];
    final total = Get.find<DashboardController>().getTotal(index);
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
                  padding: const EdgeInsets.only(right: 6),
                  child: Text(
                    total[0].toString(),
                    style: const TextStyle(
                        fontSize: 25,
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
                    radius: 20,
                    child: Icon(
                      leaves["icon"],
                      size: 25,
                      color: leaves["bgColor"],
                    ),
                  ),
                  kSizedBoxH10,
                  Text(
                    leaves["title"],
                    style: const TextStyle(
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w600,
                        color: CustomColors.whiteTextColor),
                  ),
                  kSizedBoxH4,
                  Text(
                    total[1],
                    style: TextStyle(
                        fontSize: 12,
                        letterSpacing: 0.5,
                        color: CustomColors.whiteWithOpacityTextColor),
                  ),
                ],
              ),
            ],
          ),
        ),
        Animate(
          effects: const [
            SlideEffect(
                begin: Offset(-2, 2),
                end: Offset(0, 0),
                curve: Curves.easeInOut,
                duration: Duration(seconds: 2)),
          ],
          child: const Positioned(
            right: -40,
            top: -20,
            child: CircleAvatar(
              backgroundColor: CustomColors.cardBackgroundCircleColor,
              radius: 60,
            ),
          ),
        ),
        Animate(
          effects: const [
            SlideEffect(
                begin: Offset(-2, -2),
                end: Offset(0, 0),
                curve: Curves.easeInOut,
                duration: Duration(seconds: 2)),
          ],
          child: const Positioned(
            right: -40,
            bottom: -20,
            child: CircleAvatar(
              backgroundColor: CustomColors.cardBackgroundCircleColor,
              radius: 60,
            ),
          ),
        ),
      ],
    );
  }
}
