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
import '../reports/reports_controller.dart';

class DashboardControllerAdmin extends GetxController with BaseController {
  final employeeList =
      EmployeeListAdminModel(employeeList: [], message: '').obs;
  // final branchDeptList =
  //     BranchDeptListModel(branches: [], departments: [], message: '').obs;
  Map<String, List<EmployeeList>> businesswiseEmployeeMap = {};
  Map<String, List<EmployeeList>> branchwiseEmployeeMap = {};
  Map<String, List<EmployeeList>> deptwiseEmployeeMap = {};
  final selectMemberTab = SelectChatMemberTab.all.obs;
  final selectedDropdownDepartments = Rxn<String>();
  final selectedDropdownBranches = Rxn<String>();
  final selectedDropdownBusiness = Rxn<String>();
  //index list of selected items
  final selectedItemList = <int>[].obs;
  bool isSelectMembersPageFromChat = true;
  bool payrollProcessDownArrow = false;
  final searchKeyword = ''.obs;

  DashboardAdminResponseModel dashboardDetails = DashboardAdminResponseModel();

  seeDetailsPage(index) {
    switch (index) {
      case 0:
        Get.find<LoginController>().initialTab = 'Projects';
        Get.find<LoginController>().bottomNavigationAdminIndex.value = 4;
        break;
      case 1:
        Get.find<LoginController>().bottomNavigationAdminIndex.value = 4;
        break;
      case 2:
        Get.find<LoginController>().bottomNavigationAdminIndex.value = 4;
        break;
      case 3:
        Get.find<LoginController>().bottomNavigationAdminIndex.value = 2;
        break;
      case 4:
        Get.find<LoginController>().bottomNavigationAdminIndex.value = 1;
        break;
      case 5:
        Get.find<LoginController>().initialTab = 'Payroll';
        Get.find<LoginController>().bottomNavigationAdminIndex.value = 4;
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
    print("Calling fetchEmployeeList() first");
    if ((employeeList.value.message?.isEmpty ?? true) || isFromPayroll) {
      print("Calling fetchEmployeeList() second");
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
        'title': 'Total Meetings Today',
        'count': dashboardDetails.meetingsCount ?? '',
        'color': Colors.orange,
      },
      {
        'icon': IconPath.pendingIconPng,
        'title': 'Pending Leaves',
        'count': dashboardDetails.pendingLeaves ?? '',
        'color': Colors.amber,
      },
      {
        'icon': IconPath.activeIconPng,
        'title': 'Active Employees Count',
        'count': dashboardDetails.activeEmployeesCount ?? '',
        'color': Colors.cyan,
      },
    ];
    return totalEmployeesDetails[index];
  }

