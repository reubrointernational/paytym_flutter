import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/network/end_points.dart';
import 'package:paytym/screens/admin/dashboard/dashboard_controller.dart';
import 'package:paytym/screens/admin/widgets/custom_admin_scaffold.dart';
import '../../../../core/constants/styles.dart';
import '../../../../models/employee_list_model.dart';
import '../../../core/dialog_helper.dart';
import '../../admin/reports/add_attendance.dart';
import '../../admin/reports/reports_controller.dart';
import '../dashboard/widgets/request_overtime_bottomsheet.dart';

class ListOverTimeRequests extends StatelessWidget {
  final String title;
  const ListOverTimeRequests({super.key, this.title = 'Add Overtime'});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Get.find<DashboardControllerAdmin>().clearFilter());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
        Get.find<DashboardControllerAdmin>().getFilteredEmployeeList());
    Get.put(ReportsControllerAdmin());
    Get.put(DashboardControllerAdmin());
    Get.find<ReportsControllerAdmin>().fetchBusiness();
    int tempIndex = 0;
    return CustomAdminScaffold(
      title: title,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
        child: Column(
          children: [
            // const AttendanceFilterBox(),
            const OvertimeFilterBox(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Obx(() {
                  // List<EmployeeList>? chatList =
                  //     Get.find<DashboardControllerAdmin>()
                  //         .getFilteredEmployeeList();

                  List<EmployeeList>? chatList =
                      Get.find<DashboardControllerAdmin>()
                          .getOverTimeEmployeeList();
                  print("OT emplist 1 length: ${chatList?.length.toString()}");

                  if (Get.find<DashboardControllerAdmin>()
                          .selectedDropdownBusiness
                          .value !=
                      null) {
                    final businessId = Get.find<ReportsControllerAdmin>()
                        .businessModel
                        .value
                        .businesses
                        .firstWhere((element) =>
                            element.name ==
                            Get.find<DashboardControllerAdmin>()
                                .selectedDropdownBusiness
                                .value)
                        .id;
                    chatList = chatList
                        ?.where((element) => element.businessId == businessId)
                        .toList();
                    print("OT emplist 2  length:${chatList!.length}");
                  }

                  if (Get.find<DashboardControllerAdmin>()
                          .selectedDropdownBranches
                          .value !=
                      null) {
                    final branchId = Get.find<ReportsControllerAdmin>()
                        .branchModel
                        .value
                        .branches
                        .firstWhere((element) =>
                            element.name ==
                            Get.find<DashboardControllerAdmin>()
                                .selectedDropdownBranches
                                .value)
                        .id;
                    chatList = chatList
                        ?.where((element) => element.branchId == branchId)
                        .toList();
                    print("OT emplist 3  length:${chatList!.length}");
                  }
                  if (Get.find<DashboardControllerAdmin>()
                          .selectedDropdownDepartments
                          .value !=
                      null) {
                    final deptId = Get.find<ReportsControllerAdmin>()
                        .departmentModel
                        .value
                        .departments
                        .firstWhere((element) =>
                            element.depName ==
                            Get.find<DashboardControllerAdmin>()
                                .selectedDropdownDepartments
                                .value)
                        .id;
                    chatList = chatList
                        ?.where((element) => element.departmentId == deptId)
                        .toList();
                    print("OT emplist 4 length:${chatList!.length}");
                  }

                  chatList = chatList
                      ?.where((element) =>
                          ('${element.firstName?.toLowerCase()} ${element.firstName?.toLowerCase()}'
                              .contains(Get.find<DashboardControllerAdmin>()
                                  .searchKeyword
                                  .value
                                  .toLowerCase())))
                      .toList();
                  print("OT emplist 5 length:${chatList!.length}");

                  print(
                      "OT Emplist length 6:${Get.find<ReportsControllerAdmin>().employeeList.value.employeeList!.length}");

                  return chatList.isNotEmpty
                      ? ListView.builder(
                          itemCount: chatList?.length ?? 0,
                          itemBuilder: (context, index) {
                            return InkWell(
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
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                        chatList?[index].branch?.name ?? ''),
                                  ),
                                  // '#${chatList?[index].id.toString().padLeft(5, '0')}'),
                                  leading: CircleAvatar(
                                    radius: 28,
                                    backgroundImage: NetworkImage(
                                        '$kStorageUrl${chatList?[index].image ?? ''}'),
                                  ),
                                  trailing: Text(
                                    '#${chatList?[index].id.toString().padLeft(5, '0')}',
                                    style: kTextStyleS13W500Cgrey,
                                  ),
                                ),
                              ),
                              onTap: () {
                                // print("Testing....");
                                if (title == 'Add Overtime') {
                                  DialogHelper.showBottomSheet(
                                      RequestOvertimeBottomsheet(
                                          employeeList: chatList?[index]));
                                } else {
                                  // DialogHelper.showBottomSheet(AddAttendanceBottomsheet(
                                  //     employeeList: chatList?[index]));
                                }
                              },
                            );
                          },
                        )
                      : Text(
                          'No Employee under this selection',
                          style: TextStyle(
                              color: Colors.blue.shade800,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
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
