import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/screens/employee/reports/reports_controller.dart';

import '../../../../core/colors/colors.dart';

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
            child: const ListTile(
              title: Text('Payslip'),
              trailing: CircleAvatar(
                backgroundColor: CustomColors.blueCardColor,
                child: Icon(Icons.download_outlined),
              ),
            ),
          );
        },
      );
    });
  }
}
