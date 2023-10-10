import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/models/calendar/meeting_attendees.dart';
import 'package:paytym/screens/employee/calendar/calendar_controller.dart';
import 'package:paytym/screens/employee/calendar/widgets/custom_svg.dart';

import '../../../../../core/constants/styles.dart';
import '../../../../../network/end_points.dart';
import '../../../../widgets/custom_cached_network_image.dart';

class CalendarMeeting extends StatelessWidget {
  const CalendarMeeting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CalendarController>().getMeeting();
    });

    List<String> networkImages = [];
    return Obx(() {
      print(
          "Meeting List 1: ${Get.find<CalendarController>().meetingResponseModel.value.meetingsList?.length.toString()}");
      final meetingList = Get.find<CalendarController>()
          .meetingResponseModel
          .value
          .meetingsList
          ?.where((element) => element.meetings != null)
          .toList();
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: meetingList?.length ?? 0,
        itemBuilder: (context, index) {
          final meeting = meetingList?[index];

          final meetingAttendees = meeting?.meetings?.meetingAttendeess;
          print(
              "Meeting attendees count: ${meetingAttendees!.length.toString()}");
          return Card(
            color: CustomColors.whiteTabColor,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 12, 18, 4),
                  child: Row(
                    children: [
                      const CustomSVG(
                        IconPath.timeSvg,
                        size: 22,
                      ),
                      kSizedBoxW10,
                      Center(
                        child: Text(
                          "${Get.find<CalendarController>().timeChange(meeting?.meetings?.startTime.toString() ?? '0000-00-00 00:00:00')} - ${Get.find<CalendarController>().timeChange(meeting?.meetings?.endTime.toString() ?? '0000-00-00 00:00:00')}",
                          // "${meeting?.meetings?.startTime?.toString()} - ${meeting?.meetings?.endTime?.toString()}",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: kTextStyleS13W600CustomGrey,
                        ),
                      ),
                      kSizedBoxW10,
                      Expanded(
                        child: Text(
                          meeting?.meetings?.location ?? '',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                          style: kTextStyleS13W600CustomGrey,
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
                  padding: const EdgeInsets.fromLTRB(18, 0, 5, 8.0),
                  child: Row(
                    children: [
                      const CustomSVG(
                        IconPath.scheduleSvg,
                        size: 22,
                      ),
                      kSizedBoxW10,
                      Center(
                        child: Text(
                          // "${Get.find<CalendarController>().timeChange(meeting?.meetings?.startTime.toString() ?? '0000-00-00 00:00:00')} - ${Get.find<CalendarController>().timeChange(meeting?.meetings?.endTime.toString() ?? '0000-00-00 00:00:00')}",
                          // "${meeting?.meetings?.startTime?.toString()} - ${meeting?.meetings?.endTime?.toString()}",
                          DateFormat('dd-MM-yyyy').format(DateTime.parse(
                              meeting?.meetings?.date.toString() ??
                                  '0000-00-00')),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: kTextStyleS13W600CustomGrey,
                        ),
                      ),
                      kSizedBoxW10,
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // reportController.projectName =
                            //     projects[index].name ?? '';
                            // var project = projects[index];
                            Get.to(MeetingAttendessListPage(
                                listOfAttendees: meetingAttendees));
                          },
                          child: AvatarStack(
                            height: 30,
                            width: 30,
                            settings: RestrictedAmountPositions(
                                maxAmountItems: 3, minCoverage: 0.5),
                            infoWidgetBuilder: (surplus) {
                              return CircleAvatar(
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                    radius: 23,
                                    child: Text(
                                      '+$surplus',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )),
                              );
                            },
                            avatars: [
// Now you have a list of Image.network widgets in the networkImages list.
                              for (var n = 0; n < meetingAttendees!.length; n++)
                                NetworkImage(
                                    '$kStorageUrl${meetingAttendees[n]?.image}')
//                               for (var n = 0; n < 5; n++)
//                                 NetworkImage(
//                                     '$kStorageUrl${meeting?.meetings?.user?.image}')
                            ],
                          ),
                        ),
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
                        imageUrl:
                            '$kStorageUrl${meeting?.meetings?.user?.image}',
                        radius: 25,
                      ),
                      kSizedBoxW12,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${meeting?.meetings?.user?.firstName ?? ''} ${meeting?.meetings?.user?.lastName ?? ''}',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            kSizedBoxH4,
                            Text(
                              // "testing",
                              meeting?.meetings?.user?.role?.roleName ?? '',
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
                          meeting?.meetings?.name ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: kTextStyleS13W600CustomGrey,
                        ),
                      ),
                      // Text(
                      //   DateFormat('dd-MM-yyyy').format(DateTime.parse(
                      //       meeting?.meetings?.date.toString() ??
                      //           '0000-00-00')),
                      //   overflow: TextOverflow.ellipsis,
                      //   style: kTextStyleS13W600CustomGrey,
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          meeting?.meetings?.agenda ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: kTextStyleS13W600CustomGrey,
                        ),
                      ),
                      // Text(
                      //   DateFormat('dd-MM-yyyy').format(DateTime.parse(
                      //       meeting?.meetings?.date.toString() ??
                      //           '0000-00-00')),
                      //   overflow: TextOverflow.ellipsis,
                      //   style: kTextStyleS13W600CustomGrey,
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
