import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paytym/core/constants/strings.dart';
import 'package:paytym/core/dialog_helper.dart';
import 'package:paytym/screens/admin/chat/chat_controller.dart';
import 'package:paytym/screens/admin/widgets/custom_admin_scaffold.dart';
import '../../../core/colors/colors.dart';
import '../../../core/constants/widgets.dart';
import '../dashboard/dashboard_controller.dart';
import '../reports/reports_controller.dart';
import '../widgets/file_upload_widget.dart';

class CreateGroupPage extends StatelessWidget {
  const CreateGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ReportsControllerAdmin());
    var memberList = Get.find<DashboardControllerAdmin>()
        .employeeList
        .value
        .employeeList
        .where((element) => Get.find<ChatControllerAdmin>()
            .selectedItemList
            .contains(Get.find<DashboardControllerAdmin>()
                .employeeList
                .value
                .employeeList
                .indexOf(element)))
        .toList();
    Get.find<ChatControllerAdmin>().members.value = memberList
        .map((member) => '${member.firstName} ${member.lastName}')
        .toList();
    print(Get.find<ChatControllerAdmin>().members.value);
    return CustomAdminScaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.find<ChatControllerAdmin>().createChatGroup(),
        backgroundColor: CustomColors.lightBlueColor,
        child: const Icon(
          Icons.done,
          color: CustomColors.whiteIconColor,
        ),
      ),
      title: 'Create New Group',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: memberList.isEmpty ? 0 : 60,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: memberList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      radius: 28,
                      backgroundImage:
                          NetworkImage(memberList[index].image ?? ''),
                    ),
                  );
                },
              ),
            ),
          ),
          kSizedBoxH10,
          FileUploadWidget(
            textController: Get.find<ChatControllerAdmin>().groupNameController,
            title: 'Group Name',
            subtitle: 'Upload a PNG, JPG or GIF Image of max 10MB',
            onTap: () {
              DialogHelper.showBottomSheet(
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  )),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...['Image', 'Camera'].map(
                        (e) => InkWell(
                          onTap: () => e == 'Image'
                              ? Get.find<ChatControllerAdmin>()
                                  .uploadProfileImageFromGallery()
                              : Get.find<ChatControllerAdmin>()
                                  .uploadProfileImageFromCamera(),
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey),
                              ),
                            ),
                            height: 60,
                            child: Center(
                                child: Text(
                              e,
                              style: const TextStyle(fontSize: 20),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          kSizedBoxH15,
          Obx(() {
            return Container(
              height: h * 0.35,
              width: w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border:
                    Border.all(width: 1.2, color: CustomColors.greyTextColor),
              ),
              child: Get.find<ChatControllerAdmin>().picker.value.isNotEmpty
                  ? Image.file(
                      File(Get.find<ChatControllerAdmin>().picker.value),
                      fit: BoxFit.contain,
                    )
                  : Container(
                      child: const Icon(
                        Icons.photo_outlined,
                        size: 50,
                        color: CustomColors.greyTextColor,
                      ),
                    ),
            );
          }),
        ]),
      ),
    );
  }
}
