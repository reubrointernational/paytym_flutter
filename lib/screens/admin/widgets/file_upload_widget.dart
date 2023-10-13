import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/extensions/camelcase.dart';
import 'package:paytym/screens/admin/reports/reports_controller.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../core/constants/widgets.dart';
import '../../../models/report/files/files_type_list.dart';

class FileUploadWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final TextEditingController? textController;
  final void Function()? onTap;
  const FileUploadWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    this.textController,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReportsControllerAdmin>();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.fetchFileTypeList());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(
                text: title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                children: const [
              TextSpan(
                text: ' *',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            ])),
        kSizedBoxH10,
        Visibility(
          visible: title != 'File Type',
          child: TextFormField(
            controller: textController,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                      width: 1, color: CustomColors.lightBlueColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                      width: 1, color: CustomColors.lightBlueColor),
                )),
          ),
        ),
        Visibility(
          visible: title == 'File Type',
          child: DecoratedBox(
            decoration: BoxDecoration(
                border: Border.all(
                  color: CustomColors.lightBlueColor,
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 5),
              child: DropdownButtonHideUnderline(
                child: Obx(() {
                  /* var list = controller
                      .fileTypeListResponseModel.value.fileTypes
                      .map((e) => e.fileType)
                      .toSet()
                      .toList();
                  print("lists: $list");*/
                  return controller
                          .fileTypeListResponseModel.value.fileTypes.isEmpty
                      ? const SizedBox()
                      : DropdownButton<FileType>(
                          isExpanded: true,
                          value: controller
                                  .fileTypeListResponseModel.value.fileTypes[
                              controller.fileNameDropdownIndex.value],
                          onChanged: (FileType? value) {
                            controller.fileNameDropdownIndex.value = controller
                                .fileTypeListResponseModel.value.fileTypes
                                .indexOf(value!);
                          },
                          items: controller
                              .fileTypeListResponseModel.value.fileTypes
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
                              })
                              .toSet()
                              .toList(),
                        );
                }),
              ),
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
        kSizedBoxH4,
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
              onTap: onTap,
              child: Container(
                  padding: const EdgeInsets.all(30),
                  child: Center(
                    child: SizedBox(
                      width: w * 0.5,
                      child: Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          color: CustomColors.greyTextColor,
                        ),
                      ),
                    ),
                  )),
            ),
          ),
        ),
        // kSizedBoxH6,
        // File name above the upload Image
        // const Text(
        //   'Filename :',
        //   style: TextStyle(
        //     fontSize: 16,
        //     color: Colors.black,
        //   ),
        // ),
        kSizedBoxH20,
      ],
    );
  }
}
