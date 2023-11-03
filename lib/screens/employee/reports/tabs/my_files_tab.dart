import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:paytym/network/end_points.dart';
import 'package:paytym/screens/employee/reports/reports_controller.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/icons.dart';
import '../../../../core/constants/widgets.dart';
import '../../../../core/dialog_helper.dart';
import '../../../../routes/app_routes.dart';
import '../../../admin/reports/reports_controller.dart';
import 'package:path/path.dart' as path;

class MyFilesTab extends StatelessWidget {
  const MyFilesTab({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Get.find<ReportsController>().fetchFiles());
    WidgetsFlutterBinding.ensureInitialized();
    var file = Get.find<ReportsController>().filePath.value;
    Get.put(ReportsController());

    Get.put(ReportsControllerAdmin());
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
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
                          title:
                              Text(path.basename(files?[index].file ?? 'file')),
                          // title: Text(files?[index].filetype?.fileType ?? ''),
                          trailing: CircleAvatar(
                            backgroundColor: CustomColors.blueCardColor,
                            child: GestureDetector(
                              onTap: () {
                                //Download file
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
                          title:
                              Text(path.basename(files?[index].file ?? 'file')),
                          // title: Text(files?[index].filetype?.fileType ?? ''),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CircleAvatar(
                                  backgroundColor: CustomColors.blueCardColor,
                                  child: GestureDetector(
                                    onTap: () {
                                      print("Print Index:$index");
                                      // Get.find<ReportsController>().downloadPdf(
                                      //     '$kStorageUrl${files?[index].file}');
                                      // Get.find<ReportsController>()
                                      //     .clickedIndex = index;
                                      files?[index].isDownloading = true;
                                      Get.find<ReportsController>()
                                          .fileListResponseModel
                                          .refresh();
                                      Get.find<ReportsControllerAdmin>()
                                          .downloadFile(
                                        "emp_records",
                                        '$kStorageUrl${files?[index].file}',
                                        ((progress, total) {
                                          print(
                                              "Downloading File From URL:${kStorageUrl}${files?[index].file.toString()}");
                                          if (progress == total) {
                                            files?[index].isDownloading = false;
                                            Get.find<ReportsController>()
                                                .fileListResponseModel
                                                .refresh();
                                            DialogHelper.showToast(
                                                desc: 'Download completed');
                                          }
                                        }),
                                      );
                                    },
                                    child: files?[index].isDownloading ?? false
                                        ? Lottie.asset(IconPath.downloadingJson)
                                        : const Icon(
                                            Icons.download,
                                            color: CustomColors.whiteCardColor,
                                          ),
                                  ),
                                ),
                                kSizedBoxW10,
                                CircleAvatar(
                                  backgroundColor: CustomColors.redColor,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.find<ReportsController>()
                                          .deleteFiles(files?[index].id ?? -1);
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: CustomColors.whiteCardColor,
                                    ),
                                  ),
                                ),
                              ],
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
