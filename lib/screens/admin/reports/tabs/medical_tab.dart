import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/widgets.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/styles.dart';
import '../dummy_data.dart';
import '../reports_controller.dart';
import '../widgets/medical_title_tag.dart';

class MedicalTabAdmin extends StatelessWidget {
  const MedicalTabAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Get.find<ReportsControllerAdmin>().getMedical());
    return Obx(() {
      var medicalDetails = Get.find<ReportsControllerAdmin>()
          .medicalResponseModel
          .value
          .extraDetails;
      return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: medicalDetails.length,
        itemBuilder: (context, index) {
          var medicalUnit = medicalDetails[index];
          return Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: MedicalTitleTag(
                          branch: 'Branch',
                          name:
                              '${medicalUnit.users?.firstName} ${medicalUnit.users?.lastName}',
                          employmentId: medicalUnit.users?.id.toString() ?? '',
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ...List.generate(
                        4,
                        ((col_index) {
                          var med = [
                            medicalUnit.medicalIssues,
                            medicalUnit.allergies,
                            medicalUnit.bloodGrp,
                            medicalUnit.measurement,
                          ];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    medicalKeys[col_index],
                                    style: kTextStyleS14W600Cgrey300LS0p2
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                                kSizedBoxW12,
                                Expanded(
                                  child: Text(
                                    med[col_index] ?? '',
                                    style: kTextStyleS14C255140x3.copyWith(
                                        color: CustomColors.lightBlueColor),
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
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => kSizedBoxH10,
      );
    });
  }
}
