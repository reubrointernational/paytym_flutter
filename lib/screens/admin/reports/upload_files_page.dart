import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:paytym/core/constants/strings.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/admin/reports/reports_controller.dart';
import 'package:paytym/screens/admin/widgets/file_upload_widget.dart';
import 'package:paytym/screens/employee/reports/reports_controller.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/icons.dart';
import '../../../core/dialog_helper.dart';
import '../../../network/end_points.dart';
import '../widgets/custom_admin_scaffold.dart';
import 'package:path/path.dart' as path;

class UploadFilesPage extends StatelessWidget {
  const UploadFilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Get.find<ReportsController>()
            .fetchFiles(Get.find<ReportsControllerAdmin>().selectedEmployeeId));
    Get.put(ReportsController());

    var file = Get.find<ReportsController>().filePath.value;
    return CustomAdminScaffold(
      title: 'Upload Files',
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kSizedBoxH10,
              FileUploadWidget(
                title: 'File Type',
                subtitle: 'Upload files upto 4MB',
                onTap: () => Get.find<ReportsControllerAdmin>().fetchFiles(),
              ),
              kSizedBoxH10,
              Obx(
                () {
                  return Column(
                    children: [
                      Container(
                        height: Get.find<ReportsControllerAdmin>()
                                .filePath
                                .value
                                .isEmpty
                            ? 0
                            : h * 0.3,
                        width: double.infinity,
                        color: Colors.transparent,
                        //child: Container(),
                        child: Get.find<ReportsControllerAdmin>()
                                .filePath
                                .value
                                .isEmpty
                            ? const SizedBox()
                            : Image.file(File(Get.find<ReportsControllerAdmin>()
                                .filePath
                                .value)),
                      ),
                      // Text(Get.find<ReportsControllerAdmin>()
                      //     .filePath
                      //     .value
                      //     .toString()),
                      kSizedBoxH10,
                      Text(getExactFilenameFromFilefullpath(
                          Get.find<ReportsControllerAdmin>()
                              .filePath
                              .value
                              .toString())),
                    ],
                  );
                },
              ),
              kSizedBoxH20,
              Center(
                child: SizedBox(
                  width: w * 0.6,
                  height: h * 0.06,
                  child: ElevatedButton(
                    onPressed: () {
                      if (Get.find<ReportsControllerAdmin>()
                          .filePath
                          .value
                          .isNotEmpty) {
                        Get.find<ReportsControllerAdmin>().uploadFiles();
                      } else {
                        DialogHelper.showToast(
                            desc: "Please Select a file to Upload!");
                      }
                    },
                    child: const Text('Upload'),
                  ),
                ),
              ),
              kSizedBoxH20,
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
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: files?.length ?? 0,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                  backgroundColor: CustomColors.blueCardColor,
                                  child: GestureDetector(
                                    onTap: () {
                                      files?[index].isDownloading = true;
                                      Get.find<ReportsController>()
                                          .fileListResponseModel
                                          .refresh();
                                      Get.find<ReportsControllerAdmin>()
                                          .downloadFile("hr_rec",
                                              '$kStorageUrlForProfileImage${files?[index].file}',
                                              ((progress, total) {
                                        if (progress == total) {
                                          files?[index].isDownloading = false;
                                          Get.find<ReportsController>()
                                              .fileListResponseModel
                                              .refresh();
                                          DialogHelper.showToast(
                                              desc: 'Download completed');
                                        }
                                      }));
                                    },
                                    child: files?[index].isDownloading ?? false
                                        ? Lottie.asset(IconPath.downloadingJson)
                                        : const Icon(
                                            Icons.download,
                                            color: CustomColors.whiteCardColor,
                                          ),
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: CustomColors.redColor,
                                  child: GestureDetector(
                                    onTap: () {
                                      DialogHelper.showConfirmDialog(
                                        title: 'Delete File',
                                        desc:
                                            'Do you want to delete this file?',
                                        onConfirm: () {
                                          Get.find<ReportsControllerAdmin>()
                                              .deleteFiles(
                                                  files?[index].id ?? -1);
                                          Get.back();
                                        },
                                        onCancel: () => Get.back(),
                                      );
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
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: files?.length ?? 0,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                  backgroundColor: CustomColors.blueCardColor,
                                  child: GestureDetector(
                                    onTap: () {
                                      files?[index].isDownloading = true;
                                      Get.find<ReportsController>()
                                          .fileListResponseModel
                                          .refresh();
                                      Get.find<ReportsControllerAdmin>()
                                          .downloadFile("hr_rec",
                                              '$kStorageUrlForProfileImage${Get.find<ReportsController>().removingPublicFilePath(files![index].file.toString())}',
                                              ((progress, total) {
                                        if (progress == total) {
                                          files?[index].isDownloading = false;
                                          Get.find<ReportsController>()
                                              .fileListResponseModel
                                              .refresh();
                                          DialogHelper.showToast(
                                              desc: 'Download completed');
                                        }
                                      }));
                                    },
                                    child: files?[index].isDownloading ?? false
                                        ? Lottie.asset(IconPath.downloadingJson)
                                        : const Icon(
                                            Icons.download,
                                            color: CustomColors.whiteCardColor,
                                          ),
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: CustomColors.redColor,
                                  child: GestureDetector(
                                    onTap: () {
                                      DialogHelper.showConfirmDialog(
                                        title: 'Delete File',
                                        desc:
                                            'Do you want to delete this file?',
                                        onConfirm: () {
                                          Get.find<ReportsControllerAdmin>()
                                              .deleteFiles(
                                                  files?[index].id ?? -1);
                                          Get.back();
                                        },
                                        onCancel: () => Get.back(),
                                      );
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
      ),
    );
  }

  String getExactFilenameFromFilefullpath(String fullname) {
    String filePath = fullname;
    String fileName = path.basename(filePath);
    return fileName;
  }
}
