import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/enums.dart';
import 'package:paytym/screens/admin/reports/widgets/rounded_icons.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/constants/widgets.dart';
import '../../../employee/reports/widgets/year_dropdown.dart';
import '../reports_controller.dart';

class AttendanceTabAdmin extends StatelessWidget {
  const AttendanceTabAdmin({Key? key}) : super(key: key);

  static List<Map<String, dynamic>> totalAttendance = [
    {
      'count': 150,
      'title': 'Present',
      'color': Colors.purple,
    },
    {
      'count': 50,
      'title': 'Late',
      'color': Colors.orange,
    },
    {
      'count': 80,
      'title': 'Absent',
      'color': Colors.pink,
    },
    {
      'count': 280,
      'title': 'Total',
      'color': Colors.indigo,
    },
  ];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Get.find<ReportsControllerAdmin>().getAttendance());
    return Column(
      children: [
        SizedBox(
          height: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today',
                    style: TextStyle(
                        color: Colors.blue.shade800,
                        fontWeight: FontWeight.w500),
                  ),
                  Obx(() {
                    return CustomDropdownYearButton(
                      lists: daysDummyList,
                      value: Get.find<ReportsControllerAdmin>()
                          .selectedDropdownDay
                          .value,
                      onChanged: (value) {
                        Get.find<ReportsControllerAdmin>()
                            .selectedDropdownDay
                            .value = value!;
                      },
                      hint: '08-02-2023',
                    );
                  }),
                ],
              ),
              kSizedBoxH2,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  4,
                  (index) => Column(
                    children: [
                      Text(
                        totalAttendance[index]['count'].toString(),
                        style: TextStyle(
                            color: totalAttendance[index]['color'],
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        totalAttendance[index]['title'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Obx(
            () {
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: Get.find<ReportsControllerAdmin>()
                    .attendanceResponseModel
                    .value
                    .history
                    .length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AttendanceCardColumn(
                          index: index,
                        ),
                        Expanded(
                          child: AttendanceCardColumn(
                            isRightTab: true,
                            index: index,
                          ),
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.find<ReportsControllerAdmin>()
                                    .selectedItemIndex = index;
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
                                // Get.find<ReportsControllerAdmin>()
                                //     .selectedItemIndex = index;
                                // Get.find<ReportsControllerAdmin>()
                                //     .showBottomSheetForReason(ReasonButton.attendanceApprove);
                              },
                              icon: RoundedIcon(
                                iconPath: Icons.edit_outlined,
                                iconColor: Colors.blue,
                                circleColor: Colors.blue.shade100,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Get.find<ReportsControllerAdmin>()
                                    .selectedItemIndex = index;
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
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 10,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class AttendanceCardColumn extends StatelessWidget {
  final bool isRightTab;
  final int index;
  const AttendanceCardColumn({
    Key? key,
    this.isRightTab = false,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            !isRightTab
                ? 'Branch'
                : Get.find<ReportsControllerAdmin>()
                        .attendanceResponseModel
                        .value
                        .history[index]
                        .user
                        !.company ??
                    '',
            style:
                isRightTab ? kTextStyleS15W600CBlack : kTextStyleS15W600CGrey,
            overflow: TextOverflow.ellipsis,
          ),
          kSizedBoxH4,
          Text(
            !isRightTab
                ? 'Name'
                : '${Get.find<ReportsControllerAdmin>().attendanceResponseModel.value.history[index].user!.firstName} ${Get.find<ReportsControllerAdmin>().attendanceResponseModel.value.history[index].user!.lastName}',
            style:
                isRightTab ? kTextStyleS15W600CBlack : kTextStyleS15W600CGrey,
          ),
          kSizedBoxH4,
          Text(
            !isRightTab
                ? 'Employee ID'
                : Get.find<ReportsControllerAdmin>()
                    .attendanceResponseModel
                    .value
                    .history[index]
                    .user
                    !.employerId
                    .toString(),
            style:
                isRightTab ? kTextStyleS15W600CBlack : kTextStyleS15W600CGrey,
          ),
          kSizedBoxH20,
          Text(
            !isRightTab ? 'Check-in' : 'Check-out',
            style: kTextStyleS15W600CBlack,
          ),
          kSizedBoxH4,
          Text(
            !isRightTab
                ? Get.find<ReportsControllerAdmin>().getTime(
                    Get.find<ReportsControllerAdmin>()
                        .attendanceResponseModel
                        .value
                        .history[index]
                        .checkIn)
                : Get.find<ReportsControllerAdmin>().getTime(
                    Get.find<ReportsControllerAdmin>()
                        .attendanceResponseModel
                        .value
                        .history[index]
                        .checkOut),
            style: kTextStyleS15W600CBlack.copyWith(
                color: !isRightTab ? Colors.green : Colors.red),
          ),
        ],
      ),
    );
  }
}
