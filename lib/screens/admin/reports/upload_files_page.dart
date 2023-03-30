import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:paytym/core/constants/strings.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/core/extensions/camelcase.dart';
import 'package:paytym/screens/admin/reports/reports_controller.dart';
import 'package:paytym/screens/admin/widgets/file_upload_widget.dart';
import 'package:paytym/screens/employee/reports/reports_controller.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/enums.dart';
import '../../../core/constants/icons.dart';
import '../../../models/report/files/files_type_list.dart';
import '../../../network/end_points.dart';
import '../widgets/custom_admin_scaffold.dart';

class UploadFilesPage extends StatelessWidget {
  const UploadFilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Get.find<ReportsController>().fetchFileTypeListAndFetchFiles(
            Get.find<ReportsControllerAdmin>().selectedEmployeeId));
    Get.put(ReportsController());

    var file = Get.find<ReportsControllerAdmin>().filePath.value;
    return CustomAdminScaffold(
      title: 'Upload Files',
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            kSizedBoxH10,
            FileUploadWidget(
              title: 'File Name',
              subtitle: 'Upload files upto 4MB',
              onTap: () => Get.find<ReportsControllerAdmin>().fetchFiles(),
            ),
            kSizedBoxH10,
            Obx(() {
              return Container(
                height:
                    Get.find<ReportsControllerAdmin>().filePath.value.isEmpty
                        ? 0
                        : h * 0.3,
                width: double.infinity,
                color: Colors.transparent,
                //child: Container(),
                child: Get.find<ReportsControllerAdmin>().filePath.value.isEmpty
                    ? const SizedBox()
                    : Image.file(File(
                        Get.find<ReportsControllerAdmin>().filePath.value)),
              );
            }),
            kSizedBoxH35,
            SizedBox(
              width: w * 0.6,
              height: h * 0.06,
              child: ElevatedButton(
                onPressed: () =>
                    Get.find<ReportsControllerAdmin>().uploadFiles(),
                child: const Text('Upload'),
              ),
            ),
            kSizedBoxH15,
            Expanded(
              child: Obx(() {
                final files = Get.find<ReportsController>()
                    .fileListResponseModel
                    .value
                    .files;
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: files.length,
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
                        title: Text(Get.find<ReportsController>()
                            .filesTypeListModel
                            .value
                            .fileTypes
                            .firstWhere(
                              (element) =>
                                  files[index].fileTypeId == element.id,
                              orElse: () => FileTypes(fileType: '', id: 0),
                            )
                            .fileType),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                backgroundColor: CustomColors.blueCardColor,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.find<ReportsController>().downloadPdf(
                                        '$kStorageUrl${files[index].file}');
                                    Get.find<ReportsController>().clickedIndex =
                                        index;
                                  },
                                  child: Obx(() => Get.find<ReportsController>()
                                                  .isSharingOrDownloading
                                                  .value ==
                                              SharingOrDownloading
                                                  .downloading &&
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
                              CircleAvatar(
                                backgroundColor: CustomColors.redColor,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.find<ReportsControllerAdmin>()
                                        .deleteFiles(files[index].id);
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
              }),
            ),
          ],
        ),
      ),
    );
  }
}
