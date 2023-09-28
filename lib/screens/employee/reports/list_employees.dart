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

class ListEmployeesAdmin extends StatelessWidget {
  final String title;
  const ListEmployeesAdmin({super.key, this.title = 'Add Overtime'});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Get.find<DashboardControllerAdmin>().clearFilter());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
        Get.find<DashboardControllerAdmin>().getFilteredEmployeeList());
    Get.put(ReportsControllerAdmin());

    int tempIndex = 0;
    return CustomAdminScaffold(
      title: title,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
        child: Column(
          children: [
            const AttendanceFilterBox(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Obx(() {
                  List<EmployeeList>? chatList =
                      Get.find<DashboardControllerAdmin>()
                          .getFilteredEmployeeList();

                  return ListView.builder(
                    itemCount: chatList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (title == 'Add Overtime') {
                            DialogHelper.showBottomSheet(
                                RequestOvertimeBottomsheet(
                                    employeeList: chatList?[index]));
                          } else {
                            // DialogHelper.showBottomSheet(AddAttendanceBottomsheet(
                            //     employeeList: chatList?[index]));
                          }
                        },
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
                              child: Text(chatList?[index].branch?.name ?? ''),
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
                      );
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
