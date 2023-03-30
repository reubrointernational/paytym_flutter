import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/network/base_controller.dart';

import '../../../core/constants/enums.dart';
import '../../../core/constants/icons.dart';
import '../../../models/dashboard/dashboard_admin_response_model.dart';
import '../../../models/employee_list_model.dart';
import '../../../network/base_client.dart';
import '../../../network/end_points.dart';
import '../../login/login_controller.dart';

class DashboardControllerAdmin extends GetxController with BaseController {
  final employeeList =
      EmployeeListAdminModel(employeeList: [], message: '').obs;
  // final branchDeptList =
  //     BranchDeptListModel(branches: [], departments: [], message: '').obs;
  Map<String, List<EmployeeList>> branchwiseEmployeeMap = {};
  Map<String, List<EmployeeList>> deptwiseEmployeeMap = {};
  final selectMemberTab = SelectChatMemberTab.all.obs;
  final selectedDropdownDepartments = Rxn<String>();
  final selectedDropdownBranches = Rxn<String>();
  //index list of selected items
  final selectedItemList = <int>[].obs;
  bool isSelectMembersPageFromChat = true;
  final searchKeyword = ''.obs;
  DashboardAdminResponseModel dashboardDetails = DashboardAdminResponseModel();

  seeDetailsPage(index) {
    switch (index) {
      case 0:
        
        Get.find<LoginController>().bottomNavigationAdminIndex.value = 4;
        break;
      case 1:
        Get.find<LoginController>().initialIndex = 1;
        Get.find<LoginController>().bottomNavigationAdminIndex.value = 4;
        break;
      case 2:
        Get.find<LoginController>().bottomNavigationAdminIndex.value = 1;
        break;
      case 3:
        Get.find<LoginController>().bottomNavigationAdminIndex.value = 2;
        break;
    }
  }

  @override
  void onReady() {
    super.onReady();
    // fetchDashboardData();

    fetchEmployeeList();
  }

  // fetchDashboardData() async {
  //   showLoading();
  //   Get.find<BaseClient>().onError = fetchDashboardData;

  //   var responseString = await Get.find<BaseClient>()
  //       .post(ApiEndPoints.leaveAdmin, null,
  //           Get.find<LoginController>().getHeader())
  //       .catchError(handleError);
  //   if (responseString == null) {
  //     return;
  //   } else {
  //     hideLoading();
  //     // leaveAdminResponseModel.value =
  //     //     leavesAdminResponseModelFromJson(responseString);
  //     Get.find<BaseClient>().onError = null;
  //   }
  // }

  fetchEmployeeList([bool isFromPayroll = false]) async {
    if ((employeeList.value.message?.isEmpty ?? true) || isFromPayroll) {
      Get.find<BaseClient>().onError = fetchEmployeeList;
      var requestModel = {
        'employer_id':
            '${Get.find<LoginController>().loginResponseModel?.employee?.employerId}'
      };
      var responseString = await Get.find<BaseClient>()
          .post(ApiEndPoints.employeeList, jsonEncode(requestModel),
              Get.find<LoginController>().getHeader())
          .catchError(handleError);
      if (responseString == null) {
        return;
      } else {
        employeeList.value = employeeListAdminModelFromJson(responseString);
        Get.find<BaseClient>().onError = null;
        classifyEmployeeListByBranchAndDept();
        // fetchBranchDeptList();
      }
    }
  }

  fetchDashboardDetails() async {
    if (dashboardDetails.message?.isEmpty ?? true) {
      Get.find<BaseClient>().onError = fetchDashboardDetails;
      var requestModel = {
        'employer_id':
            '${Get.find<LoginController>().loginResponseModel?.employee?.employerId}'
      };
      var responseString = await Get.find<BaseClient>()
          .post(ApiEndPoints.adminDashboard, jsonEncode(requestModel),
              Get.find<LoginController>().getHeader())
          .catchError(handleError);
      if (responseString == null) {
        return;
      } else {
        dashboardDetails = dashboardAdminResponseModelFromJson(responseString);
        Get.find<BaseClient>().onError = null;
      }
    }
  }

