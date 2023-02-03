import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/styles.dart';
import '../../../core/constants/widgets.dart';
import 'reports_controller.dart';

class ProjectsTabAdmin extends StatelessWidget {
  const ProjectsTabAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Get.find<ReportsControllerAdmin>().getDeduction());
    return Obx(
      () => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: Get.find<ReportsControllerAdmin>()
                .deductionResponseModel
                .value
                .deductions
                ?.length ??
            0,
        itemBuilder: (context, index) {
          return Container(
            height: 170,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Landing Page',
                        style: kTextStyleS18W600.copyWith(
                            color: CustomColors.blackTextColor),
                      ),
                      kSizedBoxH8,
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.schedule,
                              size: 15,
                              color: Colors.grey,
                            ),
                            kSizedBoxW4,
                            Text(
                              'Due date: 30 January',
                              style: kTextStyleS14W600Cgrey300LS0p2.copyWith(
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      kSizedBoxH8,
                      Text(
                        '4 days left',
                        style: kTextStyleS14W600Cgrey300LS0p2.copyWith(
                            color: Colors.black),
                      ),
                      kSizedBoxH8,
                      SizedBox(
                        width: 200,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 19,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                backgroundColor: Colors.grey.shade300,
                                radius: 18,
                              ),
                            ),
                            ...List.generate(
                              3,
                              (index) => Positioned(
                                left: 32 * (index + 1),
                                child: CircleAvatar(
                                  radius: 19,
                                  backgroundColor: index == 2
                                      ? Colors.grey.shade300
                                      : Colors.white,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: index == 2
                                            ? Colors.white
                                            : Colors.grey.shade300,
                                        radius: 18,
                                      ),
                                      index == 2
                                          ? const Text('+5')
                                          : const SizedBox(),
                                    ],
                                  ),
                                ),
                              ),
                            ).toList(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 10, bottom: 25, top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Branch",
                        style: TextStyle(
                          color: CustomColors.blackTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.download_for_offline_outlined,
                              color: CustomColors.redColor,
                            )),
                      ),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: 0.8,
                              backgroundColor: Colors.grey.shade300,
                              color: Colors.lightBlue,
                            ),
                            const Text(
                              "80%",
                              style: TextStyle(
                                  color: CustomColors.lightBlueColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
