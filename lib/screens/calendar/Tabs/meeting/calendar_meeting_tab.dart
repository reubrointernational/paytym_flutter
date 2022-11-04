import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/icons.dart';

class CalendarMeeting extends StatefulWidget {
  const CalendarMeeting({Key? key}) : super(key: key);

  @override
  State<CalendarMeeting> createState() => _CalendarMeetingState();
}

class _CalendarMeetingState extends State<CalendarMeeting> {
  List<Map<String, dynamic>> calendarMeetingDetails = [
    {
      "time": "09:15 AM - 09:45 AM Room 404",
      "person": "Bessie Miles",
      "personJob": "Lead UX / UI Designer, #Studio"
    },
    {
      "time": "10:15 AM - 10:45 AM Room 78",
      "person": "Calvin Cooper",
      "personJob": "Product Designer, Apple Inc."
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: calendarMeetingDetails.length,
      itemBuilder: (context, index) {
        final meeting = calendarMeetingDetails[index];
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      IconPath.timeSvg,
                      width: 22,
                      height: 22,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      meeting["time"],
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: CustomColors.customGreyTextColor,
                      ),
                    ),
                    SvgPicture.asset(
                      IconPath.locationSvg,
                      width: 22,
                      height: 22,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: CustomColors.circleAvatarBackgroundColor,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meeting["person"],
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          meeting["personJob"],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: CustomColors.customGreyTextColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 3,
                indent: 10,
                endIndent: 10,
                // color: Color.fromRGBO(161, 161, 161, 1),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 5, 25, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          IconPath.scheduleSvg,
                          width: 22,
                          height: 22,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Reschedule",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          IconPath.talkSvg,
                          width: 22,
                          height: 22,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Let's talk",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 50,
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
    );
  }
}
