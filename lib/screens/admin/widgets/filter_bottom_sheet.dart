import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/widgets.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/icons.dart';
import '../../../core/constants/strings.dart';
import '../dashboard/widgets/custom_text_form_field.dart';

showCustomBottomSheet(context, controller) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
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
                        hintText: 'Search',
                        controller: null,
                      ),
                    ]),
                kSizedBoxH15,
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
                    child: Obx(
                      () => DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller.selectedDepartment.value,
                          onChanged: (String? value) {
                            controller.selectedDepartment.value = value!;
                          },
                          hint: const Text('Department'),
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
                    child: Obx(() {
                      return DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller.selectedBranch.value,
                          onChanged: (String? value) {
                            controller.selectedBranch.value = value!;
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
                kSizedBoxH15,
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.lightBlueColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(50),
                          right: Radius.circular(50),
                        )),
                      ),
                      child: const Text('Search')),
                )
              ],
            ),
          ),
        );
      });
}
