import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/admin/reports/project_employee_list_page.dart';
import 'package:paytym/screens/admin/reports/reports_controller.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/constants/widgets.dart';
import '../../../../network/end_points.dart';
import '../../../../routes/app_routes.dart';
import '../widgets/custom_progress_indicator.dart';

class ProjectsTabAdmin extends StatelessWidget {
  const ProjectsTabAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Get.find<ReportsControllerAdmin>().fetchProjects());

    return Obx(() {
      final reportController = Get.find<ReportsControllerAdmin>();
      final projects =
          reportController.projectlistResponseModel.value.projectsLists;
      return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: projects?.length ?? 0,
          itemBuilder: (context, index) {
            var startDate = projects![index].startDate ?? '';
            var endDate = projects[index].endDate ?? '';
            reportController.findProjectProgress(startDate, endDate);
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
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
                                projects[index].name ?? '',
                                style: kTextStyleS18W600.copyWith(
                                    color: CustomColors.blackTextColor),
                              ),
                              kSizedBoxH10,
                              Text(
                                reportController
                                    .getStatus(projects[index].status ?? 0),
                                style: kTextStyleS15W600CGreen,
                              ),
                              kSizedBoxH10,
                              Text(
                                'Team',
                                style: kTextStyleS14W600Cgrey300LS0p2.copyWith(
                                    color: Colors.black),
                              ),
                              kSizedBoxH8,
                              GestureDetector(
                                onTap: () {
                                  reportController.projectName =
                                      projects[index].name ?? '';
                                  var project = projects[index];
                                  Get.to(ProjectEmployeeListPage(
                                    project: project,
                                  ));
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
                                        //3,
                                        projects[index].employeeproject!.length,
                                        (index) => Positioned(
                                          left: 20 * (index + 0),
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
                                                  backgroundImage: projects[
                                                              index]
                                                          .employeeproject!
                                                          .isEmpty
                                                      ? const NetworkImage('')
                                                      : NetworkImage(
                                                          '$kImageUrl${projects[index].employeeproject![index].user.image}'),
                                                  radius: 18,
                                                ),
                                                index == 2
                                                    ? Text(
                                                        '${projects[index].employeeproject!.length}',
                                                        style: const TextStyle(
                                                            color: CustomColors
                                                                .lightBlueColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                              SizedBox(
                                child: ProgressBar(
                                  current:
                                      reportController.currentProjectStatus,
                                  max: reportController.endProjectStatus == 0
                                      ? 1
                                      : reportController.endProjectStatus,
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
                                      reportController.projectPercentage.isNaN
                                          ? '0%'
                                          : '${reportController.projectPercentage}%',
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
                              Text(
                                projects[index].branch != null
                                    ? projects[index].branch!.name
                                    : "Branch",
                                style: const TextStyle(
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
                                    children: [
                                      const Icon(
                                        Icons.calendar_month_outlined,
                                        size: 15,
                                        color: Colors.grey,
                                      ),
                                      kSizedBoxW4,
                                      Text(
                                        projects[index].startDate ??
                                            'Not provided',
                                        style: const TextStyle(
                                          color: CustomColors.blackTextColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  kSizedBoxH4,
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month_outlined,
                                        size: 15,
                                        color: Colors.grey,
                                      ),
                                      kSizedBoxW4,
                                      Text(
                                        projects[index].endDate ??
                                            'Not provided',
                                        style: const TextStyle(
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
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Total Cost: \$ ${projects[index].budget}",
                            style: const TextStyle(
                              color: CustomColors.grey156x3TextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      kSizedBoxH12,
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Spent: \$ 5,500",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: CustomColors.grey156x3TextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  kSizedBoxH12,
                ],
              ),
            );
          });
    });
  }
}
