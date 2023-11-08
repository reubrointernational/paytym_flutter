import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/styles.dart';
import 'package:paytym/screens/admin/reports/reports_controller.dart';

import '../../../models/report/projects/projects_list_model.dart';
import '../../../network/end_points.dart';
import '../widgets/custom_admin_scaffold.dart';

class ProjectEmployeeListPage extends StatelessWidget {
  final ProjectsList? project;
  const ProjectEmployeeListPage({super.key, this.project});

  @override
  Widget build(BuildContext context) {
    print("ProjectEmployeeListPage called");
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
                  child: members != null
                      ? ListTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${members.user?.firstName ?? ''} ${members.user?.lastName ?? ''}',
                                style: kTextStyleS15W600CBlack,
                              ),
                              Text(
                                members!.user!.id.toString() ?? " ",
                                style: kTextStyleS13W500Cgrey,
                              ),
                            ],
                          ),

                          // subtitle: Column(
                          //   children: [
                          //     Text(
                          //       // "test",
                          //       members!.user!.branch!.name ?? " ",
                          //       style: kTextStyleS13W500Cgrey,
                          //     ),
                          //   ],
                          // ),
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(
                                '$kStorageUrlForProfileImage${members.user?.image}'),
                          ),
                          // Text('ID: ${members.user?.id ?? ''}')
                          trailing: members.user != null
                              ? Text(
                                  // "test",
                                  members!.user!.branch!.name ?? " ",
                                  style: kTextStyleS13W500Cgrey,
                                )
                              // : Text("Anonymous branch  "),
                              : Text("  "),
                          // Trailing original
                          //       trailing: project!.branch != null
                          //           ? Text(
                          //               // "test",
                          //               project!.branch!.name ?? " ",
                          //               style: kTextStyleS13W500Cgrey,
                          //             )
                          //           : Text("Anonymous branch  "),
                        )
                      : Text("Anonymous Member "),
                ),
              );
            },
          ),
        ));
  }
}
