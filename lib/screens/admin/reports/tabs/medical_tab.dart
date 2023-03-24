import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/admin/dashboard/dashboard_controller.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/styles.dart';
import '../../../../models/report/medical_list_admin_model.dart';
import '../reports_controller.dart';
import '../widgets/medical_title_tag.dart';

class MedicalTabAdmin extends StatelessWidget {
  const MedicalTabAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ReportsControllerAdmin>().getMedical();
      Get.find<DashboardControllerAdmin>().clearFilter();
    });
    
    return Obx(() {
      List<ExtraDetail>? medicalDetails =
          Get.find<ReportsControllerAdmin>().getFilteredMedicalList();
      return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: medicalDetails?.length ?? 0,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: MedicalTitleTag(
                        branch: '',
                        name:
                            '${medicalDetails?[index].users?.firstName} ${medicalDetails?[index].users?.lastName}',
                        employmentId:
                            '#${medicalDetails?[index].users?.id?.toString().padLeft(5, '0') ?? ''}',
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ...List.generate(
                      4,
                      ((subIndex) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  medicalList[subIndex],
                                  style: kTextStyleS14W600Cgrey300LS0p2
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                              kSizedBoxW12,
                              Expanded(
                                child: Text(
                                  Get.find<ReportsControllerAdmin>()
                                      .getMedicalDetails(subIndex),
                                  style: kTextStyleS14C255140x3.copyWith(
                                      color: Colors.lightBlue),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => kSizedBoxH10,
      );
    });
  }
}
