import 'package:get/get.dart';
import 'package:paytym/models/report/overtime_list_response_model.dart';
import 'package:paytym/screens/admin/leaves/leaves_controller.dart';
import 'package:paytym/screens/admin/reports/reports_controller.dart';

import '../../../models/leaves/leaves_admin_response_model.dart';
import '../../../models/report/deduction/deduction_list_admin_model.dart';
import '../../../models/report/medical_list_admin_model.dart';
import '../../../models/report/projects/projects_list_model.dart';
import '../dashboard/dashboard_controller.dart';

import 'package:paytym/models/report/attendance/attendance_admin_response_model.dart';

class LeavesFilterController {
  

  List<LeaveRequest>? getFilteredLeavesList() {
    List<LeaveRequest>? leavesList;
    if (Get.find<DashboardControllerAdmin>()
            .selectedDropdownDepartments
            .value !=
        null) {
      leavesList = Get.find<LeavesControllerAdmin>()
          .leaveAdminResponseModel
          .value
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
      leavesList = Get.find<LeavesControllerAdmin>()
          .leaveAdminResponseModel
          .value
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
    leavesList ??= Get.find<LeavesControllerAdmin>()
        .leaveAdminResponseModel
        .value
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

  List<LeaveRequest>? getFilteredLeavesPendingList() {
    List<LeaveRequest>? leavesList;
    if (Get.find<DashboardControllerAdmin>()
            .selectedDropdownDepartments
            .value !=
        null) {
      leavesList = Get.find<LeavesControllerAdmin>()
          .leaveAdminResponseModelPending
          .value
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
      leavesList = Get.find<LeavesControllerAdmin>()
          .leaveAdminResponseModelPending
          .value
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
    leavesList ??= Get.find<LeavesControllerAdmin>()
        .leaveAdminResponseModelPending
        .value
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
