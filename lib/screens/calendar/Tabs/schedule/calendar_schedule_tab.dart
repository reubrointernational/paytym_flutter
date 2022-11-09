import 'package:flutter/material.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/calendar/widgets/custom_svg.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/constants/styles.dart';

class CalendarSchedule extends StatefulWidget {
  const CalendarSchedule({Key? key}) : super(key: key);

  @override
  State<CalendarSchedule> createState() => _CalendarScheduleState();
}

class _CalendarScheduleState extends State<CalendarSchedule> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: calendarScheduleDetails.length,
      itemBuilder: (context, index) {
        final schedule = calendarScheduleDetails[index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                k8amString,
                style: kTextStyleS13W600CustomGrey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 10),
              child: Card(
                color: CustomColors.whiteTabColor,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      schedule["scheduleOne"][0]["startTime"],
                                      style: kTextStyleS13W600CustomGrey,
                                    ),
                                    kSizedBoxH3,
                                    Text(
                                      schedule["scheduleOne"][0]["endTime"],
                                      style: kTextStyleS13W600CustomGrey,
                                    ),
                                  ],
                                ),
                                VerticalDivider(
                                  width: 60,
                                  thickness: 3,
                                  color: schedule["scheduleOne"][0]
                                      ["dividerColor"],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      schedule["scheduleOne"][0]["title"],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    kSizedBoxH3,
                                    Text(
                                      schedule["scheduleOne"][0]["place"],
                                      style: kTextStyleS13W600CustomGrey,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Stack(
                              children: const [
                                CustomSVG(IconPath.tick1Svg, size: 18),
                                Positioned(
                                  top: 1.6,
                                  left: 4,
                                  child: CustomSVG(IconPath.tick2Svg, size: 11),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                        height: 40,
                      ),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      schedule["scheduleTwo"][0]["startTime"],
                                      style: kTextStyleS13W600CustomGrey,
                                    ),
                                    kSizedBoxH3,
                                    Text(
                                      schedule["scheduleTwo"][0]["endTime"],
                                      style: kTextStyleS13W600CustomGrey,
                                    ),
                                  ],
                                ),
                                VerticalDivider(
                                  width: 60,
                                  thickness: 3,
                                  color: schedule["scheduleTwo"][0]
                                      ["dividerColor"],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      schedule["scheduleTwo"][0]["title"],
                                      style: kTextStyleS14W800,
                                    ),
                                    kSizedBoxH3,
                                    Text(
                                      schedule["scheduleTwo"][0]["place"],
                                      style: kTextStyleS13W600CustomGrey,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Stack(
                              children: const [
                                Positioned(
                                  top: 4,
                                  left: 5,
                                  child: CustomSVG(
                                    IconPath.add1Svg,
                                    size: 10,
                                  ),
                                ),
                                CustomSVG(
                                  IconPath.add2Svg,
                                  size: 18,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
