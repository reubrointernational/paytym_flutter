import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:paytym/models/report/files/employee_files_list_model.dart';
import 'package:paytym/network/end_points.dart';
import 'package:paytym/screens/employee/reports/reports_controller.dart';

import '../../../../core/colors/colors.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/constants/icons.dart';

class MyFilesTab extends StatelessWidget {
  const MyFilesTab({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => Get.find<ReportsController>().fetchFiles());
    return Obx(() {
      final reportsController = Get.find<ReportsController>();
      final files = reportsController.fileListResponseModel.value.files;

      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: files.length,
        itemBuilder: (context, index) {
          return DownloadMyFiles(
            onTap: () {
              var reportsController = Get.find<ReportsController>();
              reportsController.downloadPdf('$kBaseUrl/${files[index].file}');
            },
            child: Obx(
                () => Get.find<ReportsController>()
                                .isSharingOrDownloading
                                .value ==
                            SharingOrDownloading.downloading
                    ? Lottie.asset(IconPath.downloadingJson)
                    : const Icon(
                        Icons.download,
                        color: CustomColors.whiteCardColor,
                      )),
          );
        },
      );
    });
  }
}

class DownloadMyFiles extends StatelessWidget {
  final void Function()? onTap;
  final Widget? child;
  const DownloadMyFiles({super.key, this.onTap, this.child});

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Payslip'),
        trailing: CircleAvatar(
          backgroundColor: CustomColors.blueCardColor,
          child: GestureDetector(
            onTap: onTap,
            child: child,
          ),
        ),
      ),
    );
  }
}
