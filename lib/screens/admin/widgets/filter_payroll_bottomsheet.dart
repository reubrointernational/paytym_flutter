import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/admin/dashboard/dashboard_controller.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/icons.dart';
import '../dashboard/widgets/custom_text_form_field.dart';

showFilterBottomSheet(context, controller) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Padding(
            // padding: const EdgeInsets.all(5),
            padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text(
                    'Advanced Search',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
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
                    child: Obx(
                      () => DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: Get.find<DashboardControllerAdmin>()
                              .selectedDropdownDepartments
                              .value,
                          onChanged: (String? value) {
                            Get.find<DashboardControllerAdmin>()
                                .selectedDropdownDepartments
                                .value = value!;
                          },
                          hint: const Text('Department'),
                          isExpanded: true,
                          icon: Image.asset(
                            IconPath.dropdownIconPng,
                            height: 20,
                            width: 20,
                          ),
                          items: Get.find<DashboardControllerAdmin>()
                              .deptwiseEmployeeMap
                              .keys
                              .toList()
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                        ),
                      ),
                    ),
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
                    child: Obx(
                      () => DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: Get.find<DashboardControllerAdmin>()
                              .selectedDropdownBranches
                              .value,
                          onChanged: (String? value) {
                            Get.find<DashboardControllerAdmin>()
                                .selectedDropdownBranches
                                .value = value!;
                          },
                          hint: const Text('Branch'),
                          isExpanded: true,
                          icon: Image.asset(
                            IconPath.dropdownIconPng,
                            height: 20,
                            width: 20,
                          ),
                          items: Get.find<DashboardControllerAdmin>()
                              .branchwiseEmployeeMap
                              .keys
                              .toList()
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
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
                    child: Obx(
                      () => DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: Get.find<DashboardControllerAdmin>()
                              .selectedDropdownBranches
                              .value,
                          onChanged: (String? value) {
                            Get.find<DashboardControllerAdmin>()
                                .selectedDropdownBranches
                                .value = value!;
                          },
                          hint: const Text('Bank'),
                          isExpanded: true,
                          icon: Image.asset(
                            IconPath.dropdownIconPng,
                            height: 20,
                            width: 20,
                          ),
                          items: Get.find<DashboardControllerAdmin>()
                              .branchwiseEmployeeMap
                              .keys
                              .toList()
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const Text(
                        //   'Search',
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.w500,
                        //     fontSize: 16,
                        //   ),
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomSearchTextField(
                          iconImg: IconPath.searchIconPng,
                          hintText: 'Search',
                          controller: Get.find<DashboardControllerAdmin>(),
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ]),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     TextButton(
                  //         onPressed: () {
                  //           Get.find<DashboardControllerAdmin>().clearFilter();
                  //         },
                  //         child: const Text(
                  //           'Clear',
                  //           style: TextStyle(color: Colors.blue),
                  //         )),
                  //   ],
                  // ),
                ]),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.lightBlueColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(50),
                          right: Radius.circular(50),
                        )),
                      ),
                      child: const Text('Submit')),
                )
              ],
            ),
          ),
        );
      });
}
