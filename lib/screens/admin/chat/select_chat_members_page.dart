import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/enums.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/routes/app_routes.dart';
import 'package:paytym/screens/admin/widgets/custom_admin_scaffold.dart';
import '../../../core/constants/strings.dart';
import '../../../core/constants/styles.dart';
import '../../employee/reports/widgets/year_dropdown.dart';
import '../dashboard/dashboard_controller.dart';

class SelectChatMembersPage extends StatelessWidget {
  const SelectChatMembersPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
        Get.find<DashboardControllerAdmin>().fetchEmployeeList());
    return CustomAdminScaffold(
      title: 'Select Members',
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Get.find<DashboardControllerAdmin>().isSelectMembersPageFromChat
                ? Get.toNamed(Routes.createGroupPage)
                : Get.back(),
        child: Icon(
            Get.find<DashboardControllerAdmin>().isSelectMembersPageFromChat
                ? Icons.arrow_forward
                : Icons.done),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            kSizedBoxH15,
            SizedBox(
                height: 40,
                child: Obx(() {
                  final dept = Get.find<DashboardControllerAdmin>()
                      .deptwiseEmployeeMap
                      .keys
                      .toList();
                  final branch = Get.find<DashboardControllerAdmin>()
                      .branchwiseEmployeeMap
                      .keys
                      .toList();
                  return ListView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: () => Get.find<DashboardControllerAdmin>()
                              .resetTabs(SelectChatMemberTab.all),
                          child: Obx(() => Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Get.find<DashboardControllerAdmin>()
                                                .selectMemberTab
                                                .value ==
                                            SelectChatMemberTab.all
                                        ? Colors.lightBlue
                                        : Colors.white,
                                    border: Border.all(color: Colors.lightBlue),
                                    borderRadius: BorderRadius.circular(25)),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                margin: const EdgeInsets.only(right: 10),
                                child: Text(
                                  'All',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Get.find<DashboardControllerAdmin>()
                                                .selectMemberTab
                                                .value ==
                                            SelectChatMemberTab.all
                                        ? Colors.white
                                        : Colors.black54,
                                  ),
                                ),
                              )),
                        ),
                        ...List.generate(
                          2,
                          (index) => Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.lightBlue),
                                borderRadius: BorderRadius.circular(25)),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            margin: const EdgeInsets.only(right: 10),
                            child: CustomDropdownYearButton(
                              lists: index == 0 ? dept : branch,
                              value: index == 0
                                  ? Get.find<DashboardControllerAdmin>()
                                      .selectedDropdownDepartments
                                      .value
                                  : Get.find<DashboardControllerAdmin>()
                                      .selectedDropdownBranches
                                      .value,
                              onChanged: (value) {
                                index == 0
                                    ? Get.find<DashboardControllerAdmin>()
                                        .selectedDropdownDepartments
                                        .value = value
                                    : Get.find<DashboardControllerAdmin>()
                                        .selectedDropdownBranches
                                        .value = value;
                                Get.find<DashboardControllerAdmin>().resetTabs(
                                    index == 0
                                        ? SelectChatMemberTab.department
                                        : SelectChatMemberTab.branch);
                              },
                              hint: selectMembersTabs[index],
                            ),
                          ),
                        ),
                      ]);
                })),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Obx(() {
                var chatList = Get.find<DashboardControllerAdmin>()
                    .getEmployees()
                    .where((element) => Get.find<DashboardControllerAdmin>()
                        .selectedItemList
                        .contains(Get.find<DashboardControllerAdmin>()
                            .employeeList
                            .value
                            .employeeList
                            .indexOf(element)))
                    .toList();
                return SizedBox(
                    height: chatList.isEmpty ? 0 : 60,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: chatList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundImage:
                                    NetworkImage(chatList[index].image ?? ''),
                              ),
                              Positioned(
                                bottom: 5,
                                right: 0,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.red,
                                  child: InkWell(
                                    onTap: () {
                                      Get.find<DashboardControllerAdmin>()
                                          .selectedItemList
                                          .remove(index);
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ));
              }),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Obx(() {
                  final chatList =
                      Get.find<DashboardControllerAdmin>().getEmployees();
                  return ListView.builder(
                    itemCount: chatList.length,
                    itemBuilder: (context, index) {
                      return Obx(() => InkWell(
                            onTap: () => Get.find<DashboardControllerAdmin>()
                                    .selectedItemList
                                    .contains(index)
                                ? Get.find<DashboardControllerAdmin>()
                                    .selectedItemList
                                    .remove(index)
                                : Get.find<DashboardControllerAdmin>()
                                    .selectedItemList
                                    .add(index),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.2, color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                title: Text(
                                  '${chatList[index].firstName} ${chatList[index].lastName}',
                                  style: kTextStyleS18W600CBlack,
                                ),
                                subtitle: Text(
                                    '#${chatList[index].id.toString().padLeft(5, '0')}'),
                                leading: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 28,
                                      backgroundImage: NetworkImage(
                                          chatList[index].image ?? ''),
                                    ),
                                    Positioned(
                                      bottom: 2,
                                      right: 0,
                                      child: Visibility(
                                        visible:
                                            Get.find<DashboardControllerAdmin>()
                                                .selectedItemList
                                                .contains(index),
                                        child: const CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.green,
                                          child: Icon(
                                            Icons.done,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Text(
                                  //todo change with branch name
                                  chatList[index].branchId.toString(),
                                  style: kTextStyleS13W500Cgrey,
                                ),
                              ),
                            ),
                          ));
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
