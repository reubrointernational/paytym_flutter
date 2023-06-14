import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:paytym/network/end_points.dart';
import 'package:paytym/screens/employee/reports/reports_controller.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/icons.dart';
import '../../../../routes/app_routes.dart';

class MyFilesTab extends StatelessWidget {
  const MyFilesTab({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Get.find<ReportsController>().fetchFiles());
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Office Records',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Obx(
              () {
                final files = Get.find<ReportsController>()
                    .fileListResponseModel
                    .value
                    .files
                    ?.where((element) => element.filetype?.visibleStatus == 1)
                    .toList();
                if (files?.isEmpty ?? true) {
                  return const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('No records found'),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: files?.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: ListTile(
                        title: Text(files?[index].filetype?.fileType ?? ''),
                        trailing: CircleAvatar(
                          backgroundColor: CustomColors.blueCardColor,
                          child: GestureDetector(
                            onTap: () {
                              Get.find<ReportsController>().downloadPdf(
                                  '$kStorageUrl${files?[index].file}');
                              Get.find<ReportsController>().clickedIndex =
                                  index;
                            },
                            child: Obx(() => Get.find<ReportsController>()
                                            .isSharingOrDownloading
                                            .value ==
                                        SharingOrDownloading.downloading &&
                                    Get.find<ReportsController>()
                                            .clickedIndex ==
                                        index
                                ? Lottie.asset(IconPath.downloadingJson)
                                : const Icon(
                                    Icons.download,
                                    color: CustomColors.whiteCardColor,
                                  )),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Employee Records',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Obx(
              () {
                final files = Get.find<ReportsController>()
                    .fileListResponseModel
                    .value
                    .files
                    ?.where((element) => element.filetype?.visibleStatus == 0)
                    .toList();
                if (files?.isEmpty ?? true) {
                  return const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('No records found'),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: files?.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: ListTile(
                        title: Text(files?[index].filetype?.fileType ?? ''),
                        trailing: CircleAvatar(
                          backgroundColor: CustomColors.blueCardColor,
                          child: GestureDetector(
                            onTap: () {
                              Get.find<ReportsController>().downloadPdf(
                                  '$kStorageUrl${files?[index].file}');
                              Get.find<ReportsController>().clickedIndex =
                                  index;
                            },
                            child: Obx(() => Get.find<ReportsController>()
                                            .isSharingOrDownloading
                                            .value ==
                                        SharingOrDownloading.downloading &&
                                    Get.find<ReportsController>()
                                            .clickedIndex ==
                                        index
                                ? Lottie.asset(IconPath.downloadingJson)
                                : const Icon(
                                    Icons.download,
                                    color: CustomColors.whiteCardColor,
                                  )),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
        Positioned(
          right: 20,
          bottom: 20,
          child: FloatingActionButton(
            onPressed: () {
              Get.toNamed(Routes.employeeUploadFilesPage);
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
