import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/widgets.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/constants/styles.dart';
import '../reports_controller.dart';
import '../widgets/medical_title_tag.dart';

class DeductionTabAdmin extends StatelessWidget {
  const DeductionTabAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Get.find<ReportsControllerAdmin>().getDeduction());
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            2,
            (index) => Stack(
              children: [
                const Positioned(
                  right: 12,
                  top: 2,
                  child: Icon(
                    Icons.download_outlined,
                    color: Colors.green,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.lightBlue),
                        child: Text(
                          '16',
                          style:
                              kTextStyleS18W600.copyWith(color: Colors.amber),
                        ),
                      ),
                      kSizedBoxH10,
                      Text(
                        index == 0 ? 'Surcharge' : 'Advance',
                        style: kTextStyleS14W600LS0p2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        kSizedBoxH10,
        Expanded(
          child: Obx(
            () => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: Get.find<ReportsControllerAdmin>()
                      .deductionResponseModel
                      .value
                      .details
                      ?.id ??
                  1,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      height: 260,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Expanded(
                                child: MedicalTitleTag(
                                  branch: 'Branch',
                                  name: 'Akhil Reubro',
                                  employmentId: '0045786',
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                kFundDeductionsString,
                                style: kTextStyleS12W600CcustomGrey,
                              ),
                              Text(
                                "\$${Get.find<ReportsControllerAdmin>().formatNumber(Get.find<ReportsControllerAdmin>().deductionResponseModel.value.details?.amount ?? '0')}",
                                style: kTextStyleS12W600CcustomGrey,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                kProfessionalTaxString,
                                style: kTextStyleS12W600CcustomGrey,
                              ),
                              Text(
                                "\$${Get.find<ReportsControllerAdmin>().formatNumber(Get.find<ReportsControllerAdmin>().deductionResponseModel.value.details?.amount ?? '0')}",
                                style: kTextStyleS12W600CcustomGrey,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Surcharge',
                                style: kTextStyleS12W600CcustomGrey,
                              ),
                              Text(
                                "\$${Get.find<ReportsControllerAdmin>().formatNumber(Get.find<ReportsControllerAdmin>().deductionResponseModel.value.details?.amount ?? '0')}",
                                style: kTextStyleS12W600CcustomGrey,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Advance',
                                style: kTextStyleS12W600CcustomGrey,
                              ),
                              Text(
                                "\$${Get.find<ReportsControllerAdmin>().formatNumber(Get.find<ReportsControllerAdmin>().deductionResponseModel.value.details?.amount ?? '0')}",
                                style: kTextStyleS12W600CcustomGrey,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  kTotalString,
                                  style: kTextStyleS13W600Cblue,
                                ),
                                Text(
                                  "\$${Get.find<ReportsControllerAdmin>().formatNumber(Get.find<ReportsControllerAdmin>().deductionResponseModel.value.details?.amount ?? '0')}",
                                  style: kTextStyleS13W600Cblue.copyWith(
                                      color: Colors.lightBlue),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.delete_outline_outlined,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add_circle_outline,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  kSizedBoxH10,
            ),
          ),
        ),
      ],
    );
  }
}
