import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/strings.dart';

import '../../../../../core/constants/styles.dart';
import '../../../../../core/constants/widgets.dart';
import '../../calendar_controller.dart';

class EventRow extends StatelessWidget {
  final int index;
  const EventRow({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Text(
                Get.find<CalendarController>()
                        .eventsResponseModel
                        .value
                        .events?[index]
                        ?.startTime ??
                    '',
                style: kTextStyleS13W600CustomGrey,
              ),
              kSizedBoxH3,
              Text(
                Get.find<CalendarController>()
                        .eventsResponseModel
                        .value
                        .events?[index]
                        ?.endTime ??
                    '',
                style: kTextStyleS13W600CustomGrey,
              ),
            ],
          ),
          VerticalDivider(
            width: w * 0.15,
            thickness: 3,
            color: CustomColors.redColor,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Get.find<CalendarController>()
                          .eventsResponseModel
                          .value
                          .events?[index]
                          ?.name ??
                      '',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                kSizedBoxH3,
                Text(
                  Get.find<CalendarController>()
                          .eventsResponseModel
                          .value
                          .events?[index]
                          ?.place ??
                      '',
                  overflow: TextOverflow.ellipsis,
                  style: kTextStyleS13W600CustomGrey,
                ),
              ],
            ),
          ),

// CustomSVG(
          //   IconPath.add2Svg,
          //   size: 18,
          // ),

          // Stack(
          //   children: const [
          //     CustomSVG(IconPath.tick1Svg, size: 18),
          //     Positioned(
          //       top: 1.6,
          //       left: 4,
          //       child: CustomSVG(IconPath.tick2Svg, size: 11),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
