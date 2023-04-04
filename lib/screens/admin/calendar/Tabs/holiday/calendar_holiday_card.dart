import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytym/screens/admin/calendar/calendar_controller.dart';

import '../../../../../core/colors/colors.dart';
import '../../../../../core/constants/strings.dart';
import '../../../../../core/constants/styles.dart';
import '../../../../../core/constants/widgets.dart';
import '../../../../../core/dialog_helper.dart';

class CalendarHolidayCardAdmin extends StatelessWidget {
  final int index;

  const CalendarHolidayCardAdmin({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 8,
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                IntrinsicHeight(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: Text(
                            DateFormat('dd-MM-yyyy').format(DateTime.parse(
                                Get.find<CalendarControllerAdmin>()
                                    .leaveAdminResponseModel
                                    .value
                                    .leaveList[index]
                                    .date)),
                            style: kTextStyleS13W600CustomGrey,
                          ),
                        ),
                        VerticalDivider(
                          width: w * 0.15,
                          thickness: 3,
                          color: CustomColors.greenColor,
                        ),
                        Text(
                          Get.find<CalendarControllerAdmin>()
                              .leaveAdminResponseModel
                              .value
                              .leaveList[index]
                              .name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector( 
                      onTap:() { 
                        DialogHelper.showConfirmDialog(
                                              title: 'Delete Holiday',
                                              desc:
                                                  'Do you want to delete this holiday?',
                                              onConfirm: () {
                                                Get.find<CalendarControllerAdmin>()
                                  .deleteHoliday(index);
                                                Get.back();
                                              });
                        
                        },
                      child: const Icon(
                        Icons.delete_outline,
                        color: CustomColors.redColor,
                      ),
                    ),
                  ],
                )),
                /*kSizedBoxH10,
                const Divider(
                  thickness: 3,
                  indent: 10,
                  endIndent: 10,
                ),
                GestureDetector(
                  onTap: () =>
                      Get.find<CalendarControllerAdmin>().deleteHoliday(index),
                  child: Row(
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
                ),*/
              ],
            ),
          ),
        ));
  }
}
