import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/admin/calendar/calendar_controller.dart';

import '../../../../../core/colors/colors.dart';
import '../../../../../core/constants/strings.dart';
import '../../../../../core/constants/styles.dart';
import '../../../../../core/constants/widgets.dart';
import '../../../../../core/dialog_helper.dart';
import 'event_row.dart';

class CalendarEventCardAdmin extends StatelessWidget {
  final int index;
  const CalendarEventCardAdmin({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            EventRow(
              index: index,
            ),
            kSizedBoxH15,
            const Divider(
              thickness: 3,
              indent: 10,
              endIndent: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 5, 25, 0),
              child: GestureDetector(
                onTap: () {
                  DialogHelper.showConfirmDialog(
                      title: 'Delete Event',
                      desc: 'Do you want to delete this event?',
                      onConfirm: () {
                        Get.find<CalendarControllerAdmin>().deleteEvent(index);
                        Get.back();
                      });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
