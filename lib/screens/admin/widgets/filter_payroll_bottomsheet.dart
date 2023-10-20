import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/models/employee_list_model.dart';
import 'package:paytym/screens/admin/dashboard/dashboard_controller.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/enums.dart';
import '../../../core/constants/icons.dart';
import '../../../core/constants/strings.dart';
import '../../../core/constants/styles.dart';
import '../../../network/end_points.dart';
import '../../employee/reports/widgets/year_dropdown.dart';
import '../reports/reports_controller.dart';

showFilterBottomSheet(context, controller) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (context) {
        Get.find<ReportsControllerAdmin>().fetchBusiness();
        Get.find<ReportsControllerAdmin>().filteredEmployeeList = [];
        return SizedBox(
          child: Padding(
            // padding: const EdgeInsets.all(5),
            padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                kSizedBoxH35,
                const Text(
                  'Advanced Search',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                kSizedBoxH15,
                /*CustomDropdownButton(
                      lists: HrEmployeesList.departments,
                      value: selectedDepartment,
                      hint: 'Department',
                      onChanged: (String? value) {
                        setState(() {
                          selectedDepartment = value!;
                        });
                      },
                    ),*/

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
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(50),
                                right: Radius.circular(50),
                              ),
                              border: Border.all(
                                  width: 1.2,
                                  color:
                                      const Color.fromRGBO(182, 182, 182, 1))),
                          margin: const EdgeInsets.only(bottom: 15),
                          child: CustomDropdownYearButton(
                            alignment: Alignment.centerLeft,
                            lists: business.map((e) => e.name).toList(),
                            value: Get.find<DashboardControllerAdmin>()
                                .selectedDropdownBusiness
                                .value,
                            onChanged: (value) {
                              Get.find<DashboardControllerAdmin>()
                                  .resetTabs(SelectChatMemberTab.business);
                              Get.find<DashboardControllerAdmin>()
                                  .selectedDropdownBusiness
                                  .value = value;

                              try {
                                final businessId = business
                                    .firstWhere(
                                        (element) => element.name == value)
                                    .id;

                                Get.find<ReportsControllerAdmin>()
                                    .fetchBranches(businessId);

                                Get.find<ReportsControllerAdmin>()
                                    .fetchEmployees(businessId);
                              } on Exception {
                                // TODO
                              }
                            },
                            hint: selectMembersTabsAttendance[0],
                          ),
                        ),
                        ...List.generate(
                          2,
                          (index) => Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(50),
                                  right: Radius.circular(50),
                                ),
                                border: Border.all(
                                    width: 1.2,
                                    color: const Color.fromRGBO(
                                        182, 182, 182, 1))),
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
                                Get.find<DashboardControllerAdmin>().resetTabs(
                                    index == 0
                                        ? SelectChatMemberTab.branch
                                        : SelectChatMemberTab.department);
                                index == 0
                                    ? Get.find<DashboardControllerAdmin>()
                                        .selectedDropdownBranches
                                        .value = value
                                    : Get.find<DashboardControllerAdmin>()
                                        .selectedDropdownDepartments
                                        .value = value;

                                if (index == 0) {
                                  try {
                                    final branchId = branch
                                        .firstWhere(
                                          (element) => element.name == value,
                                        )
                                        .id;
                                    Get.find<ReportsControllerAdmin>()
                                        .fetchDepartments(branchId);
                                  } on Exception {
                                    // TODO
                                  }
                                }
                              },
                              hint: selectMembersTabsAttendance[index + 1],
                            ),
                          ),
                        ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //       borderRadius: const BorderRadius.horizontal(
                        //         left: Radius.circular(50),
                        //         right: Radius.circular(50),
                        //       ),
                        //       border: Border.all(
                        //           width: 1.2,
                        //           color:
                        //               const Color.fromRGBO(182, 182, 182, 1))),
                        //   margin: const EdgeInsets.only(bottom: 15),
                        //   child: CustomDropdownYearButton(
                        //     alignment: Alignment.centerLeft,
                        //     lists: business.map((e) => e.name).toList(),
                        //     value: Get.find<DashboardControllerAdmin>()
                        //         .selectedDropdownBusiness
                        //         .value,
                        //     onChanged: (value) {
                        //       Get.find<DashboardControllerAdmin>()
                        //           .selectedDropdownBusiness
                        //           .value = value;
                        //       Get.find<DashboardControllerAdmin>()
                        //           .resetTabs(SelectChatMemberTab.department);

                        //       final businessId = business
                        //           .firstWhere(
                        //               (element) => element.name == value)
                        //           .id;

                        //       Get.find<ReportsControllerAdmin>()
                        //           .fetchBranches(businessId);
                        //     },
                        //     hint: selectMembersTabsAttendance[3],
                        //   ),
                        // ),
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
                                      BorderRadius.all(Radius.circular(25)),
                                  borderSide: BorderSide(
                                      width: 1.2,
                                      color: Color.fromRGBO(182, 182, 182, 1))),
                              focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  borderSide: BorderSide(
                                      width: 1.2,
                                      color: Color.fromRGBO(182, 182, 182, 1))),
                            ),
                          ),
                        ),
                      ]);
                }),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Obx(() {
                      Get.find<ReportsControllerAdmin>().filteredEmployeeList =
                          Get.find<ReportsControllerAdmin>()
                              .employeeList
                              .value
                              .employeeList;
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
                        Get.find<ReportsControllerAdmin>()
                                .filteredEmployeeList =
                            Get.find<ReportsControllerAdmin>()
                                .filteredEmployeeList
                                ?.where(
                                    (element) => element.branchId == branchId)
                                .toList();
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
                        Get.find<ReportsControllerAdmin>()
                                .filteredEmployeeList =
                            Get.find<ReportsControllerAdmin>()
                                .filteredEmployeeList
                                ?.where(
                                    (element) => element.departmentId == deptId)
                                .toList();
                      }

                      Get.find<ReportsControllerAdmin>()
                          .filteredEmployeeList = Get.find<
                              ReportsControllerAdmin>()
                          .filteredEmployeeList
                          ?.where((element) =>
                              ('${element.firstName?.toLowerCase()} ${element.firstName?.toLowerCase()}'
                                  .contains(Get.find<DashboardControllerAdmin>()
                                      .searchKeyword
                                      .value
                                      .toLowerCase())))
                          .toList();
                      print("");
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: Get.find<ReportsControllerAdmin>()
                                .filteredEmployeeList
                                ?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.2, color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              title: Text(
                                '${Get.find<ReportsControllerAdmin>().filteredEmployeeList?[index].firstName ?? ''} ${Get.find<ReportsControllerAdmin>().filteredEmployeeList?[index].lastName ?? ''}',
                                style: kTextStyleS18W600CBlack,
                              ),
                              subtitle: Text(
                                  '#${Get.find<ReportsControllerAdmin>().filteredEmployeeList?[index].id.toString().padLeft(5, '0')}'),
                              leading: CircleAvatar(
                                radius: 28,
                                backgroundImage: NetworkImage(
                                    '$kStorageUrl${Get.find<ReportsControllerAdmin>().filteredEmployeeList?[index].image ?? ''}'),
                              ),
                              trailing: Checkbox(
                                value: Get.find<ReportsControllerAdmin>()
                                        .filteredEmployeeList?[index]
                                        .isSelected ??
                                    false,
                                onChanged: (bool? value) {
                                  Get.find<ReportsControllerAdmin>()
                                      .filteredEmployeeList?[index]
                                      .isSelected = value!;
                                  Get.find<ReportsControllerAdmin>()
                                      .employeeList
                                      .refresh();
                                },
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        print(
                            "Selected Employee List:${Get.find<ReportsControllerAdmin>().filteredEmployeeList?.length.toString()}");
                        Navigator.pop(context);
                        // if (Get.find<ReportsControllerAdmin>()
                        //         .filteredEmployeeList
                        //         ?.isNotEmpty ??
                        //     false) {
                        //   Get.find<ReportsControllerAdmin>()
                        //           .selectedEmployeeIDs =
                        //       Get.find<ReportsControllerAdmin>()
                        //           .filteredEmployeeList
                        //           ?.where((element) => element.isSelected)
                        //           .map((e) => e.id.toString())
                        //           .cast<EmployeeList>()
                        //           .toList();
                        //   print(
                        //       "Selected Employee List:${Get.find<ReportsControllerAdmin>().filteredEmployeeList?.length.toString()}");
                        //   Navigator.of(context).pop();
                        //   // Get.find<ReportsControllerAdmin>()
                        //   //     .processPayroll('employee', ids);
                        // }

                        // Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.lightBlueColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(50),
                          right: Radius.circular(50),
                        )),
                      ),
                      child: const Text('Select Employees')),
                  // child: const Text('Process Payroll')),
                )
              ],
            ),
          ),
        );
      });
}