  Map<String, dynamic> getCardDetails(int index) {
    List<Map<String, dynamic>> totalEmployeesDetails = [
      {
        'icon': IconPath.projectIconPng,
        'title': 'Total Projects',
        'count': dashboardDetails.projectsCount ?? '',
        'color': Colors.pink,
      },
      {
        'icon': IconPath.attendanceIconPng,
        'title': 'Total Attendance',
        'count': dashboardDetails.attendanceCount ?? '',
        'color': Colors.purple,
      },
      {
        'icon': IconPath.absenteesIconPng,
        'title': 'Total Absentees',
        'count': dashboardDetails.absenteesCount ?? '',
        'color': Colors.red,
      },
      {
        'icon': IconPath.meetingsIconPng,
        'title': 'Total Meetings',
        'count': dashboardDetails.meetingsCount ?? '',
        'color': Colors.orange,
      },
    ];
    switch (index) {
      case 0:
        return totalEmployeesDetails[0];
      case 1:
        return totalEmployeesDetails[1];
      case 2:
        return totalEmployeesDetails[2];
      default:
        return totalEmployeesDetails[3];
    }
  }

  classifyEmployeeListByBranchAndDept() {
    for (var element in employeeList.value.employeeList ?? []) {
      if (!branchwiseEmployeeMap.keys.contains(element.branch?.name ?? '')) {
        branchwiseEmployeeMap[element.branch?.name ?? ''] = [element];
      } else {
        branchwiseEmployeeMap[element.branch?.name ?? '']!.add(element);
      }
      if (!deptwiseEmployeeMap.keys
          .contains(element.department?.depName ?? '')) {
        deptwiseEmployeeMap[element.department?.depName ?? ''] = [element];
      } else {
        deptwiseEmployeeMap[element.department?.depName ?? '']!.add(element);
      }
    }
  }

  // fetchBranchDeptList() async {
  //   if (branchDeptList.value.message.isEmpty) {
  //     Get.find<BaseClient>().onError = fetchBranchDeptList;
  //     var requestModel = {
  //       //todo change employer id
  //       'employer_id': '4'
  //       // '${Get.find<LoginController>().loginResponseModel?.employee?.employer_id}'
  //     };
  //     var responseString = await Get.find<BaseClient>()
  //         .post(ApiEndPoints.branchDeptList, jsonEncode(requestModel),
  //             Get.find<LoginController>().getHeader())
  //         .catchError(handleError);
  //     if (responseString == null) {
  //       return;
  //     } else {
  //       branchDeptList.value = branchDeptListModelFromJson(responseString);
  //       Get.find<BaseClient>().onError = null;
  //     }
  //   }
  // }

  resetTabs(SelectChatMemberTab tab) {
    selectMemberTab.value = tab;
    if (tab == SelectChatMemberTab.all) {
      selectedDropdownDepartments.value = null;
      selectedDropdownBranches.value = null;
    }
  }

  getEmployees() {
    switch (selectMemberTab.value) {
      case SelectChatMemberTab.branch:
        return selectedDropdownDepartments.value == null
            ? Get.find<DashboardControllerAdmin>()
                .branchwiseEmployeeMap[selectedDropdownBranches.value]
            : Get.find<DashboardControllerAdmin>()
                .deptwiseEmployeeMap[selectedDropdownDepartments.value]
                ?.where((element) =>
                    element.branch?.name == selectedDropdownBranches.value);
      case SelectChatMemberTab.department:
        return Get.find<DashboardControllerAdmin>()
            .deptwiseEmployeeMap[selectedDropdownDepartments.value];
      default:
        return Get.find<DashboardControllerAdmin>()
            .employeeList
            .value
            .employeeList;
    }
  }

  List<EmployeeList>? getFilteredEmployeeList() {
    List<EmployeeList>? chatList;
    if (selectedDropdownDepartments.value != null) {
      chatList = deptwiseEmployeeMap[selectedDropdownDepartments.value];
    }
    if (chatList != null && selectedDropdownBranches.value != null) {
      chatList = chatList
          .where((element) =>
              element.branch?.name == selectedDropdownBranches.value)
          .toList();
    } else if (chatList == null && selectedDropdownBranches.value != null) {
      chatList = branchwiseEmployeeMap[selectedDropdownBranches.value];
    }

    chatList ??= employeeList.value.employeeList;

    chatList = chatList
        ?.where(
          (element) =>
              element.firstName
                  ?.toLowerCase()
                  .contains(searchKeyword.value.toLowerCase()) ??
              false,
        )
        .toList();
    return chatList;
  }

  clearFilter() {
    selectedDropdownDepartments.value = null;
    selectedDropdownBranches.value = null;
    searchKeyword.value = '';
  }
}
