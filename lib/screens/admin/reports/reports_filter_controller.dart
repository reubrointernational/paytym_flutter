import 'package:get/get.dart';
import 'package:paytym/models/report/overtime_list_response_model.dart';
import 'package:paytym/screens/admin/leaves/leaves_controller.dart';
import 'package:paytym/screens/admin/reports/reports_controller.dart';
import 'package:paytym/screens/admin/reports/tabs/attendance_tab.dart';

import '../../../models/leaves/leaves_admin_response_model.dart';
import '../../../models/report/advance_response_model.dart';
import '../../../models/report/deduction/deduction_list_admin_model.dart';
import '../../../models/report/medical_list_admin_model.dart';
import '../../../models/report/projects/projects_list_model.dart';
import '../dashboard/dashboard_controller.dart';

import 'package:paytym/models/report/attendance/attendance_admin_response_model.dart';

class ReportsFilterController {
  List<ExtraDetail>? getFilteredMedicalList() {
    List<ExtraDetail>? medicalList;
    if (Get.find<DashboardControllerAdmin>()
            .selectedDropdownDepartments
            .value !=
        null) {
      medicalList = Get.find<ReportsControllerAdmin>()
          .medicalResponseModel
          .value
          .extraDetails
          ?.where((element) =>
              (element.users?.departmentId ?? 0) ==
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
    if (medicalList != null &&
        Get.find<DashboardControllerAdmin>().selectedDropdownBranches.value !=
            null) {
      medicalList = medicalList.where((element) {
        return (element.users?.branchId ?? 0) ==
            (Get.find<DashboardControllerAdmin>()
                    .branchwiseEmployeeMap[Get.find<DashboardControllerAdmin>()
                        .selectedDropdownBranches
                        .value]
                    ?.first
                    .branch
                    ?.id ??
                1);
      }).toList();
    } else if (medicalList == null &&
        Get.find<DashboardControllerAdmin>().selectedDropdownBranches.value !=
            null) {
      medicalList = Get.find<ReportsControllerAdmin>()
          .medicalResponseModel
          .value
          .extraDetails
          ?.where((element) =>
              (element.users?.branchId ?? 0) ==
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
    medicalList ??= Get.find<ReportsControllerAdmin>()
        .medicalResponseModel
        .value
        .extraDetails;
    medicalList = medicalList
        ?.where(
          (element) =>
              element.users?.firstName?.toLowerCase().contains(
                  Get.find<DashboardControllerAdmin>()
                      .searchKeyword
                      .value
                      .toLowerCase()) ??
              false,
        )
        .toList();
    return medicalList;
  }

  List<History>? getFilteredAttendanceList() {
    print("getFilteredAttendanceList called");
    List<History>? attendanceList;
    if (Get.find<DashboardControllerAdmin>()
            .selectedDropdownDepartments
            .value !=
        null) {
      attendanceList = Get.find<ReportsControllerAdmin>()
          .attendanceResponseModel
          .value
          .history
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
      print("getFilteredAttendanceList size ${attendanceList!.length}");
    }
    if (attendanceList != null &&
        Get.find<DashboardControllerAdmin>().selectedDropdownBranches.value !=
            null) {
      attendanceList = attendanceList.where((element) {
        return (element.user?.branchId ?? 0) ==
            (Get.find<DashboardControllerAdmin>()
                    .branchwiseEmployeeMap[Get.find<DashboardControllerAdmin>()
                        .selectedDropdownBranches
                        .value]
                    ?.first
                    .branch
                    ?.id ??
                0);
      }).toList();
    } else if (attendanceList == null &&
        Get.find<DashboardControllerAdmin>().selectedDropdownBranches.value !=
            null) {
      attendanceList = Get.find<ReportsControllerAdmin>()
          .attendanceResponseModel
          .value
          .history
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
    attendanceList ??= Get.find<ReportsControllerAdmin>()
        .attendanceResponseModel
        .value
        .history;
    attendanceList = attendanceList
        ?.where(
          (element) =>
              element.user?.firstName?.toLowerCase().contains(
                  Get.find<DashboardControllerAdmin>()
                      .searchKeyword
                      .value
                      .toLowerCase()) ??
              false,
        )
        .toList();
    return attendanceList;
  }

  List<PurpleDeduction>? getFilteredDeductionList() {
    List<PurpleDeduction>? deductionList;
    if (Get.find<DashboardControllerAdmin>()
            .selectedDropdownDepartments
            .value !=
        null) {
      deductionList = Get.find<ReportsControllerAdmin>()
          .deductionResponseModel
          .value
          .deductions
          ?.where((element) =>
              (element.departmentId ?? 0) ==
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
    if (deductionList != null &&
        Get.find<DashboardControllerAdmin>().selectedDropdownBranches.value !=
            null) {
      deductionList = deductionList.where((element) {
        return (element.branchId ?? 0) ==
            (Get.find<DashboardControllerAdmin>()
                    .branchwiseEmployeeMap[Get.find<DashboardControllerAdmin>()
                        .selectedDropdownBranches
                        .value]
                    ?.first
                    .branch
                    ?.id ??
                1);
      }).toList();
    } else if (deductionList == null &&
        Get.find<DashboardControllerAdmin>().selectedDropdownBranches.value !=
            null) {
      deductionList = Get.find<ReportsControllerAdmin>()
          .deductionResponseModel
          .value
          .deductions
          ?.where((element) =>
              (element.branchId ?? 0) ==
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
    deductionList ??= Get.find<ReportsControllerAdmin>()
        .deductionResponseModel
        .value
        .deductions;
    deductionList = deductionList
        ?.where(
          (element) =>
              element.firstName?.toLowerCase().contains(
                  Get.find<DashboardControllerAdmin>()
                      .searchKeyword
                      .value
                      .toLowerCase()) ??
              false,
        )
        .toList();
    return deductionList;
  }

  List<EmployeesList>? getFilteredAdvanceList() {
    List<EmployeesList>? advanceList;
    // print("getFilteredOvertimeList called report");
    if (AttendanceTabAdmin != null) {
      // print("getFilteredOvertimeList called 00");

      advanceList = Get.find<ReportsControllerAdmin>()
          .advanceResponseModel
          .value
          .employeeList
          .where((element) =>
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
    } else {
      print("deprtmnt not selected");
      // overtimeList = Get.find<ReportsControllerAdmin>()
      //     .overtimeResponseModel
      //     .value
      //     .employeeList
      //     .where((element) => (element.user?.status ?? 0) > 0)
      //     .toList();
      // print("overtime list length:${overtimeList?.length.toString()}");
    }
    if (advanceList != null &&
        Get.find<DashboardControllerAdmin>().selectedDropdownBranches.value !=
            null) {
      advanceList = advanceList.where((element) {
        return (element.branch?.id ?? 0) ==
            (Get.find<DashboardControllerAdmin>()
                    .branchwiseEmployeeMap[Get.find<DashboardControllerAdmin>()
                        .selectedDropdownBranches
                        .value]
                    ?.first
                    .branch
                    ?.id ??
                1);
      }).toList();
    } else if (advanceList == null &&
        Get.find<DashboardControllerAdmin>().selectedDropdownBranches.value !=
            null) {
      advanceList = Get.find<ReportsControllerAdmin>()
          .advanceResponseModel
          .value
          .employeeList
          .where((element) =>
              (element.branch?.id ?? 0) ==
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
    // overtimeList?.clear();
    advanceList = Get.find<ReportsControllerAdmin>()
        .advanceResponseModel
        .value
        .employeeList;
    // print("overtime list length:${overtimeList?.length.toString()}");
    advanceList = advanceList
        .where(
          (element) =>
              element.user?.firstName?.toLowerCase().contains(
                  Get.find<DashboardControllerAdmin>()
                      .searchKeyword
                      .value
                      .toLowerCase()) ??
              false,
        )
        .toList();
    return advanceList;
  }

  List<EmployeeList>? getFilteredOvertimeList() {
    List<EmployeeList>? overtimeList;
    // print("getFilteredOvertimeList called report");
    if (AttendanceTabAdmin != null) {
      // print("getFilteredOvertimeList called 00");

      overtimeList = Get.find<ReportsControllerAdmin>()
          .overtimeResponseModel
          .value
          .employeeList
          .where((element) =>
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
    } else {
      print("deprtmnt not selected");
      // overtimeList = Get.find<ReportsControllerAdmin>()
      //     .overtimeResponseModel
      //     .value
      //     .employeeList
      //     .where((element) => (element.user?.status ?? 0) > 0)
      //     .toList();
      // print("overtime list length:${overtimeList?.length.toString()}");
    }
    if (overtimeList != null &&
        Get.find<DashboardControllerAdmin>().selectedDropdownBranches.value !=
            null) {
      overtimeList = overtimeList.where((element) {
        return (element.branch?.id ?? 0) ==
            (Get.find<DashboardControllerAdmin>()
                    .branchwiseEmployeeMap[Get.find<DashboardControllerAdmin>()
                        .selectedDropdownBranches
                        .value]
                    ?.first
                    .branch
                    ?.id ??
                1);
      }).toList();
    } else if (overtimeList == null &&
        Get.find<DashboardControllerAdmin>().selectedDropdownBranches.value !=
            null) {
      overtimeList = Get.find<ReportsControllerAdmin>()
          .overtimeResponseModel
          .value
          .employeeList
          .where((element) =>
              (element.branch?.id ?? 0) ==
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
    // overtimeList?.clear();
    overtimeList = Get.find<ReportsControllerAdmin>()
        .overtimeResponseModel
        .value
        .employeeList;
    // print("overtime list length:${overtimeList?.length.toString()}");
    overtimeList = overtimeList
        .where(
          (element) =>
              element.user?.firstName?.toLowerCase().contains(
                  Get.find<DashboardControllerAdmin>()
                      .searchKeyword
                      .value
                      .toLowerCase()) ??
              false,
        )
        .toList();
    return overtimeList;
  }

  List<ProjectsList>? getFilteredProjectsList() {
    List<ProjectsList>? projectList;
    if (Get.find<DashboardControllerAdmin>()
            .selectedDropdownDepartments
            .value !=
        null) {
      projectList = Get.find<ReportsControllerAdmin>()
          .projectlistResponseModel
          .value
          .projectsLists
          ?.where((element) =>
              // (element.user?.departmentId ?? 0) ==
              // (Get.find<DashboardControllerAdmin>()
              //         .deptwiseEmployeeMap[Get.find<DashboardControllerAdmin>()
              //             .selectedDropdownDepartments
              //             .value]
              //         ?.first
              //         .department
              //         ?.id ??
              //     0)
              true)
          .toList();
    }
    if (projectList != null &&
        Get.find<DashboardControllerAdmin>().selectedDropdownBranches.value !=
            null) {
      projectList = projectList.where((element) {
        return (element.branch?.id ?? 0) ==
            (Get.find<DashboardControllerAdmin>()
                    .branchwiseEmployeeMap[Get.find<DashboardControllerAdmin>()
                        .selectedDropdownBranches
                        .value]
                    ?.first
                    .branch
                    ?.id ??
                1);
      }).toList();
    } else if (projectList == null &&
        Get.find<DashboardControllerAdmin>().selectedDropdownBranches.value !=
            null) {
      projectList = Get.find<ReportsControllerAdmin>()
          .projectlistResponseModel
          .value
          .projectsLists
          ?.where((element) =>
              (element.branch?.id ?? 0) ==
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
    projectList ??= Get.find<ReportsControllerAdmin>()
        .projectlistResponseModel
        .value
        .projectsLists;
    projectList = projectList
        ?.where(
          (element) =>
              element.name?.toLowerCase().contains(
                  Get.find<DashboardControllerAdmin>()
                      .searchKeyword
                      .value
                      .toLowerCase()) ??
              false,
        )
        .toList();
    return projectList;
  }
}
