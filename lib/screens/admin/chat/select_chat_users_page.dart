import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/routes/app_routes.dart';
import 'package:paytym/screens/admin/widgets/custom_admin_scaffold.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../core/constants/styles.dart';
import '../../../core/constants/widgets.dart';

class SelectChatUsersPage extends StatelessWidget {
  const SelectChatUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAdminScaffold(
      title: 'Select Members',
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.createGroupPage),
        child: const Icon(Icons.arrow_forward),
      ),
      widget: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: SizedBox(
                height: 60,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Stack(
                        children: const [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.black,
                          ),
                          Positioned(
                            bottom: 5,
                            right: 0,
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.red,
                              child: Icon(
                                Icons.close,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 1.2, color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: const Text(
                          'John Smith',
                          style: kTextStyleS18W600CBlack,
                        ),
                        subtitle: const Text('ID: 002145'),
                        leading: Stack(
                          children: const [
                            CircleAvatar(
                                radius: 28, backgroundColor: Colors.black),
                            Positioned(
                              bottom: 2,
                              right: 0,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.green,
                                child: Icon(
                                  Icons.done,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        trailing: const Text(
                          'Branch',
                          style: kTextStyleS13W500Cgrey,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
