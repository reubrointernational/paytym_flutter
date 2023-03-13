import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/constants/widgets.dart';
import '../reports_controller.dart';

class MedicalTab extends StatelessWidget {
  const MedicalTab({super.key});
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<ReportsController>().getMedical();
    });
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Obx(() => ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                ...List.generate(
                  4,
                  ((subIndex) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(bottom: 20, left: 8, right: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              medicalList[subIndex],
                              style: kTextStyleS14W600Cgrey300LS0p2.copyWith(
                                  color: Colors.black),
                            ),
                          ),
                          kSizedBoxW12,
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                Get.find<ReportsController>()
                                    .getMedicalDetails(subIndex),
                                style: kTextStyleS14C255140x3.copyWith(
                                    color: Colors.lightBlue),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              height: 0,
            );
          },
          itemCount: Get.find<ReportsController>()
                  .medicalResponseModel
                  .value
                  .extraDetails
                  ?.length ??
              0)),
    );
  }
}
