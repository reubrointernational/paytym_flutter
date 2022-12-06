import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../core/constants/widgets.dart';

class DashboardColoredCard extends StatelessWidget {
  final int index;
  const DashboardColoredCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
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
                    leaves["total"].toString(),
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
                        overflow: TextOverflow.ellipsis,
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
}
