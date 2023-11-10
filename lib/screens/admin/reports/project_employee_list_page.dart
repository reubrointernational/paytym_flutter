import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/styles.dart';
import 'package:paytym/screens/admin/reports/reports_controller.dart';

import '../../../core/constants/widgets.dart';
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

                      //     '${members.user?.firstName ?? ''} ${members.user?.lastName ?? ''}',
                      //       members!.user!.id.toString() ?? " ",
                      // members!.user!.branch!.name ?? " ",
                      //     backgroundImage: NetworkImage(
                      // '$kStorageUrlForProfileImage${members.user?.image}'),

                      ? ListTile(
                          title: Text(
                            '${members.user?.firstName ?? ''} ${members.user?.lastName ?? ''}',
                            style: kTextStyleS18W600CBlack,
                          ),

                          subtitle:
                              // Text('#${chatList?[index].id.toString().padLeft(5, '0')}'),
                              Text('#${members!.user!.branch!.name ?? " "}'),
                          // chatList?[index].branch?.name ?? '',
                          leading: CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(
                                '$kStorageUrlForProfileImage${members.user?.image}'),
                          ),
                          trailing: Text(
                            members.user?.id.toString().padLeft(5, '0') ?? " ",
                            style: kTextStyleS13W500Cgrey,
                          ),
                        )
                      : Text("Anonymous Member "),
                ),
              );
            },
          ),
        ));
  }
}
