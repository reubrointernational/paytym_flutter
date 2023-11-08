import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/models/report/overtime_list_response_model.dart';
import 'package:paytym/screens/employee/reports/reports_controller.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants/styles.dart';
import '../../../../models/report/overtime/overtime_status-model.dart';
import '../../../../models/report/projects/projects_list_model.dart';
import '../../../../network/end_points.dart';
import '../../../admin/reports/project_employee_list_page.dart';
import '../../../admin/reports/reports_controller.dart';
import '../../../login/login_controller.dart';

class ProjectsTab extends StatelessWidget {
  const ProjectsTab({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ReportsController>().fetchProjects();
    });
    return Obx(() {
      // final reportController = Get.find<ReportsControllerAdmin>();
      Get.put(ReportsControllerAdmin());
      List<ProjectsList>? projects = Get.find<ReportsController>()
          .projectlistResponseModel
          .value
          .projectsLists;
      int prjListCount = 0;
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: projects?.length,
        itemBuilder: (context, index) {
          DateTime? startDate = projects![index].startDate;
          DateTime? endDate = projects[index].endDate;
          final projectDetails = projects?[index];
          prjListCount = projectDetails!.employeeproject!.length;
          bool noProjects = true;
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 1),
            child: Column(
              children: [
                for (ProjectsListEmployeeproject item
                    in projects[index].employeeproject ?? [])
                  Column(
                    children: [
                      if (item!.employeeId.toString() ==
                          // '15') for testing
                          '${Get.find<LoginController>().loginResponseModel?.employee?.id}')
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            children: [
                              // Text('Present : ${item!.id.toString()}'),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 20, 25),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            projects[index].name ?? '',
                                            style: kTextStyleS18W600.copyWith(
                                                color: CustomColors
                                                    .blackTextColor),
                                          ),
                                          kSizedBoxH10,
                                          Text(
                                            projects[index].branch != null
                                                ? projects[index]
                                                        .branch!
                                                        .name ??
                                                    ''
                                                : " ",
                                            style: const TextStyle(
                                              color:
                                                  CustomColors.blackTextColor,
                                            ),
                                          ),
                                          kSizedBoxH10,
                                          Visibility(
                                            visible: (projects[index]
                                                        .employeeproject
                                                        ?.length ??
                                                    0) >
                                                0,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Team',
                                                  style:
                                                      kTextStyleS14W600Cgrey300LS0p2
                                                          .copyWith(
                                                              color:
                                                                  Colors.black),
                                                ),
                                                kSizedBoxH8,
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.find<
                                                            ReportsControllerAdmin>()
                                                        .projectName = projects[
                                                                index]
                                                            .name ??
                                                        '';
                                                    var project =
                                                        projects[index];

                                                    Get.to(
                                                        ProjectEmployeeListPage(
                                                            project: project));
                                                  },
                                                  child: AvatarStack(
                                                    height: 50,
                                                    settings:
                                                        RestrictedAmountPositions(
                                                            maxAmountItems: 3,
                                                            minCoverage: 0.5),
                                                    infoWidgetBuilder:
                                                        (surplus) {
                                                      return CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: CircleAvatar(
                                                            radius: 23,
                                                            child: Text(
                                                              '+$surplus',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                                      );
                                                    },
                                                    avatars: [
                                                      for (ProjectsListEmployeeproject item
                                                          in projects[index]
                                                                  .employeeproject ??
                                                              [])
                                                        NetworkImage(
                                                            '$kStorageUrlForProfileImage${item.user?.image}')
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          kSizedBoxH4,
                                          // SizedBox(
                                          //   child: Row(
                                          //     mainAxisAlignment:
                                          //         MainAxisAlignment
                                          //             .spaceBetween,
                                          //     children: [
                                          //       Text(
                                          //         'Progress',
                                          //         style:
                                          //             kTextStyleS14W600Cgrey300LS0p2
                                          //                 .copyWith(
                                          //                     color:
                                          //                         Colors.black),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                  //Branch //start,end date.
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10,
                                          bottom: 10,
                                          top: 10,
                                          left: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            Get.find<ReportsController>()
                                                .getStatus(
                                                    projects[index].status ??
                                                        0),
                                            style: kTextStyleS15W600CGreen,
                                          ),

                                          // Padding(
                                          //   padding: const EdgeInsets.only(bottom: 20),
                                          //   child: IconButton(
                                          //       onPressed: () {},
                                          //       icon: const Icon(
                                          //         Icons.download_for_offline_outlined,
                                          //         color: CustomColors.redColor,
                                          //       )),
                                          // ),
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 20),
                                            child: kSizedBoxH2,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              kSizedBoxH4,
                                              const Text(
                                                "Start Date",
                                                style: TextStyle(
                                                  color: CustomColors
                                                      .grey156x3TextColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .calendar_month_outlined,
                                                    size: 15,
                                                    color: Colors.grey,
                                                  ),
                                                  kSizedBoxW4,
                                                  Text(
                                                    projects[index].startDate ==
                                                            null
                                                        ? 'Not Provided'
                                                        : DateFormat(
                                                                'dd-MM-yyyy')
                                                            .format(projects[
                                                                    index]
                                                                .startDate!),
                                                    style: const TextStyle(
                                                      color: CustomColors
                                                          .blackTextColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .calendar_month_outlined,
                                                    size: 15,
                                                    color: Colors.grey,
                                                  ),
                                                  kSizedBoxH4,
                                                  Text(
                                                    projects[index].startDate ==
                                                            null
                                                        ? 'Not Provided'
                                                        : DateFormat(
                                                                'dd-MM-yyyy')
                                                            .format(
                                                                projects[index]
                                                                    .endDate!),
                                                    style: const TextStyle(
                                                      color: CustomColors
                                                          .blackTextColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Text(
                                                "Due Date",
                                                style: TextStyle(
                                                  color: CustomColors
                                                      .grey156x3TextColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              kSizedBoxH4,
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total Cost: \$ ${projects[index].budget}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: CustomColors.grey156x3TextColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    kSizedBoxH12,
                                    Text(
                                      "Spent: \$ ${projects[index].expense?.toString() ?? 0}",
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                        color: CustomColors.grey156x3TextColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              kSizedBoxH12,
                            ],
                          ),
                        )
                    ],
                  ),
                // Project Name //Members

                // Total Cost Expense Row, no need to show to All employees
              ],
            ),
          );
        },
      );
    });
  }
}

class DetailsRow extends StatelessWidget {
  final String title;
  final String value;
  const DetailsRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
