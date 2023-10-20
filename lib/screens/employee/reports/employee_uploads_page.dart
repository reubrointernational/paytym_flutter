import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/strings.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/core/extensions/camelcase.dart';
import 'package:paytym/screens/employee/reports/reports_controller.dart';

import '../../../core/colors/colors.dart';
import '../../../models/report/files/files_type_list.dart';
import 'package:path/path.dart' as path;

class EmployeeUploadFilesPage extends StatefulWidget {
  const EmployeeUploadFilesPage({super.key});

  @override
  State<EmployeeUploadFilesPage> createState() =>
      _EmployeeUploadFilesPageState();
}

class _EmployeeUploadFilesPageState extends State<EmployeeUploadFilesPage> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Get.find<ReportsController>().fetchFiles());
    Get.put(ReportsController());

    var file = Get.find<ReportsController>().filePath.value;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text('Upload Files'),
        backgroundColor: CustomColors.backgroundColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: const TextSpan(
                      text: 'File Type',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      children: [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    ),
                  ])),
              kSizedBoxH10,
              DecoratedBox(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: CustomColors.lightBlueColor,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 5),
                  child: FutureBuilder(
                    future: Get.find<ReportsController>().fetchFileTypeList(),
                    builder: (BuildContext context,
                        AsyncSnapshot<FilesTypeListModel?> snapshot) {
                      return DropdownButtonHideUnderline(
                        child: DropdownButton<FileType>(
                          isExpanded: true,
                          value: snapshot.data?.fileTypes[
                              Get.find<ReportsController>()
                                  .selectedIndex
                                  .value],
                          onChanged: (FileType? value) {
                            if (value != null) {
                              Get.find<ReportsController>()
                                      .selectedIndex
                                      .value =
                                  snapshot.data!.fileTypes.indexOf(value);
                            }
                            setState(() {});
                          },
                          items: snapshot.data?.fileTypes
                              .map<DropdownMenuItem<FileType>>((value) {
                            return DropdownMenuItem<FileType>(
                              value: value,
                              child: Text(
                                value.fileType.isEmpty
                                    ? ''
                                    : value.fileType.toCamelCase(),
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              kSizedBoxH20,
              const Text(
                'Attachments',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              kSizedBoxH10,
              GestureDetector(
                // onTap: () =>
                // createChatController.uploadProfileImage(),
                child: DottedBorder(
                  strokeWidth: 1.5,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                  color: CustomColors.lightBlueColor,
                  dashPattern: const [10, 2],
                  child: InkWell(
                    onTap: Get.find<ReportsController>().fetchFilesFromPicker,
                    child: Container(
                        padding: const EdgeInsets.all(30),
                        child: Center(
                          child: SizedBox(
                            width: w * 0.5,
                            child: const Text(
                              'Upload Files',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: CustomColors.greyTextColor,
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
              ),
              kSizedBoxH10,
              Obx(() {
                return Container(
                  height: Get.find<ReportsController>().filePath.value.isEmpty
                      ? 0
                      : h * 0.3,
                  width: double.infinity,
                  color: Colors.transparent,
                  //child: Container(),
                  child: Get.find<ReportsController>().filePath.value.isEmpty
                      ? const SizedBox()
                      : Image.file(
                          File(Get.find<ReportsController>().filePath.value)),
                );
              }),
              kSizedBoxH6,
              Center(
                  child: Text(path.basename(
                      Get.find<ReportsController>().filePath.value.toString() ??
                          'file'))
                  // Text(getExactFilenameFromFilefullpath(
                  //     Get.find<ReportsController>().filePath.value.toString())),
                  ),
              kSizedBoxH12,
              Center(
                child: SizedBox(
                  width: w * 0.6,
                  height: h * 0.06,
                  child: ElevatedButton(
                    onPressed: () =>
                        Get.find<ReportsController>().uploadFiles(),
                    child: const Text('Upload'),
                  ),
                ),
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
