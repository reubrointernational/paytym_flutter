import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/enums.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/core/dialog_helper.dart';
import 'package:paytym/network/end_points.dart';
import 'package:paytym/screens/admin/reports/reports_controller.dart';
import 'package:paytym/screens/admin/widgets/custom_admin_scaffold.dart';
import '../../../core/constants/icons.dart';
import '../../../core/constants/strings.dart';
import '../../../core/constants/styles.dart';
import '../../../models/employee_list_model.dart';
import '../../employee/reports/widgets/year_dropdown.dart';
import '../dashboard/dashboard_controller.dart';
import 'widgets/add_attendance_bottomsheet.dart';

class AddAttendance extends StatelessWidget {
  const AddAttendance({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
        Get.find<DashboardControllerAdmin>().fetchEmployeeList());
    Get.find<ReportsControllerAdmin>().fetchBusiness();
    return WillPopScope(
      onWillPop: () async {
        Get.find<DashboardControllerAdmin>().resetTabs(SelectChatMemberTab.all);
        return true;
      },
      child: CustomAdminScaffold(
        title: 'Add Attendance',
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: [
              kSizedBoxH15,
              Obx(() {
                final dept = Get.find<ReportsControllerAdmin>()
                    .departmentModel
                    .value
                    .departments;
                final branch = Get.find<ReportsControllerAdmin>()
                    .branchModel
                    .value
                    .branches;

                final business = Get.find<ReportsControllerAdmin>()
                    .businessModel
                    .value
                    .businesses;
                return ListView(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      GestureDetector(
                        onTap: () => Get.find<DashboardControllerAdmin>()
                            .resetTabs(SelectChatMemberTab.all),
                        child: Obx(() => Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: Get.find<DashboardControllerAdmin>()
                                              .selectMemberTab
                                              .value ==
                                          SelectChatMemberTab.all
                                      ? Colors.lightBlue
                                      : Colors.white,
                                  border: Border.all(color: Colors.lightBlue),
                                  borderRadius: BorderRadius.circular(5)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              margin: const EdgeInsets.only(bottom: 15),
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
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.lightBlue),
                            borderRadius: BorderRadius.circular(5)),
                        margin: const EdgeInsets.only(bottom: 15),
                        child: CustomDropdownYearButton(
                          alignment: Alignment.centerLeft,
                          lists: business.map((e) => e.name).toList(),
                          value: Get.find<DashboardControllerAdmin>()
                              .selectedDropdownBusiness
                              .value,
                          onChanged: (value) {
                            Get.find<DashboardControllerAdmin>()
                                .selectedDropdownBusiness
                                .value = value;
                            Get.find<DashboardControllerAdmin>()
                                .resetTabs(SelectChatMemberTab.department);

                            final businessId = business
                                .firstWhere((element) => element.name == value)
                                .id;

                            Get.find<ReportsControllerAdmin>()
                                .fetchBranches(businessId);
                          },
                          hint: selectMembersTabsAttendance[0],
                        ),
                      ),
                      ...List.generate(
                        2,
                        (index) => Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.lightBlue),
                              borderRadius: BorderRadius.circular(5)),
                          margin: const EdgeInsets.only(bottom: 15),
                          child: CustomDropdownYearButton(
                            alignment: Alignment.centerLeft,
                            lists: index == 0
                                ? branch.map((e) => e.name).toList()
                                : dept.map((e) => e.depName).toList(),
                            value: index == 0
                                ? Get.find<DashboardControllerAdmin>()
                                    .selectedDropdownBranches
                                    .value
                                : Get.find<DashboardControllerAdmin>()
                                    .selectedDropdownDepartments
                                    .value,
                            onChanged: (value) {
                              index == 0
                                  ? Get.find<DashboardControllerAdmin>()
                                      .selectedDropdownBranches
                                      .value = value
                                  : Get.find<DashboardControllerAdmin>()
                                      .selectedDropdownDepartments
                                      .value = value;
                              Get.find<DashboardControllerAdmin>().resetTabs(
                                  index == 0
                                      ? SelectChatMemberTab.branch
                                      : SelectChatMemberTab.department);

                              if (index == 0) {
                                final branchId = branch
                                    .firstWhere(
                                        (element) => element.name == value)
                                    .id;
                                Get.find<ReportsControllerAdmin>()
                                    .fetchDepartments(branchId);
                              }
                            },
                            hint: selectMembersTabsAttendance[index + 1],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          onChanged: (value) =>
                              Get.find<DashboardControllerAdmin>()
                                  .searchKeyword
                                  .value = value,
                          initialValue: Get.find<DashboardControllerAdmin>()
                              .searchKeyword
                              .value,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Search',
                            suffixIcon: Image.asset(
                              IconPath.searchIconPng,
                              height: 20,
                              width: 20,
                              color: Colors.grey,
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide:
                                    BorderSide(width: 1.2, color: Colors.blue)),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide:
                                    BorderSide(width: 1.2, color: Colors.blue)),
                          ),
                        ),
                      ),
                    ]);
              }),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Obx(() {
                    List<EmployeeList>? chatList =
                        Get.find<DashboardControllerAdmin>().getEmployees();
                    chatList = chatList
                        ?.where((element) =>
                            ('${element.firstName?.toLowerCase()} ${element.firstName?.toLowerCase()}'
                                .contains(Get.find<DashboardControllerAdmin>()
                                    .searchKeyword
                                    .value
                                    .toLowerCase())))
                        .toList();
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: chatList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => DialogHelper.showBottomSheet(
                              const AddAttendanceBottomSheet()),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.2, color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              title: Text(
                                '${chatList?[index].firstName ?? ''} ${chatList?[index].lastName ?? ''}',
                                style: kTextStyleS18W600CBlack,
                              ),
                              subtitle: Text(
                                  '#${chatList?[index].id.toString().padLeft(5, '0')}'),
                              leading: CircleAvatar(
                                radius: 28,
                                backgroundImage: NetworkImage(
                                    '$kStorageUrl${chatList?[index].image ?? ''}'),
                              ),
                              trailing: Text(
                                chatList?[index].branch?.name ?? '',
                                style: kTextStyleS13W500Cgrey,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
