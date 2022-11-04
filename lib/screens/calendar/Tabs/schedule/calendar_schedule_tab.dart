import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/icons.dart';

class CalendarSchedule extends StatefulWidget {
  const CalendarSchedule({Key? key}) : super(key: key);

  @override
  State<CalendarSchedule> createState() => _CalendarScheduleState();
}

class _CalendarScheduleState extends State<CalendarSchedule> {
  List<Map<String, dynamic>> calendarScheduleDetails = [
    {
      "scheduleOne": [
        {
          "title": "Registration",
          "place": "Entrance Hall",
          "startTime": "09:15 AM",
          "endTime": "09:45 AM",
          "dividerColor": Colors.blue,
        }
      ],
      "scheduleTwo": [
        {
          "title": "Coffee Break",
          "place": "Entrance Hall",
          "startTime": "10:00 AM",
          "endTime": "10:15 AM",
          "dividerColor": Colors.orange,
        }
      ],
    },
    {
      "scheduleOne": [
        {
          "title": "Design thinking",
          "place": "Entrance Hall",
          "startTime": "10:15 AM",
          "endTime": "10:45 AM",
          "dividerColor": Colors.purple,
        }
      ],
      "scheduleTwo": [
        {
          "title": "User flow as a tool",
          "place": "Entrance Hall",
          "startTime": "11:45 AM",
          "endTime": "01:00 PM",
          "dividerColor": Colors.green,
        }
      ],
    },
  ];
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
                "08:00 AM",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: CustomColors.customGreyTextColor,
                ),
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
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: CustomColors.customGreyTextColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      schedule["scheduleOne"][0]["endTime"],
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: CustomColors.customGreyTextColor,
                                      ),
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
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      schedule["scheduleOne"][0]["place"],
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: CustomColors.customGreyTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                SvgPicture.asset(
                                  IconPath.tick1Svg,
                                  width: 18,
                                  height: 18,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: 1.6,
                                  left: 4,
                                  child: SvgPicture.asset(
                                    IconPath.tick2Svg,
                                    width: 11,
                                    height: 11,
                                    fit: BoxFit.cover,
                                  ),
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
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: CustomColors.customGreyTextColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      schedule["scheduleTwo"][0]["endTime"],
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: CustomColors.customGreyTextColor,
                                      ),
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
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      schedule["scheduleTwo"][0]["place"],
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: CustomColors.customGreyTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                Positioned(
                                  top: 4,
                                  left: 5,
                                  child: SvgPicture.asset(
                                    IconPath.add1Svg,
                                    width: 10,
                                    height: 10,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SvgPicture.asset(
                                  IconPath.add2Svg,
                                  width: 18,
                                  height: 18,
                                  fit: BoxFit.cover,
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
