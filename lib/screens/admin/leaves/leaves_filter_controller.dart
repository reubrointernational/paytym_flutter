import 'package:get/get.dart';
import 'package:paytym/screens/admin/leaves/leaves_controller.dart';

import '../../../models/leaves/leaves_admin_response_model.dart';
import '../dashboard/dashboard_controller.dart';

class LeavesFilterController {
  List<LeaveRequest>? getFilteredLeavesList([int allLeaves = 0]) {
    List<LeaveRequest>? leavesList;
    LeavesListAdminModel model = allLeaves == 3
        ? Get.find<LeavesControllerAdmin>().leaveAdminResponseModelAll.value
        : Get.find<LeavesControllerAdmin>().leaveAdminResponseModel.value;
    if (Get.find<DashboardControllerAdmin>()
            .selectedDropdownDepartments
            .value !=
        null) {
      leavesList = model
          .leaveRequest
          ?.where((element) =>
              (element.user?.departmentId ?? 0) ==
              (Get.find<DashboardControllerAdmin>()
                      .deptwiseEmployeeMap[Get.find<DashboardControllerAdmin>()
                          .selectedDropdownDepartments
                          .value]
                      ?.first
                      .department
                      ?.id ??
                  0))
          .toList();
    }
    if (leavesList != null &&
        Get.find<DashboardControllerAdmin>().selectedDropdownBranches.value !=
            null) {
      leavesList = leavesList.where((element) {
        return (element.user?.branchId ?? 0) ==
            (Get.find<DashboardControllerAdmin>()
                    .branchwiseEmployeeMap[Get.find<DashboardControllerAdmin>()
                        .selectedDropdownBranches
                        .value]
                    ?.first
                    .branch
                    ?.id ??
                1);
      }).toList();
    } else if (leavesList == null &&
        Get.find<DashboardControllerAdmin>().selectedDropdownBranches.value !=
            null) {
      leavesList = model
          .leaveRequest
          ?.where((element) =>
              (element.user?.branchId ?? 0) ==
              (Get.find<DashboardControllerAdmin>()
                      .branchwiseEmployeeMap[
                          Get.find<DashboardControllerAdmin>()
                              .selectedDropdownBranches
                              .value]
                      ?.first
                      .branch
                      ?.id ??
                  0))
          .toList();
    }
    leavesList ??= model
        .leaveRequest;
    leavesList = leavesList
        ?.where(
          (element) =>
              element.user?.firstName.toLowerCase().contains(
                  Get.find<DashboardControllerAdmin>()
                      .searchKeyword
                      .value
                      .toLowerCase()) ??
              false,
        )
        .toList();
    return leavesList;
  }
}
