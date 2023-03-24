import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:paytym/network/end_points.dart';
import 'package:paytym/screens/employee/reports/reports_controller.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/icons.dart';
import '../../../../models/report/files/employee_files_list_model.dart';
import '../../../../models/report/files/files_type_list.dart';

class MyFilesTab extends StatelessWidget {
  const MyFilesTab({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Get.find<ReportsController>().fetchFileTypeListAndFetchFiles());
    return Obx(() {
      final files =
          Get.find<ReportsController>().fileListResponseModel.value.files;
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
                    (element) => files[index].fileTypeId == element.id,
                    orElse: () => FileTypes(fileType: '', id: 0),
                  )
                  .fileType),
              trailing: CircleAvatar(
                backgroundColor: CustomColors.blueCardColor,
                child: GestureDetector(
                  onTap: () {
                    Get.find<ReportsController>()
                        .downloadPdf('$kStorageUrl${files[index].file}');
                    Get.find<ReportsController>().clickedIndex = index;
                  },
                  child: Obx(() => Get.find<ReportsController>()
                                  .isSharingOrDownloading
                                  .value ==
                              SharingOrDownloading.downloading && Get.find<ReportsController>().clickedIndex == index
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
    });
  }
}
