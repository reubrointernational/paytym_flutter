import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/widgets.dart';
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
        (_) => Get.find<ReportsControllerAdmin>().getDeduction());
    return Obx(
      () => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 
        // Get.find<ReportsControllerAdmin>()
        //         .deductionResponseModel
        //         .value
        //         .details
        //         ?.length ??
            0,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: const [
                    Expanded(
                      flex: 2,
                      child: MedicalTitleTag(
                        branch: 'Branch',
                        name: 'Akhil Reubro',
                        employmentId: '0045786',
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ...List.generate(
                      medicalDetails.length,
                      ((index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  medicalKeys[index],
                                  style: kTextStyleS14W600Cgrey300LS0p2
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                              kSizedBoxW12,
                              Expanded(
                                child: Text(
                                  medicalValues[index],
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
      ),
    );
  }
}