  classifyEmployeeListByBranchAndDept() {
    print("classifyEmployeeListByBranchAndDept called");

    for (var element in employeeList.value.employeeList ?? []) {
      print("Element:");
      if (!branchwiseEmployeeMap.keys.contains(element.branch?.name ?? '')) {
        print(
            "classifyEmployeeListByBranchAndDept branchwiseEmployeeMap element.branch?.name ");
        branchwiseEmployeeMap[element.branch?.name ?? ''] = [element];
      } else {
        print(
            "null classifyEmployeeListByBranchAndDept branchwiseEmployeeMap element.branch?.name ");
        branchwiseEmployeeMap[element.branch?.name ?? '']!.add(element);
      }
      if (!deptwiseEmployeeMap.keys
          .contains(element.department?.depName ?? '')) {
        print(
            "  classifyEmployeeListByBranchAndDept deptwiseEmployeeMap element.depName?.name ");
        deptwiseEmployeeMap[element.department?.depName ?? ''] = [element];
      } else {
        print(
            "null classifyEmployeeListByBranchAndDept deptwiseEmployeeMap element.depName?.name ");
        deptwiseEmployeeMap[element.department?.depName ?? '']!.add(element);
      } //
      if (!businesswiseEmployeeMap.keys.contains(element.business.name ?? '')) {
        print(
            "classifyEmployeeListByBranchAndDept businesswiseEmployeeMap element.depName?.name ");
        businesswiseEmployeeMap[element.business.name ?? ''] = [element];
      } else {
        print(
            "null classifyEmployeeListByBranchAndDept businesswiseEmployeeMap element.depName?.name ");
        businesswiseEmployeeMap[element.business.name ?? '']!.add(element);
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
      selectedDropdownBusiness.value = null;
    } else if (tab == SelectChatMemberTab.business) {
      selectedDropdownDepartments.value = null;
      selectedDropdownBranches.value = null;
    } else if (tab == SelectChatMemberTab.branch) {
      selectedDropdownDepartments.value = null;
    }
  }

  List<EmployeeList>? getEmployees() {
    switch (selectMemberTab.value) {
      case SelectChatMemberTab.branch:
        return selectedDropdownDepartments.value == null
            ? Get.find<DashboardControllerAdmin>()
                .branchwiseEmployeeMap[selectedDropdownBranches.value]
            : Get.find<DashboardControllerAdmin>()
                .deptwiseEmployeeMap[selectedDropdownDepartments.value]
                ?.where((element) =>
                    element.branch?.name == selectedDropdownBranches.value)
                .toList();
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

  List<EmployeeList>? getAllEmployees() {
    print(
        "getAllEmployees called size:${Get.find<DashboardControllerAdmin>().employeeList.value.employeeList?.length}");
    return Get.find<DashboardControllerAdmin>().employeeList.value.employeeList;
  }

  List<EmployeeList>? getFilteredEmployeeList() {
    print("getFilteredEmployeeList called 10");
    List<EmployeeList>? chatList;
    if (selectedDropdownBusiness.value != null) {
      print(
          "getFilteredEmployeeList called 2 businesswiseEmployeeMap :${selectedDropdownBusiness.value.toString()}");
      chatList = businesswiseEmployeeMap[selectedDropdownBusiness.value];
      print("getFilteredEmployeeList called 2.1:${chatList?.length}");
    }
    if (selectedDropdownDepartments.value != null) {
      print(
          "getFilteredEmployeeList called 2: ${selectedDropdownDepartments.value.toString()}");
      chatList = deptwiseEmployeeMap[selectedDropdownDepartments.value];
    }
    if (chatList != null && selectedDropdownBranches.value != null) {
      print(
          "getFilteredEmployeeList called 3:${selectedDropdownBranches.value.toString()}");
      chatList = chatList
          .where((element) =>
              element.branch?.name == selectedDropdownBranches.value)
          .toList();
    } else if (chatList == null && selectedDropdownBranches.value != null) {
      print("getFilteredEmployeeList called 4");
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
    print("getFilteredEmployeeList called 1 ${chatList?.length.toString()}");
    return chatList;
  }

  List<EmployeeList>? getOverTimeEmployeeList() {
    print("getOverTimeEmployeeList called");
    List<EmployeeList>? chatList;
    if (selectedDropdownBusiness.value != null) {
      print(
          "getOverTimeEmployeeList called 2 businesswiseEmployeeMap with ${selectedDropdownBusiness.value.toString()}");
      chatList = businesswiseEmployeeMap[selectedDropdownBusiness.value];
      print("getOverTimeEmployeeList called 2.1:${chatList?.length}");
    }
    if (selectedDropdownDepartments.value != null) {
      print("getOverTimeEmployeeList called 2");
      chatList = deptwiseEmployeeMap[selectedDropdownDepartments.value];
    }
    if (chatList != null && selectedDropdownBranches.value != null) {
      print("getOverTimeEmployeeList called 3");
      chatList = chatList
          .where((element) =>
              element.branch?.name == selectedDropdownBranches.value)
          .toList();
    } else if (chatList == null && selectedDropdownBranches.value != null) {
      print("getOverTimeEmployeeList called 4");
      chatList = branchwiseEmployeeMap[selectedDropdownBranches.value];
    }
    // Updating below
    if (selectedDropdownBusiness.value == null) {
      chatList ??= employeeList.value.employeeList;
    } else {
      print("getOverTimeEmployeeList called 2 businesswiseEmployeeMap");
      chatList = businesswiseEmployeeMap[selectedDropdownBusiness.value];
      print("getOverTimeEmployeeList called 2.1:${chatList?.length}");
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
    print("getFilteredEmployeeList called 1 ${chatList?.length.toString()}");
    return chatList;
  }

  clearFilter() {
    selectedDropdownBusiness.value = null;
    selectedDropdownDepartments.value = null;
    selectedDropdownBranches.value = null;
    searchKeyword.value = '';
    // updation 28 sep 2023
    Get.find<DashboardControllerAdmin>().selectedDropdownBusiness.value = null;
    Get.find<DashboardControllerAdmin>().selectedDropdownBranches.value = null;
    Get.find<DashboardControllerAdmin>().selectedDropdownDepartments.value =
        null;
  }
}
