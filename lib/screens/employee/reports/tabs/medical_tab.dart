import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/models/report/medical_list_admin_model.dart';
import '../../../admin/reports/dummy_data.dart';
import '../reports_controller.dart';

class MedicalTab extends StatelessWidget {
  const MedicalTab({super.key});
  @override
  Widget build(BuildContext context) {
    final medical = Get.find<ReportsController>()
            .medicalResponseModel
            .value
            .extraDetails
            .isEmpty
        ? ExtraDetail()
        : Get.find<ReportsController>()
            .medicalResponseModel
            .value
            .extraDetails
            .firstWhere((element) => element.employeeId == 1
                // Get.find<LoginController>().loginResponseModel?.employee?.id,
                );
    var med = [
      medical.medicalIssues,
      medical.allergies,
      '',
      medical.bloodGrp,
      medical.measurement,
    ];
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                medicalKeys[index],
                style: const TextStyle(fontSize: 13),
              ),
              subtitle: Text(med[index] ?? ''),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              height: 0,
            );
          },
          itemCount: med.length),
    );
  }
}
