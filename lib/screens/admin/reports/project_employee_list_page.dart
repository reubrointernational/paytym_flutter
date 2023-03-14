import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/styles.dart';
import 'package:paytym/screens/admin/reports/reports_controller.dart';

import '../../../models/report/projects/projects_list_model.dart';
import '../widgets/custom_admin_scaffold.dart';

class ProjectEmployeeListPage extends StatelessWidget {
  final ProjectsList? project;
  const ProjectEmployeeListPage({super.key, this.project});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReportsControllerAdmin>();
    var team = project!.employeeproject;
    return CustomAdminScaffold(
        title: controller.projectName,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListView.builder(
            itemCount: team!.length,
            itemBuilder: (BuildContext context, int index) {
              final members = team[index];
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
                      '${members.user.firstName} ${members.user.lastName}',
                      style: kTextStyleS15W600CBlack,
                    ),
                    subtitle: Text('ID: ${members.user.id}'),
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                          'https://paytym.net/storage/${members.user.image}'),
                    ),
                    trailing: Text(
                      project!.branch!.name,
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
