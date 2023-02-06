import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/styles.dart';
import '../../../core/constants/widgets.dart';
import '../../../routes/app_routes.dart';
import 'reports_controller.dart';
import 'widgets/custom_progress_indicator.dart';

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
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 20, 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Landing Page',
                              style: kTextStyleS18W600.copyWith(
                                  color: CustomColors.blackTextColor),
                            ),
                            kSizedBoxH35,
                            Text(
                              'Team',
                              style: kTextStyleS14W600Cgrey300LS0p2.copyWith(
                                  color: Colors.black),
                            ),
                            kSizedBoxH8,
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.projectEmployeeList);
                              },
                              child: SizedBox(
                                width: 100,
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
                                        left: 20 * (index + 1),
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
                                                  ? const Text(
                                                      '+5',
                                                      style: TextStyle(
                                                          color: CustomColors
                                                              .lightBlueColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ).toList(),
                                  ],
                                ),
                              ),
                            ),
                            kSizedBoxH15,
                            const SizedBox(
                              child: ProgressBar(
                                current: 0.5,
                                max: 1,
                              ),
                            ),
                            kSizedBoxH4,
                            SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Progress',
                                    style: kTextStyleS14W600Cgrey300LS0p2
                                        .copyWith(color: Colors.black),
                                  ),
                                  Text(
                                    '30%',
                                    style: kTextStyleS14W600Cgrey300LS0p2
                                        .copyWith(color: Colors.black),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 10, bottom: 10, top: 10, left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              "Branch",
                              style: TextStyle(
                                color: CustomColors.blackTextColor,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                kSizedBoxH4,
                                const Text(
                                  "Due Date",
                                  style: TextStyle(
                                    color: CustomColors.grey156x3TextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                kSizedBoxH4,
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.schedule,
                                      size: 15,
                                      color: Colors.grey,
                                    ),
                                    kSizedBoxW4,
                                    Text(
                                      "30 January",
                                      style: TextStyle(
                                        color: CustomColors.blackTextColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                kSizedBoxH4,
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.calendar_month_outlined,
                                      size: 15,
                                      color: Colors.grey,
                                    ),
                                    kSizedBoxW4,
                                    Text(
                                      "February 10, 2023",
                                      style: TextStyle(
                                        color: CustomColors.blackTextColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Text(
                  "Total Cost: \$ 365,500",
                  style: TextStyle(
                    color: CustomColors.grey156x3TextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                kSizedBoxH20,
              ],
            ),
          );
        },
      ),
    );
  }
}
