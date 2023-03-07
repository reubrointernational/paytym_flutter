import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/employee/calendar/calendar_controller.dart';
import 'package:paytym/screens/employee/calendar/widgets/custom_svg.dart';

import '../../../../../core/constants/strings.dart';
import '../../../../../core/constants/styles.dart';
import '../../../../widgets/custom_cached_network_image.dart';

class CalendarMeeting extends StatelessWidget {
  const CalendarMeeting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: Get.find<CalendarController>()
                .meetingResponseModel
                .value
                .payroll
                ?.length ??
            0,
        itemBuilder: (context, index) {
          final meeting = Get.find<CalendarController>()
              .meetingResponseModel
              .value
              .payroll?[index];
          return Card(
            color: CustomColors.whiteTabColor,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 12, 18, 10),
                  child: Row(
                    children: [
                      const CustomSVG(
                        IconPath.timeSvg,
                        size: 22,
                      ),
                      kSizedBoxW10,
                      Expanded(
                        child: Center(
                          child: Text(
                            "${Get.find<CalendarController>().getTime(meeting?.startTime ?? '0000-00-00 00:00:00')} - ${Get.find<CalendarController>().getTime(meeting?.endTime ?? '0000-00-00 00:00:00')}",
                            overflow: TextOverflow.ellipsis,
                            style: kTextStyleS13W600CustomGrey,
                          ),
                        ),
                      ),
                      kSizedBoxW10,
                      const CustomSVG(
                        IconPath.locationSvg,
                        size: 22,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  child: Row(
                    children: [
                      CustomCachedNetworkImage(
                        imageUrl: meeting?.user?.image ?? '',
                        radius: 25,
                      ),
                      kSizedBoxW12,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${meeting?.user?.firstName} ${meeting?.user?.lastName}',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            kSizedBoxH4,
                            Text(
                              meeting?.user?.position ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: CustomColors.customGreyTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 5, 18, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          meeting?.location ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: kTextStyleS13W600CustomGrey,
                        ),
                      ),
                      Text(
                        DateFormat('dd-MM-yyyy').format(
                            DateTime.parse(meeting?.date ?? '0000-00-00')),
                        overflow: TextOverflow.ellipsis,
                        style: kTextStyleS13W600CustomGrey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
