import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/strings.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/core/extensions/camelcase.dart';
import 'package:paytym/screens/admin/reports/reports_controller.dart';
import 'package:paytym/screens/admin/widgets/file_upload_widget.dart';

import '../widgets/custom_admin_scaffold.dart';

class UploadFilesPage extends StatelessWidget {
  const UploadFilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    var file = Get.find<ReportsControllerAdmin>().filePath.value;
    print(file.isEmpty);
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
                height: h * 0.3,
                width: double.infinity,
                color: Colors.transparent,
                //child: Container(),
                child: Get.find<ReportsControllerAdmin>().filePath.value.isEmpty
                    ? Container()
                    : Image.file(File(
                        Get.find<ReportsControllerAdmin>().filePath.value)),
              );
            }),
            kSizedBoxH35,
            SizedBox(
              width: w * 0.6,
              height: h * 0.06,
              child: ElevatedButton(
                onPressed: () => Get.find<ReportsControllerAdmin>().uploadFiles(),
                child: const Text('Upload'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
