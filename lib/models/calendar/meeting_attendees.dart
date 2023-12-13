import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/styles.dart';
import 'package:paytym/screens/admin/reports/reports_controller.dart';
import '../../../network/end_points.dart';
import '../../screens/admin/widgets/custom_admin_scaffold.dart';
import '../../screens/employee/calendar/calendar_controller.dart';
import 'meeting_response_model.dart';

class MeetingAttendessListPage extends StatelessWidget {
  final List<MeetingAttendeess> listOfAttendees;
  const MeetingAttendessListPage({super.key, required this.listOfAttendees});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CalendarController>();
    var empList = listOfAttendees;
    return CustomAdminScaffold(
        title: "Meeting Attendees",
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListView.builder(
            itemCount: listOfAttendees!.length,
            itemBuilder: (BuildContext context, int index) {
              final members = listOfAttendees?[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      '${members?.firstName ?? ''} ${members?.lastName ?? ''}',
                      style: kTextStyleS15W600CBlack,
                    ),
                    // subtitle: Text('ID: ${members?.id}'),
                    subtitle: Text('${members?.jobTitle}'),
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey,
                      backgroundImage:
                          NetworkImage('$kStorageUrl${members?.image}'),
                    ),
                    trailing: Text(
                      // "Brach name",
                      'ID : ${members?.id}',
                      style: kTextStyleS13W500Cgrey,
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
