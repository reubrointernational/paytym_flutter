import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/core/dialog_helper.dart';
import 'package:paytym/screens/admin/calendar/calendar_controller.dart';
import 'package:paytym/screens/login/login_controller.dart';

import '../../../../../core/constants/styles.dart';
import '../../../../../models/calendar/meeting_attendees.dart';
import '../../../../../models/calendar/meeting_list_admin_model_new.dart';
import '../../../../../network/end_points.dart';

class CalendarMeetingAdmin extends StatelessWidget {
  const CalendarMeetingAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<CalendarControllerAdmin>().getMeeting();
    });
    print(
        "Meeting List 1: ${Get.find<CalendarControllerAdmin>().meetingResponseModel.value.meetingsListe?.length.toString()}");

    return Obx(
      () => ListView.separated(
        physics: const BouncingScrollPhysics(),
        reverse: true,
        itemCount: Get.find<CalendarControllerAdmin>()
                .meetingResponseModel
                .value
                .meetingsListe
                ?.length ??
            0,
        itemBuilder: (context, index) {
          final meeting = Get.find<CalendarControllerAdmin>()
              .meetingResponseModel
              .value
              .meetingsListe?[index];
          List<MeetingAttendeess>? meetingAttendees =
              meeting?.meetingAttendeess;
          print(
              "Meeting attendees count: ${meetingAttendees!.length.toString()}");
          return SizedBox(
            height: 170,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 50,
                  child: Column(
                    children: [
                      kSizedBoxH10,
                      // 2023-10-11 Date format in API,We need to format it
                      Text("From-To Date"),
                      // Text(
                      //
                      //   DateFormat('EEE').format(meeting?.date!.isEmpty
                      //       ? meeting?.date
                      //       : DateTime(0000, 00, 00)),
                      //   style: kTextStyleS18W600.copyWith(
                      //       color: CustomColors.grey156x3TextColor),
                      // ),
                      //
                      //             int day = int.parse(dateParts[0]);
                      //       int month = int.parse(dateParts[1]);
                      //     int year = int.parse(dateParts[2]);
                      //
                      // // Create a DateTime object
                      // DateTime dateTime = DateTime(year, month, day);
                      //
                      // // Format the DateTime object to the desired format
                      // String formattedDate = DateFormat('EEE d').format(dateTime);

                      // Text(
                      //   meeting?.date?.toString() ?? '',
                      //   style: kTextStyleS18W600.copyWith(
                      //       color: CustomColors.lightBlueColor),
                      // ),
                    ],
                  ),
                ),
                kSizedBoxW10,
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  meeting?.name ?? '',
                                  style: kTextStyleS18W600.copyWith(
                                      color: CustomColors.blackTextColor),
                                ),
                                kSizedBoxH4,
                                Text(
                                  meeting?.agenda ?? '',
                                  style: kTextStyleS18W600.copyWith(
                                      color: Colors.grey),
                                ),
                                Text(
                                  '${meeting?.user?.firstName ?? ''} ${meeting?.user?.lastName ?? ''}',
                                  style: kTextStyleS14W600Cgrey300LS0p2
                                      .copyWith(color: Colors.grey),
                                ),
                                kSizedBoxH6,
                                // Text(
                                //   meeting?.user?.position?.roleName ?? '',
                                //   style: kTextStyleS14W600Cgrey300LS0p2
                                //       .copyWith(color: Colors.grey),
                                // ),
                                // const Spacer(),
                                kSizedBoxH6,
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          // reportController.projectName =
                                          //     projects[index].name ?? '';
                                          // var project = projects[index];
                                          // Get.to(MeetingAttendessListPage(
                                          //     listOfAttendees:
                                          //         meetingAttendees));
                                        },
                                        child: AvatarStack(
                                          height: 30,
                                          width: 30,
                                          settings: RestrictedAmountPositions(
                                              maxAmountItems: 3,
                                              minCoverage: 0.5),
                                          infoWidgetBuilder: (surplus) {
                                            return CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: CircleAvatar(
                                                  radius: 23,
                                                  child: Text(
                                                    '+$surplus',
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            );
                                          },
                                          avatars: [
// Now you have a list of Image.network widgets in the networkImages list.
                                            for (var n = 0;
                                                n < meetingAttendees!.length;
                                                n++)
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
                                kSizedBoxH6,
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.schedule,
                                      size: 15,
                                      color: Colors.grey,
                                    ),

                                    kSizedBoxW4,
                                    //Commented below text for testing 1sep2023
                                    // Text(
                                    //   '${DateFormat.jm().format(meeting?.startTime ?? DateTime(0000, 00, 00))} - ${DateFormat.jm().format(meeting?.endTime ?? DateTime(0000, 00, 00))}',
                                    //   style: kTextStyleS14W600Cgrey300LS0p2
                                    //       .copyWith(color: Colors.grey),
                                    // ),

                                    Text(
                                      '${meeting?.startTime} - ${meeting?.endTime}',
                                      style: kTextStyleS14W600Cgrey300LS0p2
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                kSizedBoxH6,
                                Text(
                                  meeting?.location ?? '',
                                  style: kTextStyleS14W600Cgrey300LS0p2
                                      .copyWith(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Center(
                              child: IconButton(
                                  onPressed: meeting?.userId ==
                                          Get.find<LoginController>()
                                              .loginResponseModel!
                                              .employee!
                                              .id
                                      ? () {
                                          DialogHelper.showConfirmDialog(
                                              title: 'Delete Meeting',
                                              desc:
                                                  'Do you want to delete this meeting?',
                                              onConfirm: () {
                                                Get.find<
                                                        CalendarControllerAdmin>()
                                                    .deleteMeeting(index);
                                                Get.back();
                                              });
                                        }
                                      : null,
                                  icon: Icon(
                                    Icons.delete_outline_outlined,
                                    color: meeting?.userId ==
                                            Get.find<LoginController>()
                                                .loginResponseModel!
                                                .employee!
                                                .id
                                        ? CustomColors.redColor
                                        : CustomColors.greyTextColor,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => kSizedBoxH10,
      ),
    );
  }
}
