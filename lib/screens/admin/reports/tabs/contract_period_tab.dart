import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/widgets.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/constants/styles.dart';
import '../../../../models/employee_list_model.dart';
import '../../dashboard/dashboard_controller.dart';
import '../reports_controller.dart';
import '../widgets/medical_title_tag.dart';

class ContractPeriodTabAdmin extends StatelessWidget {
  const ContractPeriodTabAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ReportsControllerAdmin>().getDeduction();
      Get.find<DashboardControllerAdmin>().clearFilter();
    });
    return Obx(() {
       List<EmployeeList>? employeesList =
          Get.find<DashboardControllerAdmin>().getFilteredEmployeeList();
      return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: employeesList?.length ?? 0,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                MedicalTitleTag(
                  branch: employeesList?[index].branch?.name ?? '',
                  name:
                      '${employeesList?[index].firstName} ${employeesList?[index].lastName}',
                  employmentId:
                      '#${employeesList?[index].id.toString().padLeft(5, '0')}',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Employment Period',
                        style: kTextStyleS14C255140x3.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                    Text('6 Months',
                        style: kTextStyleS14C255140x3.copyWith(
                            color: Colors.lightBlue)),
                  ],
                )
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => kSizedBoxH10,
      );
    });
  }
}
