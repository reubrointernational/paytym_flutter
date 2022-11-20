import 'package:flutter/material.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/calendar/widgets/custom_svg.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/constants/styles.dart';

class CalendarMeeting extends StatelessWidget {
  const CalendarMeeting({Key? key}) : super(key: key);

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
                  children: [
                    const CustomSVG(
                      IconPath.timeSvg,
                      size: 22,
                    ),
                    kSizedBoxW10,
                    Expanded(
                      child: Center(
                        child: Text(
                          meeting["time"],
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
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: CustomColors.circleAvatarBackgroundColor,
                    ),
                    kSizedBoxW12,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            meeting["person"],
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          kSizedBoxH4,
                          Text(
                            meeting["personJob"],
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
                        CustomSVG(
                          IconPath.scheduleSvg,
                          size: 22,
                        ),
                        kSizedBoxW10,
                        Text(
                          kRescheduleString,
                          style: kTextStyleS13W600,
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        CustomSVG(
                          IconPath.talkSvg,
                          size: 22,
                        ),
                        kSizedBoxW10,
                        Text(
                          "Let's talk",
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
    );
  }
}
