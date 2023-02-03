import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/employees_screens/calendar/calendar_controller.dart';
import 'package:paytym/screens/employees_screens/calendar/widgets/custom_svg.dart';

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
                            "${Get.find<CalendarController>().getTime(meeting?.startTime ?? '2022-11-23 06:26:47')} - ${Get.find<CalendarController>().getTime(meeting?.endTime ?? '2022-11-23 06:26:47')}  ${meeting?.location ?? ''}",
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
                              meeting?.user?.position ?? 'HR Manager',
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
                const Divider(
                  thickness: 3,
                  indent: 10,
                  endIndent: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 5, 25, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.edit,
                            color: CustomColors.greenColor,
                          ),
                          kSizedBoxW10,
                          Text(
                            kEditString,
                            style: kTextStyleS13W600,
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.delete_sharp,
                            color: CustomColors.redColor,
                          ),
                          kSizedBoxW10,
                          Text(
                            kDeleteString,
                            style: kTextStyleS13W600,
                          ),
                        ],
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
