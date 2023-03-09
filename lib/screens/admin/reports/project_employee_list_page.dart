import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/styles.dart';
import 'package:paytym/screens/admin/reports/reports_controller.dart';

import '../widgets/custom_admin_scaffold.dart';

class ProjectEmployeeListPage extends StatelessWidget {
  const ProjectEmployeeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReportsControllerAdmin>();
    return CustomAdminScaffold(
        title: controller.projectName,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Obx(
            () => ListView.builder(
              itemCount: Get.find<ReportsControllerAdmin>()
                      .projectDetails
                      .value
                      .projectsListe
                      ?.length ??
                  0,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const ListTile(
                      title: Text(
                        'Akhil V S',
                        style: kTextStyleS15W600CBlack,
                      ),
                      subtitle: Text('ID: 002145'),
                      leading: CircleAvatar(
                        radius: 25,
                      ),
                      trailing: Text(
                        'Branch',
                        style: kTextStyleS13W500Cgrey,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
