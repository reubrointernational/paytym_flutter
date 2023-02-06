import 'package:flutter/material.dart';
import 'package:paytym/core/constants/styles.dart';

import '../widgets/custom_admin_scaffold.dart';

class ProjectEmployeeList extends StatelessWidget {
  const ProjectEmployeeList({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAdminScaffold(
      title: 'Project Name',
      widget: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
    );
  }
}
