import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/enums.dart';
import 'package:paytym/screens/admin/leaves/leaves_controller.dart';
import 'package:paytym/screens/admin/reports/widgets/rounded_icons.dart';
import 'package:paytym/screens/admin/widgets/custom_admin_scaffold.dart';

import '../../../models/report/attendance/attendance_admin_response_model.dart';
import 'reports_controller.dart';
import 'tabs/attendance_tab.dart';

class PendingAttendanceScreen extends StatelessWidget {
  const PendingAttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LeavesControllerAdmin());
    return CustomAdminScaffold(
      title: 'Pending Attendance',
      child: Obx(
        () {
          List<History>? attendanceList = Get.find<ReportsControllerAdmin>()
              .attendanceResponseModel
              .value
              .pending;
          attendanceList = attendanceList
              ?.where((element) => element.approveReject == null)
              .toList();

          if (attendanceList!.isEmpty) {
            print("No pending attendance");
            return Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'No Pending Items ',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Column(
                      children: [],
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: attendanceList?.length ?? 0,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /*AttendanceCardColumn(
                              index: index,
                            ),*/
                      Expanded(
                        child: attendanceList!.isNotEmpty
                            ? AttendanceCardColumn(
                                attendanceElement: attendanceList![index],
                              )
                            : Text("No Pending Attendance 2"),
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.find<ReportsControllerAdmin>().selectedItem =
                                  attendanceList![index];

                              Get.find<ReportsControllerAdmin>()
                                  .approveOrDeclineAttendance(
                                      ReasonButton.attendanceApprove);
                            },
                            icon: RoundedIcon(
                              iconPath: Icons.done,
                              circleColor: Colors.green.shade100,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Get.find<ReportsControllerAdmin>().selectedItem =
                                  attendanceList![index];
                              Get.find<ReportsControllerAdmin>()
                                  .showBottomSheetForReason(
                                      ReasonButton.attendanceEdit);
                            },
                            icon: RoundedIcon(
                              iconPath: Icons.edit_outlined,
                              iconColor: Colors.blue,
                              circleColor: Colors.blue.shade100,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Get.find<ReportsControllerAdmin>().selectedItem =
                                  attendanceList![index];
                              Get.find<ReportsControllerAdmin>()
                                  .showBottomSheetForReason(
                                      ReasonButton.attendanceDecline);
                            },
                            icon: RoundedIcon(
                              iconPath: Icons.close,
                              iconColor: Colors.red,
                              circleColor: Colors.red.shade100,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
