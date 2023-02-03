import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/screens/employees_screens/dashboard/dashboard_controller.dart';
import 'package:paytym/screens/hr_screens/widgets/app_bar.dart';
import 'package:paytym/screens/hr_screens/widgets/custom_dropdown.dart';
import 'package:paytym/screens/hr_screens/widgets/custom_floating_button.dart';
import 'package:paytym/screens/hr_screens/widgets/custom_text_form_field.dart';

import '../../core/constants/strings.dart';
import 'dashboard_controller.dart';

class HrEmployeesList extends StatelessWidget {
  const HrEmployeesList({super.key});

  static List<Map<String, dynamic>> employeesLists = [
    {
      'id': '6386282927',
      'name': 'Akhil Reubro',
      'project': 'paytym',
      'branch': 'Branch',
      'check_in': '9:00 AM',
      'check_out': '6:00 PM',
    },
    {
      'id': '402921927',
      'name': 'Robin Reubro',
      'project': 'paytym',
      'branch': 'Branch',
      'check_in': '9:00 AM',
      'check_out': '6:00 PM',
    },
    {
      'id': '6388882927',
      'name': 'Sreehari Reubro',
      'project': 'jobtym',
      'branch': 'Branch',
      'check_in': '9:00 AM',
      'check_out': '6:00 PM',
    },
    {
      'id': '4993483927',
      'name': 'Sooraj Reubro',
      'project': 'jobtym',
      'branch': 'Branch',
      'check_in': '9:00 AM',
      'check_out': '6:00 PM',
    },
    {
      'id': '94842927',
      'name': 'Sreejith Reubro',
      'project': 'paytym',
      'branch': 'Branch',
      'check_in': '9:00 AM',
      'check_out': '6:00 PM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    HRDashboardController dashboardController =
        Get.put(HRDashboardController());
    dashboardController.selectedDepartment.value = departments.first;
    dashboardController.selectedBranch.value = branches.first;
    return Scaffold(
      backgroundColor: CustomColors.lightBlueColor,
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          _showBottomSheet(context, dashboardController);
        },
      ),
      body: SafeArea(
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(18, 0, 18, 8),
            child: HrAppBar(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                  color: CustomColors.whiteCardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListView.builder(
                  itemCount: employeesLists.length,
                  itemBuilder: (context, index) {
                    final employees = employeesLists[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 1, color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 90),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "ID: ${employees['id']!}",
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      employees['name']!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    RichText(
                                        text: TextSpan(
                                            text: 'Project: ',
                                            style: const TextStyle(
                                              fontSize: 11.8,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                            children: [
                                          TextSpan(
                                            text: '${employees['project']!}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ])),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      employees['branch']!,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    RichText(
                                        text: TextSpan(
                                            text: 'IN: ',
                                            style: const TextStyle(
                                              fontSize: 11.8,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  CustomColors.lightBlueColor,
                                            ),
                                            children: [
                                          TextSpan(
                                            text: employees['check_in']!,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ])),
                                    RichText(
                                        text: TextSpan(
                                            text: 'OUT: ',
                                            style: const TextStyle(
                                              fontSize: 11.8,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  CustomColors.lightBlueColor,
                                            ),
                                            children: [
                                          TextSpan(
                                            text: employees['check_out']!,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ])),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  _showBottomSheet(context, dashboardController) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                  Text(
                    'Search',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomSearchTextField(
                    iconImg: IconPath.searchIconPng,
                    hintText: 'search',
                  ),
                ]),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text(
                    'Advanced Search',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                  Container(
                    width: double.infinity,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(50),
                          right: Radius.circular(50),
                        ),
                        border: Border.all(
                            width: 1.2,
                            color: const Color.fromRGBO(182, 182, 182, 1))),
                    child: Obx(() {
                      return DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: dashboardController.selectedDepartment.value,
                          onChanged: (String? value) {
                            dashboardController.selectedDepartment.value =
                                value!;
                          },
                          hint: const Text('department'),
                          isExpanded: true,
                          icon: Image.asset(
                            IconPath.dropdownIconPng,
                            height: 20,
                            width: 20,
                          ),
                          items: departments
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(50),
                          right: Radius.circular(50),
                        ),
                        border: Border.all(
                            width: 1.2,
                            color: const Color.fromRGBO(182, 182, 182, 1))),
                    child: Obx(() {
                      return DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: dashboardController.selectedBranch.value,
                          onChanged: (String? value) {
                            dashboardController.selectedBranch.value =
                                value!;
                          },
                          hint: const Text('branches'),
                          isExpanded: true,
                          icon: Image.asset(
                            IconPath.dropdownIconPng,
                            height: 20,
                            width: 20,
                          ),
                          items: branches
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                        ),
                      );
                    }),
                  ),
                ]),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(onPressed: (){}, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.lightBlueColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(50),
                        right: Radius.circular(50),
                      )
                    ),
                  ),
                  child: const Text('Search')),
                )
              ],
            ),
          );
        });
  }
}
